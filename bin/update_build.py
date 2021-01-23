#!/usr/bin/env python3

import argparse
import configparser
import mako.exceptions
import mako.template
import pathlib
import re
import sys

ignoreFileRe = re.compile("\.?#.*")

def isRepository(rd):
    return rd.joinpath("project.cmake").exists()

def checkArgs(args):
    if not args.repo:
        rd = pathlib.Path(".").resolve()
        while rd and not isRepository(rd):
            rd = rd.parent
        args.repo = [rd,]

    for r in args.repo:
        if not isRepository(r.resolve()):
            print("Invalid Repository: %s" % (r.name,))
            return False

    args.pubfile = None
    for r in args.repo:
        pubfile = r.joinpath("src").joinpath("pubs").joinpath("%s.options" % (args.pub,))
        if pubfile.exists():
            args.pubfile = pubfile
            break

    if not args.pubfile:
        return False
            
    return True

class PubPackageGroup:
    def __init__(self, env, id, gdir):
        self.env = env
        self.id = id
        self.gdir = gdir
        self.packages = {}

    def package(self,pid):
        if pid in self.packages:
            return self.packages[pid]
        pdir = self.gdir.joinpath(pid)
        if pdir.exists:
            output = PubPackage(self,pid,pdir)
            self.packages[pid] = output
            return output

        return None

    def __str__(self):
        return "PackageGroup: %s in %s" % (self.id, self.gdir,)
        
class PubPackage:
    def __init__(self, group, id, pdir):
        self.group = group
        self.env = group.env
        self.fqid = "%s/%s" % (group.id,id,)
        self.id = id
        self.pdir = pdir

    def __str__(self):
        return "Package: %s in %s" % (self.id, self.pdir,)

    def findpackage(self,pid):
        if "/" in pid:
            # TODO: check deps
            return self.env.package(pid)
        else:
            # TODO: check package group deps
            return self.group.package(pid)
    
class Env:
    def __init__(self,args):
        self.repos = args.repo
        self.packagegroups = {}

    def packageGroup(self,gid):
        if gid in self.packagegroups:
            return self.packagegroups[gid]

        for r in self.repos:
            gdir = r.joinpath("src").joinpath("pubs").joinpath(gid)
            if gdir.exists():
                output = PubPackageGroup(self,gid,gdir)
                self.packagegroups[gid] = output
                return output
            
        return None

    def package(self,pid, group = None):
        if "/" in pid:
            gid,pid = pid.split("/")
            group = self.packageGroup(gid)
        if not group:
            return None
        return group.package(pid)

class PublicationOutline:
    def __init__(self):
        self.configs = []
        self.sections = {}

    def addconfig(self,config):
        self.configs.append(config)
        for section in config.sections():
            files = []
            for f in config.options(section):
                files.append(f)
            if section in self.sections:
                self.sections[section].extend(files)
            else:
                self.sections[section] = files

    def sectionfiles(self,section):
        if section in self.sections:
            return self.sections[section]
        else:
            return []
    
    
class PublicationSource:
    def __init__(self,package):
        self.package = package
        
        outlinefile = package.pdir.joinpath(f"{package.id}.outline")
        if outlinefile.exists():
            outline = configparser.ConfigParser(allow_no_value=True)
            outline.read_file(outlinefile.open())
            self.outline = outline
        else:
            self.outline = None

        optionsfile = package.pdir.joinpath(f"{package.id}.options")
        if optionsfile.exists():
            options = configparser.ConfigParser(allow_no_value=True)
            options.read_file(optionsfile.open())
            self.options = options
        else:
            self.options = None

        self.files = []
        if package.pdir.is_dir():
            for f in package.pdir.iterdir():
                if f.is_dir():
                    continue

                if ignoreFileRe.match(f.name):
                    continue

                if f.name.endswith(".outline") or f.name.endswith(".options"):
                    continue
            
                self.files.append( f )

    def __str__(self):
        return f"PublicationSource: {self.package.fqid}"


templateRe = re.compile("^%T%(.*)$")        
leadingPercentRe = re.compile("^(\\s*)(%+)(.*)$")
percentMarker = "-*junk*-"
dollarMarker = "-*dollar*-"
bsMarker = "-*bs*-"
def maptemplateline(l):
    # replace $, \, and the first % on a line with markers that will not be recognized by mako
    l = l.replace("\\$",dollarMarker).replace("\\\\",bsMarker)
    
    m = templateRe.match(l)
    if m:
        return m.group(1)

    m = leadingPercentRe.match(l)
    if m:
        return m.group(1) + percentMarker + m.group(2) + m.group(3)

    return l

def maptemplate(r):
    lines = r.split("\n")
    newlines = []
    
    for l in lines:
        newlines.append(maptemplateline(l))
        
    output = "\n".join(newlines)
    return output

def maprendered(r):
    lines = r.split("\n")
    newlines = []

    for l in lines:
        l = l.replace(percentMarker,"").replace(dollarMarker,"$").replace(bsMarker,"\\")
        newlines.append(l)

    return "\n".join(newlines)
    
class Publication:
    # Capture the options used to generate a publication
    
    def __init__(self,package,pub):
        self.package = package
        self.pub = pub
        self.basename = self.pub.split("/")[-1]

        self.source = PublicationSource(self.package)
        self.config = self.source.options

        self.sources = []
        self.addSource(self.source)

        self.outline = PublicationOutline()
        for source in self.sources:
            if source.outline:
                self.outline.addconfig(source.outline)

        self.madefiles = set()
        self.files = {}

    def addSource(self,source):
        self.sources.append(source)
        if source.options and source.options.has_section("dep"):
            for spackage in source.options["dep"]:
                spubpackage = source.package.findpackage(spackage)
                if not spubpackage:
                    print("Unknown package: %s" % (spubpackage,))
                    continue

                for s in self.sources:
                    if s.package == spubpackage:
                        print("Duplicate package: %s" % (spackage,))
                        continue

                subsource = PublicationSource(spubpackage)

                self.addSource(subsource)

    def loadFile(self,tofind):
        for source in self.sources:
            for f in source.files:
                fname = f.name
                istemplate = fname.endswith(".mako")

                if istemplate:
                    fname = fname[:-5]

                if fname == tofind:
                    if not self.makeFile(source,f):
                        return None
                    return self.files[fname]
        return None
                
    def makeFile(self,source,f):
        if (source.package.id,f.name) in self.madefiles:
            return True
        self.madefiles.add( (source.package.id,f.name) )
        
        fname = f.name
        istemplate = fname.endswith(".mako")

        if istemplate:
            fname = fname[:-5]

        fname = fname.replace(f"{source.package.id}-xxxxx",self.package.id)
        tof = self.builddir.joinpath(fname)

        if fname in self.files:
            print(f"DUPLICATE GENERATE FILE {tof}")
            return False

        self.files[fname] = tof

        if istemplate:
            if not self.generateFile(tof, f):
                return False
        else:
            if not self.linkFile(tof, f):
                return False

        return True
                
    def makeBuildDir(self,verbose):
        if not self.makeDirs(self.builddir):
            return False
        
        if not self.makeDirs(self.gendir):
            return False
        
        if not self.makeDirs(self.builddir.joinpath("listings")):
            return False

        for source in self.sources:
            for f in source.files:
                if not self.makeFile(source,f):
                    return False
        # clean out files that are not in self.files.values()

        return True
    
    def makeDirs(self,d):
        if not d.exists():
            d.mkdir(parents=True)
        return True
                    
    def linkFile(self,link,target):
        if not self.makeDirs(link.parent):
            return False
        
        lparents = list(link.parents)
        tparents = list(target.parents)
        if lparents[-1] == tparents[-1]:
            commonndx = 1
            while commonndx < len(lparents) and commonndx < len(tparents) and lparents[-commonndx-1] == tparents[-commonndx-1]:
                commonndx += 1
            root = lparents[-commonndx]

            rlink = link.relative_to(root)
            rtarget = target.relative_to(root)
            
            rel = pathlib.Path(".")
            for i in range(0,len(rlink.parts)-1):
                rel = rel.joinpath("..")
            rel = rel.joinpath(rtarget)
        else:
            rel = target

        if link.resolve() != target.resolve():
            if link.is_symlink() or link.exists():
                link.unlink()
            #print(f"    Making Link {link} -> {rel}")
            link.symlink_to(rel)

        return True
            
    def generateFile(self,outfile,templatefile):
        if not self.makeDirs(outfile.parent):
            return False

        templatedata = templatefile.open().read()
        t = mako.template.Template(templatedata,
                                   preprocessor=maptemplate)
    
        try:
            rendered = t.render(pub=self)
        except:
            print(f"Exception handling template: {templatefile}")
            traceback = mako.exceptions.RichTraceback()
            for (filename, lineno, function, line) in traceback.traceback:
                print(f"File {filename}, line {lineno}, in {function}")
                print(f"  {line}")
            print(f"{str(traceback.error.__class__.__name__)}: {traceback.error}")
            return False
    
        r = maprendered(rendered)

        if outfile.exists():
            currentdata = outfile.open().read()
        else:
            currentdata = None

        if r != currentdata:
            #print(f"    Updating template:{templatefile}->{outfile}")
            outfile.open("w").write(r)

        return True

def updateBuild(args):
    # args.pub: publication id
    # args.pubfile: options file for publication
    # args.repo: repositories to search

    env = Env(args)

    pubPackage = env.package("/".join(args.pub.split("/")[0:2]))

    pub = Publication(pubPackage,args.pub)
    pub.builddir = args.builddir
    pub.gendir = args.gendir

    if args.verbose:
        for source in pub.sources:
            print("  Source: %s" % (source,))
            for f in source.files:
                print("    File: %s" % (f,))


    if not pub.config.getboolean("lib","lib",fallback=False):
        success = pub.makeBuildDir(args.verbose)
        if not success:
            sys.exit(1)
                
#---------------------------------------main processing below
parser = argparse.ArgumentParser()
parser.add_argument("pub", type=str)
parser.add_argument("--repo", type=pathlib.Path, nargs="*")
parser.add_argument("--verbose", "-v", action="count", default=1)
parser.add_argument("--builddir",type=pathlib.Path)
parser.add_argument("--gendir",type=pathlib.Path)
args = parser.parse_args()

if not checkArgs(args):
    sys.exit(1)

if args.verbose:
    print("  Repositories: %s" % (args.repo,))
    print("  Publication: %s - %s" % (args.pub,args.pubfile,))
    print("  Build Dir: %s" % (args.builddir,))

updateBuild(args)

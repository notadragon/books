#!/usr/bin/env python3

import configparser
import mako.template
import pathlib
import re
import sys

togenerate = []
for f in sys.argv[1:]:
    togenerate.append(f)
    
class GeneratedBook:
    def __init__(self, optionsFile, config):
        self.name = None
        self.optionsFile = optionsFile
        self.config = config

        self.files = []

    def adddir(self,section,sectiondir):
        #print(f"  Adding Directory: {section}:{sectiondir}")
        if not sectiondir.is_dir():
            print(f"Not a directory: {sectiondir}")

        for f in sectiondir.iterdir():
            if f.is_dir():
                continue

            book.files.append( (section,f) )

        if section.startswith("source"):
            if not book.name:
                book.name = sectiondir.name

        outlinefile = sectiondir.joinpath(f"{sectiondir.name}.outline")
        if outlinefile.exists():
            #print(f"    Adding outline file {outlinefile}")
            outline = configparser.ConfigParser()
            outline.readfp(outlinefile.open())
            book.outline.addconfig(outline)
        
def symlink_to(link, target):
    rel = pathlib.Path(".")
    for i in range(0,len(link.parts)-1):
        rel = rel.joinpath("..")
    rel = rel.joinpath(target)

    if link.resolve() != target.resolve():
        if link.is_symlink() or link.exists():
            link.unlink()
        print(f"    Making Link {link} -> {rel}")
        link.symlink_to(rel)

templateRe = re.compile("^%T%(.*)$")        
leadingPercentRe = re.compile("^(\\s*)(%+)(.*)$")
percentMarker = "-*junk*-"
dollarMarker = "-*dollar*-"
bsMarker = "-*bs*-"
def maptemplateline(l):
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

class Outline:
    def __init__(self):
        self.configs = []
        self.all = []
        self.sections = {}

    def addconfig(self,config):
        self.configs.append(config)
        for section in config.sections():
            files = []
            for f in config.options(section):
                files.append(f)
            self.all.extend(files)
            if section in self.sections:
                self.sections[section].extend(files)
            else:
                self.sections[section] = files

    def sectionfiles(self,section):
        if section in self.sections:
            return self.sections[section]
        else:
            return []


pwd = pathlib.Path(".")
booksdir = pwd.joinpath("src").joinpath("books")

if togenerate:
    optionsFiles = []
    for f in togenerate:
        optionsFiles.append(booksdir.joinpath(f).joinpath(f"{f}.options"))
else:
    optionsFiles = booksdir.glob("*/*.options")

for optionsFile in optionsFiles:
    if not optionsFile.exists():
        print(f"Invalid options file: {optionsFile}")
        continue
    
    print(f"Options file {optionsFile}")

    config = configparser.RawConfigParser(allow_no_value=True)
    config.readfp(optionsFile.open())

    book = GeneratedBook(optionsFile,config)
    book.outline = Outline()

    book.basename = optionsFile.name[:-len(optionsFile.suffix)]
    
    book.builddir = pwd.joinpath("build").joinpath(book.basename)

    if not book.builddir.is_dir():
        print(f"  Making directory: {book.builddir}")
        book.builddir.mkdir(parents=True)

    book.outdir = book.builddir.joinpath("generated")
    if not book.outdir.is_dir():
        print(f"  Making directory: {book.outdir}")
        book.outdir.mkdir(parents=True)
        
    for section in config.sections():
        if section.startswith("source") or section.startswith("template"):
            sectiondir = booksdir.joinpath(config.get(section,"dir")) 
            book.adddir(section,sectiondir)

    book.adddir("options",booksdir.joinpath(book.basename))

    madefiles = set()
    for section,f in book.files:
        fname = f.name
        istemplate = fname.endswith(".mako")

        if istemplate:
            fname = fname[:-5]

        if section.startswith("template"):
            sectiondirname = config.get(section,"dir")
            fname = fname.replace(sectiondirname, book.basename)

        tof = book.builddir.joinpath(fname)

        if tof in madefiles:
            print(f"DUPLICATE GENERATE FILE {tof}")
            continue
        madefiles.add(tof)
        
        if istemplate:
            t = mako.template.Template(f.open().read(),
                                       preprocessor=maptemplate)

            r = maprendered(t.render(book=book))

            if tof.exists():
                currentdata = tof.open().read()
            else:
                currentdata = None

            if r != currentdata:
                print(f"    Updating template:{f}->{tof}")
                tof.open("w").write(r)
                
        else:
            #print(f"  File: {section}:{f} -> {tof}")

            symlink_to(tof,f)
            

            

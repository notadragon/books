#!/usr/bin/env python3

import argparse
import pathlib
import sys
import re
import subprocess

lstFnameRe = re.compile("(.*).tex-(\d+).lst")
batchRe = re.compile("// ----Batch: (.*)------")
ignoreRe = re.compile("// ----Ignore: (.*)------")
stdRe = re.compile("// ----Standards: (.*)------")
errorLinesRe = re.compile("// ----ErrorLines: (.*)------")
sourceRe = re.compile("// ----Listing start: (.*):(\d+)-----")
replaceStartRe = re.compile("// --- Replace")
replaceEndRe = re.compile("// --- End")
targetFileRe = re.compile("// ([A-Za-z0-9_]+).(h|cpp):")

class Env:
    def __init__(self,args):
        self.verbose = args.verbose
        self.listdir = args.listdir
        self.codedir = args.codedir

        self.lstfiles = [ f for f in self.listdir.iterdir() ]
        self.data = []

class ListingData:
    def __init__(self,f):
        self.f = f
        self.fname = f.name

        m = lstFnameRe.match(self.fname)
        self.sourceFile = m.group(1)
        self.lstnum = int(m.group(2))

        self.batch = f"l_{m.group(2)}"
        self.ignore = False
        self.standards = None

        self.sourceerrorlines = set()
        self.errorlines = set()
        
        self.data = open(f).readlines()
        for i,l in enumerate(self.data):
            m = batchRe.match(l)
            if m:
                self.batch = m.group(1)
                continue
            m = ignoreRe.match(l)
            if m:
                self.ignore = True
                continue
            m = stdRe.match(l)
            if m:
                self.standards = m.group(1).split(",")
                continue
            m = errorLinesRe.match(l)
            if m:
                for x in m.group(1).split(","):
                    self.sourceerrorlines.add(int(x))
            if "// Error," in l:
                if l.strip().startswith("// Error,"):
                    self.errorlines.add(i-1)
                else:
                    self.errorlines.add(i)

    def goodData(self, replacements):
        linedirective = None

        replacedata = None

        origFile = None
        firstLine = None

        for i,l in enumerate(self.data):
            if l.strip() in replacements:
                for rl in replacements[l.strip()]:
                    yield rl
                #TODO: add #line directive to restore position, if len(rl) > 1
                continue

            m = replaceStartRe.match(l)
            if m:
                replacedata = []
                continue
            if replacedata != None:
                m = replaceEndRe.match(l)
                if m:
                    #TODO: add #line directives if len(replacedata) > 2
                    replacements[replacedata[0].strip()] = replacedata[1:]
                    replacedata = None
                    continue
                replacedata.append(l)
                continue
            
            m = sourceRe.match(l)
            if m:
                origFile = m.group(1)
                origLine = int(m.group(2))
                linedirective = f"#line {origLine+1} \"{origFile}\"\n"

            if firstLine == None and not l.startswith("// ---"):
                if linedirective:
                    yield linedirective
                    linedirective = None
                firstLine = i

            comment = self.ignore
            if not comment and i in self.errorlines:
                comment = True
            if not comment and firstLine != None and ( (i - firstLine + 1) in self.sourceerrorlines):
                comment = True
            if comment:
                yield f"// {l.rstrip()}\n"
            else:
                yield l
                    
                    
class BatchData:
    def __init__(self,sourceFile,batch):
        self.sourceFile = sourceFile
        self.batch = batch
        self.listings = []

        self.compilers=[ "clang++-10", "gcc-9", ]
        self.standards=[ "c++11", "c++14", ]

        self.goodfiles = []
        
    def makeGoodFile(self,env):
        batchdir = env.codedir.joinpath(self.sourceFile).joinpath(self.batch)
        if not batchdir.exists():
            batchdir.mkdir(parents=True)

        if self.listings and self.listings[0].standards:
            self.standards = self.listings[0].standards

        goodfile = batchdir.joinpath(f"{self.batch}.cpp")
        replacements = {}
        goodlines = [ l for lstf in self.listings for l in lstf.goodData(replacements) ]

        goodfile.open("w").writelines(goodlines)

        self.goodfiles.append(goodfile)
        
        return True

    def compileGoodFiles(self,env):
        good = set()
        bad = set()
        for goodfile in self.goodfiles:
            for compiler in self.compilers:
                for standard in self.standards:
                    ofile = goodfile.with_name(f"{goodfile.name}.{compiler}.{standard}.o")
                    outfile = goodfile.with_name(f"{goodfile.name}.{compiler}.{standard}.out")

                    args = [ compiler, "-c", f"-std={standard}", "-o", ofile.name, goodfile.name,]

                    #print(f"  Executing: {args}")
                    result = subprocess.call(args, stderr=outfile.open("w"), cwd=goodfile.parent)
                    if result:
                        bad.add( (goodfile.name, compiler, standard) )
                    else:
                        good.add( (goodfile.name, compiler, standard) )
        if bad:
            print(f"{self.sourceFile}/{self.batch}: [Errors: {len(bad)}/{len(bad) + len(good)}]")
            
            return False
        else:
            return True
                    

def checkListings(args):
    env = Env(args)

    sourceRe=re.compile(args.source)
    
    env.filedata = {}
    for f in env.lstfiles:
        m = lstFnameRe.match(f.name)
        if not m:
            print(f"Invalid listing File Name: {f}")
            continue

        m = sourceRe.search(m.group(1))
        if not m:
            continue
        
        env.data.append(ListingData(f))

    env.data.sort(key=lambda x : (x.sourceFile,x.batch,x.lstnum) )

    env.batches = {}
    for f in env.data:
        bkey = (f.sourceFile,f.batch)
        if bkey not in env.batches:
            env.batches[bkey] = BatchData(f.sourceFile,f.batch)
        bdata = env.batches[bkey]
        bdata.listings.append(f)

    batches = [ v for v in env.batches.values() ]
    batches.sort(key = lambda x : (x.sourceFile,x.batch) )

    allgood = True
    for b in batches:
        if not b.makeGoodFile(env):
            allgood = False
            continue

        if not b.compileGoodFiles(env):
            allgood = False
            continue

    if not allgood:
        return False
        
        
            
#---------------------------------------main processing below
parser = argparse.ArgumentParser()
parser.add_argument("--verbose", "-v", action="count", default=1)
parser.add_argument("--listdir", type=pathlib.Path)
parser.add_argument("--codedir", type=pathlib.Path)
parser.add_argument("--source", type=str, default=".*")
args = parser.parse_args()

if args.verbose:
    print("  ListDir: %s" % (args.listdir,))
    print("  CodeDir: %s" % (args.codedir,))
    print("  Sources: %s" % (args.source,))
    
checkListings(args)

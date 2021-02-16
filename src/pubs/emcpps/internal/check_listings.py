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
outputFileRe = re.compile("// ----OutputFile: (.*)------")

headerRe = re.compile("// ----(Batch|Ignore|Standards|ErrorLines|OutputFile): (.*)------")


sourceRe = re.compile("// ----(?:Hidden )?Listing start: (.*):(\d+)-----")
replaceStartRe = re.compile("// --- Replace")
replaceEndRe = re.compile("// --- End")
targetFileRe = re.compile("// (([?:A-Za-z0-9_\\.]+).(?:h|cpp)):( .*)?")

class Env:
    def __init__(self,args):
        self.verbose = args.verbose
        self.listdir = args.listdir
        self.codedir = args.codedir

        self.lstfiles = [ f for f in self.listdir.iterdir() ]
        self.data = []

        self.shownErrorFiles = set()

class ListingData:
    def __init__(self,f):
        self.f = f
        self.fname = f.name

        m = lstFnameRe.match(self.fname)
        self.sourceFile = m.group(1)
        self.lstnum = int(m.group(2))

        self.batches = [ f"l_{int(m.group(2)):03}" ]
        self.ignore = False
        self.standards = None
        self.outputFile = None

        self.sourceerrorlines = set()
        self.errorlines = set()
        
        self.data = open(f).readlines()
        for i,l in enumerate(self.data):
            m = batchRe.match(l)
            if m:
                self.batches = m.group(1).split(",")
                continue

            m = ignoreRe.match(l)
            if m:
                self.ignore = True
                continue

            m = stdRe.match(l)
            if m:
                self.standards = m.group(1).split(",")
                continue

            m = outputFileRe.match(l)
            if m:
                self.outputFile = m.group(1)
                continue
            
            m = errorLinesRe.match(l)
            if m:
                for x in m.group(1).split(","):
                    self.sourceerrorlines.add(int(x))

            if "// Error" in l:
                if l.strip().startswith("// Error"):
                    self.errorlines.add(i-1)
                else:
                    self.errorlines.add(i)

    def goodData(self, replacements):
        currentOutFile = self.outputFile

        replacedata = None

        origFile = None
        origLine = -1;
        firstLine = -1
        
        for i,l in enumerate(self.data):
            m = sourceRe.match(l)
            if m:
                origFile = m.group(1)
                origLine = int(m.group(2))
                continue

            m = headerRe.match(l)
            if m:
                continue

            origLine = origLine + 1
            if firstLine < 0:
                firstLine = i

            if l.strip() in replacements:
                for rl in replacements[l.strip()]:
                    yield (currentOutFile,) + rl
                continue

            m = replaceStartRe.match(l)
            if m:
                replacedata = []
                continue
            if replacedata != None:
                m = replaceEndRe.match(l)
                if m:
                    replacements[replacedata[0][-1].strip()] = replacedata[1:]
                    replacedata = None
                    continue
                replacedata.append( (origFile,origLine,l) )
                continue

            m = targetFileRe.match(l)
            if m:
                currentOutFile = m.group(1)
                continue
                
            comment = self.ignore
            # errorlines is based on index in lst file
            if not comment and i in self.errorlines:  
                comment = True
            # sourceerrorlines is based on offset in original source listing from the start
            if not comment and firstLine != None and ( (i - firstLine + 1) in self.sourceerrorlines):
                comment = True
            if comment:
                yield (currentOutFile,origFile,origLine,f"// {l.rstrip()}\n")
            else:
                yield (currentOutFile,origFile,origLine,l)
                    
                    
class BatchData:
    def __init__(self,sourceFile,batch):
        self.sourceFile = sourceFile
        self.batch = batch
        self.listings = []

        self.compilers=[ "clang++-10", "gcc-10", ]
        self.standards=[ "c++11", "c++14", ]

        self.goodfiles = []
        
    def makeGoodFile(self,env):
        batchdir = env.codedir.joinpath(self.sourceFile).joinpath(self.batch)
        if not batchdir.exists():
            batchdir.mkdir(parents=True)

        lststandards = None
        for lst in self.listings:
            if lst.standards:
                if lststandards == None:
                    lststandards = set(lst.standards)
                else:
                    lststandards = lststandards.intersection(set(lst.standards))

        if lststandards != None:
            self.standards=list(lststandards)

        goodfile = batchdir.joinpath(f"{self.batch}.cpp")
        replacements = {}
        files = {}

        for f,s,ln,l in [ l for lstf in self.listings for l in lstf.goodData(replacements) ]:
            if not f in files:
                files[f] = []
            files[f].append((s,ln,l))

        def processSourceLines(lines):
            currents = None
            currentln = -1
            for s,ln,l in lines:
                if currents != s or currentln != ln-1:
                    yield f"#line {ln} \"{s}\"\n"
                currents = s
                currentln = ln
                yield l
                
            
        for f,lines in files.items():
            if f == None:
                f = goodfile
            else:
                f = batchdir.joinpath(f)
            f.open("w").writelines([ l for l in processSourceLines(lines)])
            self.goodfiles.append(f)
        
        return True

    def compileGoodFiles(self,env):
        good = set()
        bad = set()

        firstbadfile = None
        firstbadoutput = None
        
        for goodfile in self.goodfiles:
            for compiler in self.compilers:
                for standard in self.standards:
                    ofile = goodfile.with_name(f"{goodfile.name}.{compiler}.{standard}.o")
                    outfile = goodfile.with_name(f"{goodfile.name}.{compiler}.{standard}.out")

                    # Since we compile header files, we must pass "-x c++" explicitly to always force C++
                    # We also add "-I." to allow includes between files in the same batch.
                    args = [ compiler, "-c", "-I.", "-x", "c++", f"-std={standard}", "-o", ofile.name, goodfile.name,]

                    #print(f"  Executing: {args}")
                    result = subprocess.call(args, stderr=outfile.open("w"), cwd=goodfile.parent)
                    if result:
                        bad.add( (goodfile.name, compiler, standard) )

                        firstbadfile = goodfile
                        firstbadoutput = outfile
                    else:
                        good.add( (goodfile.name, compiler, standard) )
        if bad:
            print(f"{self.sourceFile}/{self.batch}: [Errors: {len(bad)}/{len(bad) + len(good)}]")

            if env.verbose > 2 or (env.verbose == 2 and not self.sourceFile in env.shownErrorFiles):
                env.shownErrorFiles.add(self.sourceFile)

                print(f"  Error in source: {firstbadfile.absolute()}")
                print(f"  Error file: {firstbadoutput.name}")
                for l in firstbadoutput.open().readlines():
                    print(f"  {l.rstrip()}")
            
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

    if env.codedir.exists():
        print(f"Cleaning code dir {env.codedir}")
        
    env.data.sort(key=lambda x : (x.sourceFile,x.lstnum) )

    env.batches = {}
    for f in env.data:
        for batch in f.batches:
            bkey = (f.sourceFile,batch)
            if bkey not in env.batches:
                env.batches[bkey] = BatchData(f.sourceFile,batch)
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
parser.add_argument("--verbose", "-v", action="count", default=2)
parser.add_argument("--listdir", type=pathlib.Path)
parser.add_argument("--codedir", type=pathlib.Path)
parser.add_argument("--source", type=str, default=".*")
args = parser.parse_args()

if args.verbose:
    print("  ListDir: %s" % (args.listdir,))
    print("  CodeDir: %s" % (args.codedir,))
    print("  Sources: %s" % (args.source,))
    
checkListings(args)

#!/usr/bin/env python3

import argparse
import pathlib
import re
import sys

# commands we care about:
#   romeogloss/romeoglossf
#   emcppsgloss/emcppsglossgloss
#   newglossaryentry/longnewglossaryentry

commandRe = re.compile("\\\\(romeoglossf|romeogloss|emcppsglossgloss|emcppsgloss|newglossaryentry|longnewglossaryentry)")
wsRe = re.compile("\\s+")

lstInlineRe = re.compile("\\\\lstinline!(.*)!")
latexRe = re.compile("\\\\(.*)\{(.*)\}")
parentheticalsRe = re.compile("\\(.*\\)")

def cleanupText(s):
    s = wsRe.sub(" ",s.strip())
    while s[0] == "{" and s[-1] == "}":
        s = s[1:-1]
    return s

def stripMarkup(s):
    s = lstInlineRe.sub("\\1",s)
    s = latexRe.sub("\\2",s)
    s = parentheticalsRe.sub("",s)
    s = s.replace("\\-","").replace("-"," ").replace("$","")
    return cleanupText(s)

def makeEntryName(gid):
    if gid == gid.upper():
        return gid
    else:
        return gid.title()

def doTakeArg(self,data,pos,brackets,outlist):
    if data[pos] != brackets[0]:
        return None

    pos = pos + 1
    start = pos
    
    depth = 0
    while pos < len(data):
        if data[pos] in "[{":
            depth = depth + 1
        elif depth > 0 and data[pos] in "]}":
            depth = depth - 1
        elif depth == 0 and data[pos] == brackets[-1]:
            outlist.append(data[start:pos])
            return pos + 1
        pos = pos + 1
            
    return None

def doParseTexList(args):
    while args[0] == "{" and args[-1] == "}":
        args = args[1:-1]
        
    output = []
    pos = 0
    while pos < len(args):
        estart = pos
        depth = 0
        while pos < len(args):
            if args[pos] in "[{":
                depth = depth + 1
            elif depth > 0 and args[pos] in "]}":
                depth = depth - 1
            elif depth == 0 and args[pos] == ",":
                break
            pos = pos + 1
        entry = args[estart:pos]
        while entry[0] == "{" and entry[-1] == "}":
            entry = entry[1:-1]
        if entry:
            output.append(entry)
        if pos < len(args):
            pos = pos + 1
    return output

def doParseTexKV(args):
    output = {}

    pos = 0
    while pos < len(args):
        ndx = args.find("=", pos)
        if ndx < 0:
            key = args[pos:]
            pos = len(args)
        else:
            key = args[pos:ndx]
            pos = ndx+1

        depth = 0
        vstart = pos
        while pos < len(args):
            if args[pos] in "[{":
                depth = depth + 1
            elif depth > 0 and args[pos] in "]}":
                depth = depth - 1
            elif depth == 0 and args[pos] == ",":
                break
            pos = pos + 1
        value = args[vstart:pos].strip()
        while value[0] == "{" and value[-1] == "}":
            value = value[1:-1].strip()

        if pos < len(args):
            pos = pos + 1
        
        if key:
            output[key.strip()] = value
    return output

class EmcppsGlossRef:
    def __init__(self,gid,text):
        self.gid = gid
        self.text = text

    def check(self, step, env, f, ref):
        if step != 2:
            return
        
        text = cleanupText(self.text)

        gid = self.gid
        if not gid:
            gid = stripMarkup(text)
            if gid != gid.upper():
                gid = gid.lower()

        glossEntry = None
        if gid in env.words:
            glossEntry = env.words[gid]
        elif gid.endswith("s") and gid[:-1] in env.words:
            glossEntry = env.words[gid[:-1]]

        if glossEntry:
            gid = glossEntry.gid
            glossEntry.count = glossEntry.count + 1
        else:
            env.missingWords.add(gid)

        self.newgid = gid
        if gid == text:
            self.newtext = f"\\emcppsgloss{{{text}}}"
        else:
            self.newtext = f"\\emcppsgloss[{gid}]{{{text}}}"

        if self.newtext != f.outdata[ref.ndx]:
            print(f"{f.outdata[ref.ndx]} -> {self.newtext}")
            
            f.outdata[ref.ndx] = self.newtext

class EmcppsGlossEntry:
    def __init__(self,gid,args,long):
        self.gid = gid
        self.args = args
        self.long = long
        self.count = 0
        
        self.params = doParseTexKV(self.args)
        self.ids = [self.gid]
        
        if "alts" in self.params:
            self.alts = doParseTexList(self.params["alts"])
            self.alts.sort()
            self.ids.extend(self.alts)
        else:
            self.alts = None

    def check(self, step, env, f, ref):
        if step != 1:
            return
        
        for id in self.ids:
            env.words[id] = self
        env.entries.append(self)

    def makeMarkup(self):
        out = []

        name = self.params["name"]
        description = self.params["description"]

        if self.long:
            out.append(f"\\longnewglossaryentry{{{self.gid}}}{{\n")
        else:
            out.append(f"\\newglossaryentry{{{self.gid}}}{{\n")

        
        out.append(f"  name={{{name}}},\n")

        if self.alts:
            out.append(f"  alts={{")
            for n,alt in enumerate(self.alts):
                if n > 0:
                    out.append("        ")
                out.append(f"{{{alt}}},\n")
            out.append(f"       }},\n")
        
        out.append(f"  description={{\n")
        out.append(description)
        out.append(f"\n}}}}\n")
            
        
        return "".join(out)
    
def updateRG(step, env, f, ref):
    # romeogloss command
    if step == 0:
        ref.finalRef = EmcppsGlossRef(None, ref.args[0])

def updateEG(step, env, f, ref):
    # emcppsgloss command, optional arg is glossid
    if step == 0:
        if ref.optargs[0]:
            ref.finalRef = EmcppsGlossRef(ref.optargs[0], ref.args[0])
        else:
            ref.finalRef = EmcppsGlossRef(None, ref.args[0])

def updateGE(step, env, f, ref):
    # new glossary entry command,
    if step == 0:
        ref.finalRef = EmcppsGlossEntry(ref.args[0], ref.args[1], False)

def updateGEL(step, ref, env, f):
    # new glossary entry command,
    if step == 0:
        ref.finalRef = EmcppsGlossEntry(ref.args[0], ref.args[1], True)

argspecs = { "romeogloss" : (0, 1, updateRG),
             "romeoglossf" : (0, 1, updateRG),
             "emcppsgloss" : (1,1, updateEG),
             "emcppsglossgloss" : (1,1, updateEG),
             "newglossaryentry" : (0,2, updateGE),
             "longnewglossaryentry" : (0,2, updateGEL), }

class GlossRef:
    def __init__(self,pos,end,ndx,macro):
        self.macro = macro
        self.pos = pos
        self.end = end
        self.ndx = ndx

        self.optargs = []
        self.args = []

        self.finalRef = None

    def takeOptArg(self,data,pos):
        out = doTakeArg(self,data,pos,"[]",self.optargs)
        if out == None:
            self.optargs.append(None)
            return pos
        return out

    def takeArg(self,data,pos):
        return doTakeArg(self,data,pos,"{}",self.args)

    def takeArgs(self,data,pos):
        numoptargs,numargs = argspecs[self.macro][0:2]

        for i in range(0,numoptargs):
            pos = self.takeOptArg(data,pos)
            if pos == None:
                return None

        for i in range(0,numargs):
            pos = self.takeArg(data,pos)
            if pos == None:
                return None

        self.end = pos
        return pos

    def check(self,step,env,f):
        argspecs[self.macro][2](step,env,f,self)

        if self.finalRef:
            self.finalRef.check(step,env,f,self)
    
class DataFile:
    def __init__(self,f):
        self.f = f
        self.refs = []
        self.valid = False
        
    def load(self,env):
        self.orig = self.f.open().read()
        self.repl = []
        self.outdata = []
        
        pos = 0;
        while pos < len(self.orig):
            m = commandRe.search(self.orig,pos)
            if not m:
                self.outdata.append(self.orig[pos:])
                break

            self.outdata.append(self.orig[pos:m.start()])
                                    
            macro = m.group(1)
            pos = m.start()
            end = m.end()
            ref = GlossRef(pos,end,len(self.outdata),macro)

            pos = ref.takeArgs(self.orig,end)
            if pos == None:
                print(f"Invalid entry - {self.orig[m.start():m.start()+15]}")
                return None
            
            self.refs.append(ref)
            self.outdata.append(self.orig[ref.pos:ref.end])
            #print(f"{self.f}:{ref.pos} - {ref.macro} / {ref.optargs} - {ref.args}")

        self.valid = True

    def check(self,step,env):
        for ref in self.refs:
            ref.check(step,env,self)
        
    def update(self):
        if self.valid:
            newdata = "".join(self.outdata)
            if newdata != self.orig:
                print(f"{self.f}: Differences")
                
                self.f.open("w").write(newdata)
            
class Environment:
    def __init__(self):
        self.files = []
        self.glossfile = None
        
        self.words = {}
        self.entries = []
        self.missingWords = set()

    def makeGlossary(self):
        newglossdata = []

        for l in self.glossfile.orig.split("\n"):
            if l.startswith("%"):
                newglossdata.append(l)
                newglossdata.append("\n")
            else:
                break

        entries = self.entries[:]
        for mw in self.missingWords:
            mwname = makeEntryName(mw)
            print(f"Making new glossary entry for {mw}")
            entries.append(EmcppsGlossEntry(mw,f"name={{{mwname}}}, description={{TODO}}", False))
            entries[-1].count = 1
        entries.sort(key = lambda x : x.params["name"])

        for entry in entries:
            if entry.count == 0:
                print(f"Unused glossary entry for {entry.gid}")
            newglossdata.append("\n")
            newglossdata.append(entry.makeMarkup())

        self.glossfile.outdata = newglossdata        

def checkGlossary(args):
    env = Environment()

    dirs = ( pathlib.Path("../emcppsf").resolve(),
             pathlib.Path("../emcppsc").resolve() )

    for d in dirs:
        if not d.exists():
            print(f"Dir does not exist: {d}")
            return False
        for f in d.iterdir():
            if f.name.endswith(".tex"):
                env.files.append(DataFile(f))
            if f.name == "emcppsc-glossary.tex":
                env.glossfile = env.files[-1]
    env.files.append(DataFile(pathlib.Path("../internal/back-debug.tex").resolve()))
                
    for f in env.files:
        f.load(env)

    for step in range(0,4):
        for f in env.files:
            f.check(step,env)

    env.makeGlossary()
        
    for f in env.files:
        f.update()

    return True
        
#---------------------------------------main processing below
parser = argparse.ArgumentParser()
args = parser.parse_args()


checkGlossary(args)

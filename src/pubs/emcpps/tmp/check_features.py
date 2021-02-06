#!/usr/bin/env python3

import argparse
import pathlib
import sys
import re

def updatefile(tof, outlines):
    outlines = [ l.rstrip() + "\n" for l in outlines ]
    if tof.exists():
        tolines = tof.open().readlines()
        tolines = [ l.rstrip() + "\n" for l in tolines ]
    
        if tolines == outlines:
            return
            
        print(f"  Updating: {tof}")
        tof.open("w").writelines(outlines)

    else:
        print(f"  Creating: {tof}")
        tof.open("w").writelines(outlines)

featureRe = re.compile("\\\\emcppsFeature\\{(.*)\\}\\{(.*)\\}")
featureParamRe = re.compile("([a-z]+)=\\{(.*)\\}")

def translateTocShort(s):
    return s.replace("\\SecCode","\\TOCCode")

def translateTocLong(l):
    return l.replace("\\SecCode","\\TOCCode")

def translateRhShort(s):
    return s.replace("\\SecCode","\\RHCode")

def translateHeadingLong(l):
    return l

translations = (
    ("tocshort", "short", translateTocShort),
    ("toclong", "long", translateTocLong), 
    ("rhshort", "short", translateRhShort),
    ("headinglong", "long", translateHeadingLong),
    )

def findParams(s):
    while s:
        n = s.index("=")
        key = s[0:n]

        n = n + 1
        vstart = n
        depth = 0
        while n < len(s):
            c = s[n]
            if c == "{":
                depth = depth + 1
            elif c == "}":
                depth = depth - 1
            elif c == ",":
                if depth == 0:
                    break
            n = n + 1
        val = s[vstart:n]

        val = val.replace("\\tt","\\SecCode")

        if val[0] == "{" and val[-1] == "}":
            val = val[1:-1]
        
        yield (key, val)

        s = s[n+1:]

escapeRe = re.compile("(?:ù\\))|(?:\\(ù)")
        
def checkLine(f,n,l):
    escapes = list(escapeRe.findall(l))

    if escapes:
        if len(escapes) % 2 != 0:
            print(f"Invalid escapes {f}:{n}")
            return
        for i in range(0,len(escapes),2):
            if escapes[i] != "(ù" or escapes[i+1] != "ù)":
                print(f"Invalid escapes {f}:{n}")
    return
        
def checkFile(f):
    print(f"-----------------------{f.name}")

    lines = f.open().readlines()

    headerlines = []
    end = False
    newlines = None
    for l in lines:
        if newlines != None:
            newlines.append(l)
            continue
        headerlines.append(l)
        if l.startswith("}{"):
            newlines = []

    header = "".join([l.strip() for l in headerlines])
    m = featureRe.match(header)
    if not m:
        print(f"Invalid header {header}")
        return

    featureLabel = m.group(2)
    featureParamSpec = m.group(1)
    featureParams = {}
    
    for key,val in findParams(featureParamSpec):
        featureParams[key] = val

    newheader = []
    newheader.append(f"\emcppsFeature{{\n")

    for key,fromkey,tfunc in translations:
        oldval = featureParams[fromkey]
        newval = tfunc(oldval)
        if newval != oldval:
            newheader.append(f"    {key}={{{newval}}},\n")
    
    newheader.append(f"    short={{{featureParams['short']}}},\n")
    newheader.append(f"    long={{{featureParams['long']}}},\n")
    newheader.append(f"}}{{{featureLabel}}}\n")

    newlines = newheader + newlines

    for n,l in enumerate(newlines):
        checkLine(f,n,l)
    
    updatefile(f,newlines)

pwd = pathlib.Path(".").resolve()
for f in pwd.iterdir():
    if f.name.endswith(".tex"):
        checkFile(f)

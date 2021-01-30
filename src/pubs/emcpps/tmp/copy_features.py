#!/usr/bin/env python3

import re, pathlib, shutil

copyfiles = { "Ch0.tex", "emcppsc/emcppsc-ch0.tex",
              "Ch4.tex", "emcppsc/emcppsc-ch4.tex", }

masterfiles={ "Ch1.tex": "safe",
              "Ch2.tex": "conditionallysafe",
              "Ch3.tex": "unsafe", }
lversions=[ "cpp11", "cpp14" ]


outlineSectionRe = re.compile("\\[(.*)\\]")
outlineReplaceSectionRe = re.compile("(safe|conditionallysafe|unsafe)_(cpp11|cpp14)")
outline = []

inputRe = re.compile("^\\\\input\{(.*)\}$")

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

labelRe = re.compile("\\\\label\{(.*?)\}")
secRe = re.compile("\\\\section\[(.*?)\]\{(.*?)\}\\\\label\{(.*?)\}")
def processHead(lines):
    output = []
    shortTit = None
    longTit = None
    labels = []
    for l in lines:
        for lab in labelRe.findall(l):
            labels.append(lab)
        for sec in secRe.findall(l):
            shortTit = sec[0]
            longTit = sec[1]

    #print(f"SHORT: {shortTit}  LONG: {longTit}  LABELS: {labels}")

    output.append(f"\emcppsFeature{{")
    output.append(f"        short={{{shortTit}}},")
    output.append(f"        long={{{longTit}}},")
    output.append(f"}}{{{labels[0]}}}")

    for l in labels[1:]:
        output.append(f"\\label{{{l}}}")
    
    return output

for fname, sectionroot in masterfiles.items():
    vindex = 0
    flines = open(fname).readlines()
    currentsec = None
    outlines = []
    
    for l in flines:
        if "cftaddtitleline" and "C++11" in l:
            vindex = 0
            continue
        if "cftaddtitleline" and "C++14" in l:
            vindex = 1
            continue
        
        if l.startswith("\\newpage"):
            outlines = ["\\newpage"]
            continue
        m=inputRe.match(l)
        if not m:
            outlines.append(l)
            continue

        sec = sectionroot + "_" + lversions[vindex]
        inp = m.group(1)

        out = inp
        if out.endswith("-josh"):
            out = out[:-5]
        if out.endswith("-josh2"):
            out = out[:-6]

        outlines = processHead(outlines)
            
        fromf = pathlib.Path(f"{inp}.tex")
        tof = pathlib.Path(f"../emcppsf/emcppsf_{out}.tex")
        tof2 = pathlib.Path(f"../emcppsf/emcppsf_{out}.tex.bak")

        outlines.extend(open(fromf).readlines())

        print(f"{sec}: {fromf} -> {tof}")
        if sec != currentsec:
            currentsec = sec
            if outline:
                outline.append("")
            outline.append(f"[{sec}]")
        outline.append(f"emcppsf_{out}")


        updatefile(tof,outlines)
        outlines = []

        
outlinefile = pathlib.Path(f"../emcppsf/emcppsf.outline")

keep = False
for line in outlinefile.open().readlines():
    m = outlineSectionRe.match(line.rstrip())
    if m:
        outlinegroup = m.group(1)
        m2 = outlineReplaceSectionRe.match(outlinegroup)
        if m2:
            print(f"Dropping section {outlinegroup}")
            keep = False
        else:
            if not keep:
                outline.append("")
            keep = True

    if keep:
        outline.append(line)


outline = [ l.rstrip() + "\n" for l in outline ]
updatefile(outlinefile, outline)

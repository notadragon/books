#!/usr/bin/env python3

import re, pathlib, shutil

masterfiles={ "Ch1.tex": "safe",
              "Ch2.tex": "conditionallysafe",
              "Ch3.tex": "unsafe", }
lversions=[ "cpp11", "cpp14" ]


outline = []

inputRe = re.compile("^\\\\input\{(.*)\}$")

def updatefile(tof, outlines):
    outlines = [ l.strip() + "\n" for l in outlines ]
    if tof.exists():
        tolines = tof.open().readlines()
        tolines = [ l.strip() + "\n" for l in tolines ]
    
        if tolines == outlines:
            return
            
        print(f"  Updating: {tof}")
        tof.open("w").writelines(outlines)

    else:
        print(f"  Creating: {tof}")
        tof.open("w").writelines(outlines)


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
        
        fromf = pathlib.Path(f"{inp}.tex")
        tof = pathlib.Path(f"../emcppsf/emcppsf_{inp}.tex")
        tof2 = pathlib.Path(f"../emcppsf/emcppsf_{inp}.tex.bak")

        outlines.extend(open(fromf).readlines())

        print(f"{sec}: {fromf} -> {tof}")
        if sec != currentsec:
            currentsec = sec
            if outline:
                outline.append("")
            outline.append(f"[{sec}]")
        outline.append(f"emcppsf_{inp}")


        updatefile(tof,outlines)
        outlines = []

outline = [ l.strip() + "\n" for l in outline ]
outlinefile = pathlib.Path(f"../emcppsf/emcppsf.outline")

updatefile(outlinefile, outline)

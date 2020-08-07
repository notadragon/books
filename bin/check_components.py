#!/usr/bin/env python3

import pathlib
import re
import sys
import subprocess

listingRe = re.compile("([a-z][a-z0-9]{2})([a-z][a-z0-9]*)_(.*)_(tcpp|cpp|h)(?:_(.*))?.lst")
generatorStartRe = re.compile("//-+GENERATOR EXTRACT$")
generatorEndRe = re.compile("//-+END GENERATOR EXTRACT$")
generatedStartRe = re.compile("//-+GENERATED EXTRACT : (.*) (.*)$")

togenerate = []
for f in sys.argv[1:]:
    togenerate.append(f)

pwd = pathlib.Path(".")
srcdir = pwd.joinpath("src")
booksdir = srcdir.joinpath("books")
groupsdir = srcdir.joinpath("groups")

if togenerate:
    optionsFiles = []
    for f in togenerate:
        optionsFiles.append(booksdir.joinpath(f).joinpath(f"{f}.options"))
else:
    optionsFiles = booksdir.glob("*/*.options")

components = set()
    
for optionsFile in optionsFiles:
    if not optionsFile.exists():
        print(f"Invalid options file: {optionsFile}")
        continue
    
    print(f"Options file {optionsFile}")

    basename = optionsFile.name[:-len(optionsFile.suffix)]
    
    builddir = pwd.joinpath("build").joinpath(basename)
    listingsdir = builddir.joinpath("listings")
    
    listingsFiles = listingsdir.glob("*.lst")

    componentFiles = {}
    
    for lf in listingsFiles:
        m = listingRe.match(lf.name)
        if not m:
            print(f"Invalid listing file name {lf.name}")
            continue
        
        print(f"  Listings file {lf}")
        packagegroup = m.group(1)
        package = m.group(2)
        component = m.group(3)
        componentfile = m.group(4)
        part = m.group(5)
        extension = componentfile
        if componentfile == "tcpp":
            extension = "t.cpp"
            
        groupdir = groupsdir.joinpath(packagegroup)
        if not groupdir.exists():
            print(f"Creating package group {groupdir}")
            toexec = [ "make_packagegroup.py", packagegroup ]
            subprocess.check_call( toexec, cwd=srcdir )

        packagedir = groupdir.joinpath(f"{packagegroup}{package}")
        if not packagedir.exists():
            print(f"Creating package {packagedir}")
        
            toexec = [ "make_package.py", f"{packagegroup}{package}" ]
            subprocess.check_call( toexec, cwd=groupdir )

        cppfile = packagedir.joinpath(f"{packagegroup}{package}_{component}.{extension}")
        if not cppfile in componentFiles:
            componentFiles[cppfile] = []
            
        componentFiles[cppfile].append(lf.name[:-4])

    for cppfile,parts in componentFiles.items():
        print(f"  File: {cppfile}")

        componentname = cppfile.name[:-len(cppfile.suffix)]
        if componentname.endswith(".t"):
            componentname = componentname[:-2]
        
        if not cppfile.exists():
            toexec = [ "make_component.py", componentname ]
            subprocess.check_call( toexec, cwd = cppfile.parent)

        components.add( (cppfile.parent,componentname) )
        lines = cppfile.open().readlines()

        genbegin = None
        genend = None
        gensections = set()

        for i,l in enumerate(lines):
            m = generatorStartRe.match(l)
            if m:
                genbegin = i
            m = generatorEndRe.match(l)
            if m:
                genend = i
            m = generatedStartRe.match(l)
            if m:
                gensections.add( (m.group(1), m.group(2),))

        print(f"  Generator:{genbegin}-{genend} Found sections: {gensections}")

        newlines = lines[:]

        if not genbegin:
            for i,l in enumerate(lines):
                if "namespace BloombergLP" in l:
                    genbegin = i-1
                    break
        else:
            for i in range(genbegin,genend+1):
                newlines[i] = None
        if newlines[genbegin] != None:
            prefix = newlines[genbegin] + "\n"
            suffix = "\n"
        else:
            prefix = ""
            suffix = ""
        newlines[genbegin] = prefix + """//------------------------------------------------------------GENERATOR EXTRACT
// Grab the contents of the corresponding parts extracted from the LaTeX source
//..
//  #!/bin/bash
//
//  cat ../../../../build/$1/listings/$2.lst
//--------------------------------------------------------END GENERATOR EXTRACT
""" + suffix

        generatedend = 0
        for i,l in enumerate(lines):
            if l.startswith("namespace ") or "GENERATED" in l:
                generatedend = i

        for part in parts:
            if (basename,part) not in gensections:
                newlines[generatedend] = newlines[generatedend] + "\n" + f"""//--------GENERATED EXTRACT : {basename} {part}
//----END GENERATED EXTRACT : {basename} {part}
"""
        

        newlines2 = []
        for l in newlines:
            if l != None:
                for ll in l[:-1].split("\n"):
                    newlines2.append(ll.rstrip() + "\n")
        newlines = newlines2

        if lines != newlines:
            print(f"  Updating cpp file {cppfile}")
            cppfile.open("w").writelines(newlines)

        
for packagedir,component in components:
    toexec = [ "bde_do_format.py", "-a",
               packagedir.joinpath(f"{component}.h"),
               packagedir.joinpath(f"{component}.cpp"),
               packagedir.joinpath(f"{component}.t.cpp"), ]
    subprocess.check_call(toexec)

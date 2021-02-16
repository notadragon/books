#!/bin/bash

ODIR=../tmp-2021_02_15_done
TDIR=../tmp-2021_02_15

if [ -d "${ODIR}" ] ; then
    rm -r "${ODIR}"
fi

if [ ! -d "${ODIR}" ] ; then
    mkdir -p "${ODIR}"
fi

changes=( $(git diff HEAD~2 --name-only *.tex) )

for f in ${changes[@]}; do
    f=${f##*/}
    x=${f#*_}
    x=${x%.tex}
    echo "----------------------------${x}"

    tof=${ODIR}/${x}.tex
    if [ -f ${TDIR}/${x}-josh2.tex ] ; then
        oldf=${TDIR}/${x}-josh2.tex
        tof=${ODIR}/${x}-josh2.tex
    elif [ -f ${TDIR}/${x}-josh.tex ] ; then
        oldf=${TDIR}/${x}-josh.tex
        tof=${ODIR}/${x}-josh.tex
    else
        oldf=${TDIR}/${x}.tex
        tof=${ODIR}/${x}.tex
    fi

    echo "OLDF: ${oldf}"

    cat ${f} | tr $'\r' $'\n' > ${tof}
    if diff -w ${oldf} ${tof} ; then
        echo "NO CHANGE"
        rm "${tof}"
    fi
    echo
    
done

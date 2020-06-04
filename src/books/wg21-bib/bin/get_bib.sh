#!/bin/bash

WG21DIR=$(cd $(dirname $0); cd .. ; pwd)

echo "WG21DIR: ${WG21DIR}"
cd ${WG21DIR}

FETCHDIR="${WG21DIR}/fetch"

if [ ! -d "${FETCHDIR}" ] ; then
    echo "Making directory: ${FETCHDIR}"
    mkdir -p "${FETCHDIR}"
fi

declare -A BIBFILES=()

for year in $(seq 1989 $(date +%Y)) ; do
    #echo "  YEAR: ${year}"

    SRCFILE="${FETCHDIR}/${year}.html"
    URL="http://www.open-std.org/jtc1/sc22/wg21/docs/papers/${year}/"
    if [ ! -f "${SRCFILE}" ] ; then
        wget -O "${SRCFILE}" "${URL}"
    fi

    BIBTMP="${WG21DIR}/wg21-bib.bib.tmp"

    echo "% Sourced from: ${URL}" >> "${BIBTMP}"
    
    ${WG21DIR}/bin/parse_bib.py "${year}" "${URL}" "${SRCFILE}" >> "${BIBTMP}"

    BIBFILES[${BIBTMP}]=1
done

for BIBTMP in ${!BIBFILES[*]} ; do
    BIBFILE="${BIBTMP%.tmp}"
    
    if [ -f "${BIBTMP}" ] ; then
        if [ ! -f "${BIBFILE}" ] ; then
            echo "  Creating ${BIBFILE}"
            cp  "${BIBTMP}" "${BIBFILE}"
        elif ! diff -q "${BIBFILE}" "${BIBTMP}" > /dev/null ; then
            echo "  Updating ${BIBFILE}"
            cp  "${BIBTMP}" "${BIBFILE}"
        fi
        rm "${BIBTMP}"
    fi
done
    
            

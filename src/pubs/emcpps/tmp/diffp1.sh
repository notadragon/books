#!/bin/bash

ODIR=../tmp-p1_listings

rm -f "${ODIR}/*"
mkdir -p "${ODIR}"

for x in binaryliteral consecutiveangle decltype delete override staticassert trailingreturn unrestrictedunion noreturn nullptr ; do
    echo "----------------------------${x}"

    cp emcppsf_${x}.tex ${ODIR}/${x}.tex
    
  diff -w  ../tmp-2021_01_18/${x}.tex ${ODIR}/${x}.tex 
  echo
done

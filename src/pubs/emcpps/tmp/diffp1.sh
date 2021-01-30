#!/bin/bash

ODIR=../tmp-p1_listings

for x in binaryliteral consecutiveangle decltype delete override staticassert trailingreturn unrestrictedunion noreturn nullptr ; do
    echo "----------------------------${x}"

#    grep ù emcppsf_${x}.tex | sed -e "s/(ù//g" -e "s/ù)//g" | grep ù
    cat emcppsf_${x}.tex | grep -v emcppsFeature > ${ODIR}/${x}.tex
    
    diff -w  ../tmp-2021_01_18/${x}.tex ${ODIR}/${x}.tex 
    echo
done

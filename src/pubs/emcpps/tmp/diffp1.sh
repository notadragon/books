#!/bin/bash

for x in binaryliteral consecutiveangle decltype delete override staticassert trailingreturn unrestrictedunion noreturn nullptr ; do
  echo "----------------------------${x}"
  diff -w  ../tmp-2021_01_18/${x}.tex emcppsf_${x}.tex 
  echo
done

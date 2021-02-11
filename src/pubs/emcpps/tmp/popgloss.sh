#!/bin/bash


OUT=tmp-2021-02-11_gloss

if [ -d ${OUT} ] ; then
   rm -r ${OUT}
fi

mkdir -p ${OUT}

cp book/preamble-emcppssectioning.tex ${OUT}/
cp internal/preamble-glossary-internal.tex ${OUT}/preamble-glossary.tex
cp emcppsc/emcppsc-glossary.tex ${OUT}/glossary.tex
cp internal/back-glossary.tex ${OUT}/


for f in emcppsf_aggregateinit emcppsf_attribute emcppsf_ctordelegating emcppsf_default emcppsf_digitseparator emcppsf_localtypes emcppsf_longlong emcppsf_using ; do
    cp emcppsf/${f}.tex ${OUT}/${f#emcppsf_}.tex
done

ls ${OUT}

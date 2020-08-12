#!/bin/bash

function die()
{
    echo "${@}"
    exit 1
}

ROOTDIR=$(pwd)
TOBUILD=$1

./bin/generate.py ${TOBUILD} || die "Failed to generate latex source"

if [ -z "${TOBUILD}" ] ; then
    for D in $(ls build) ; do
        cd "${ROOTDIR}/build/${D}"
        make || die "Failed to build ${D}"
    done
else
    cd build/${TOBUILD}
    make || die "Failed to build"
    TOSHOW=1
fi

cd ${ROOTDIR}
./bin/check_components.py ${TOBUILD} || die "Failure checking extracted components"

cd ${ROOTDIR}
PGROUPS=$(cd src/groups; echo * | tr ' ' ',')

cd ${ROOTDIR}/..
build.sh --tests=run --targets=${PGROUPS} build || die "Failed to build ${PGROUPS}"

cd ${ROOTDIR}
if [ -n "${TOSHOW}" ] ;  then
   xdg-open generated/${TOBUILD}/${TOBUILD}.pdf
fi

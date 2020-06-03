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
fi

cd ${ROOTDIR}
./bin/check_components.py ${TOBUILD} || die "Failure checking extracted components"

xdg-open build/${TOBUILD}/generated/${TOBUILD}.pdf

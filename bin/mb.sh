#!/bin/bash

function die()
{
    echo "${@}"
    exit 1
}

TOBUILD=booksample-internal

./bin/generate.py ${TOBUILD} || die "Failed to generate latex source"

(
    cd build/${TOBUILD}
    make || die "Failed to build"
)

./bin/check_components.py ${TOBUILD} || die "Failure checking extracted components"

xdg-open build/${TOBUILD}/generated/${TOBUILD}.pdf

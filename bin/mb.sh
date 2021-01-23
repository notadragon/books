#!/bin/bash

function die()
{
    echo "${@}"
    exit 1
}

function diecat()
{
    echo "${1}"
    cat "${2}"
    exit 1
}

ROOTDIR=$(pwd)
while [ ! -f "${ROOTDIR}/project.cmake" ] ; do
    ROOTDIR=$(cd ${ROOTDIR}/..; pwd)
    if [ "${ROOTDIR}" = "/" ] ; then
        die "Not in valid repository"
    fi
done

FULL_0=$(type -p "$0")
BINDIR=$(cd "${FULL_0%/*}";pwd)
TOBUILD=""
SHOW=1

for arg in "${@}" ; do
    case "${arg}" in
        -clean)
            if [ -d "${ROOTDIR}/build" ] ; then
                rm -r "${ROOTDIR}/build"
            fi
            ;;
        -noshow)
            SHOW=0
            ;;
        *)
            TOBUILD="${arg}"
            ;;
    esac
done

PUBDIR=$(cd ${ROOTDIR}/src/pubs;pwd)

echo "BINDIR: ${BINDIR}"
echo "ROOTDIR: ${ROOTDIR}"
echo "PUBDIR: ${PUBDIR}"

if [ -z "${TOBUILD}" ] ; then
    GENARGS=( -name "*.options" )
else
    GENARGS=( -name "${TOBUILD}.options" )
fi

echo "GENARGS: ${GENARGS[@]}"

TOGEN=( $((cd ${PUBDIR} ; find "${GENARGS[@]}") | sed -e "s,./,," -e "s/.options//") )

if [ ${#TOGEN[@]} -eq 0 ] ; then
    die "No options file found"
fi

for togen in "${TOGEN[@]}" ; do
    echo "Generating: ${togen}"
    bdir="${ROOTDIR}/build/${togen}"
    gdir="${ROOTDIR}/generated/${togen}"
    
    ${BINDIR}/update_build.py ${togen} --repo "${ROOTDIR}" --builddir "${bdir}" --gendir "${gdir}" || die "Failed to generate ${togen}"
done

cd ${ROOTDIR}
PGROUPS=$(cd ${ROOTDIR}/src/groups; echo * | tr ' ' ',')

cd ${ROOTDIR}/..
echo build.sh --tests=run --targets=${PGROUPS} build || die "Failed to build ${PGROUPS}"

PDFS=()
for togen in "${TOGEN[@]}" ; do
    echo "Building: ${togen}"
    bdir="${ROOTDIR}/build/${togen}"
    gdir="${ROOTDIR}/generated/${togen}"
    if [ ! -d ${bdir} ] ; then
        #echo "No build dir: ${bdir}"
        continue
    fi

    cd ${bdir}
    make || die "Failed to build ${togen}" ${bdir}/${togen##*/}.log

    if [ -d "${gdir}" ] ; then
        PDFS+=( $(ls ${gdir}/*.pdf) )
    fi
done

for pdf in "${PDFS[@]}" ; do
    echo "Built PDF ${pdf}"
done

if [ ${#PDFS[@]} -eq 1 -a ${SHOW} -eq 1 ] ; then
    #
    if [ -d ~/public_html/tmp ] ; then
        ln -sf ${PDFS[0]} ~/public_html/tmp/current.pdf 
        echo "URL: http://192.168.17.56:4913/~berne/tmp/current.pdf"
    else
        xdg-open ${PDFS[0]}        
    fi    
fi


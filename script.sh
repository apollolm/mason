#!/usr/bin/env bash

MASON_NAME=lua
MASON_VERSION=5.2.0
MASON_LIB_FILE=lib/liblua.a

. ${MASON_DIR:-~/.mason}/mason.sh

function mason_load_source {
    mason_download \
        http://www.lua.org/ftp/lua-5.2.0.tar.gz \
        ad9eb521c2e364ab1b6727ed79265f51e23a600d

    mason_extract_tar_gz

    export MASON_BUILD_PATH=${MASON_ROOT}/.build/${MASON_NAME}-${MASON_VERSION}
}

function mason_compile {
    make generic CC=$CC CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" INSTALL_TOP=${MASON_PREFIX} install
}

function mason_cflags {
    echo "-I${MASON_PREFIX}/include"
}

function mason_ldflags {
    echo "-L${MASON_PREFIX}/lib -llua"
}

function mason_clean {
    make clean
}

mason_run "$@"

#!/usr/bin/env bash

set -e
set -x

# Delete directories belonging to other PHP versions

PHP_VER="${1}"

LIB_PHP74=/usr/lib/php/20190902
LIB_PHP80=/usr/lib/php/20200930
LIB_PHP81=/usr/lib/php/20210902

MOD_PHP74=/etc/php/7.4
MOD_PHP80=/etc/php/8.0
MOD_PHP81=/etc/php/8.1

if [[ ${PHP_VER} == 8.1 ]]; then
    rm -rf \
        ${LIB_PHP80} \
        ${LIB_PHP74} \
        \
        ${MOD_PHP80} \
        ${MOD_PHP74}

     exit 0
fi

if [[ ${PHP_VER} == 8.0 ]]; then
    rm -rf \
        ${LIB_PHP81} \
        ${LIB_PHP74} \
        \
        ${MOD_PHP81} \
        ${MOD_PHP74}

     exit 0
fi

if [[ ${PHP_VER} == 7.4 ]]; then
    rm -rf \
        ${LIB_PHP81} \
        ${LIB_PHP80} \
        \
        ${MOD_PHP81} \
        ${MOD_PHP80}

     exit 0
fi

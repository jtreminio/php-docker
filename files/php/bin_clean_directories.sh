#!/usr/bin/env bash

set -e
set -x

# Delete directories belonging to other PHP versions

PHP_VER="${1}"

LIB_PHP56=/usr/lib/php/20131226
LIB_PHP70=/usr/lib/php/20151012
LIB_PHP71=/usr/lib/php/20160303
LIB_PHP72=/usr/lib/php/20170718
LIB_PHP73=/usr/lib/php/20180731
LIB_PHP74=/usr/lib/php/20190902
LIB_PHP80=/usr/lib/php/20200930

MOD_PHP56=/etc/php/5.6
MOD_PHP70=/etc/php/7.0
MOD_PHP71=/etc/php/7.1
MOD_PHP72=/etc/php/7.2
MOD_PHP73=/etc/php/7.3
MOD_PHP74=/etc/php/7.4
MOD_PHP80=/etc/php/8.0

if [[ ${PHP_VER} == 8.0 ]]; then
    rm -rf \
        ${LIB_PHP56} \
        ${LIB_PHP70} \
        ${LIB_PHP71} \
        ${LIB_PHP72} \
        ${LIB_PHP73} \
        ${LIB_PHP74} \
        \
        ${MOD_PHP56} \
        ${MOD_PHP70} \
        ${MOD_PHP71} \
        ${MOD_PHP72} \
        ${MOD_PHP73} \
        ${MOD_PHP74}

     exit 0
fi

if [[ ${PHP_VER} == 7.4 ]]; then
    rm -rf \
        ${LIB_PHP56} \
        ${LIB_PHP70} \
        ${LIB_PHP71} \
        ${LIB_PHP72} \
        ${LIB_PHP73} \
        ${LIB_PHP80} \
        \
        ${MOD_PHP56} \
        ${MOD_PHP70} \
        ${MOD_PHP71} \
        ${MOD_PHP72} \
        ${MOD_PHP73} \
        ${MOD_PHP80}

     exit 0
fi

if [[ ${PHP_VER} == 7.3 ]]; then
    rm -rf \
        ${LIB_PHP56} \
        ${LIB_PHP70} \
        ${LIB_PHP71} \
        ${LIB_PHP72} \
        ${LIB_PHP74} \
        ${LIB_PHP80} \
        \
        ${MOD_PHP56} \
        ${MOD_PHP70} \
        ${MOD_PHP71} \
        ${MOD_PHP72} \
        ${MOD_PHP74} \
        ${MOD_PHP80}

     exit 0
fi

if [[ ${PHP_VER} == 7.2 ]]; then
    rm -rf \
        ${LIB_PHP56} \
        ${LIB_PHP70} \
        ${LIB_PHP71} \
        ${LIB_PHP73} \
        ${LIB_PHP74} \
        ${LIB_PHP80} \
        \
        ${MOD_PHP56} \
        ${MOD_PHP70} \
        ${MOD_PHP71} \
        ${MOD_PHP73} \
        ${MOD_PHP74} \
        ${MOD_PHP80}

     exit 0
fi

if [[ ${PHP_VER} == 7.1 ]]; then
    rm -rf \
        ${LIB_PHP56} \
        ${LIB_PHP70} \
        ${LIB_PHP72} \
        ${LIB_PHP73} \
        ${LIB_PHP74} \
        ${LIB_PHP80} \
        \
        ${MOD_PHP56} \
        ${MOD_PHP70} \
        ${MOD_PHP72} \
        ${MOD_PHP73} \
        ${MOD_PHP74} \
        ${MOD_PHP80}

     exit 0
fi

if [[ ${PHP_VER} == 7.0 ]]; then
    rm -rf \
        ${LIB_PHP56} \
        ${LIB_PHP71} \
        ${LIB_PHP72} \
        ${LIB_PHP73} \
        ${LIB_PHP74} \
        ${LIB_PHP80} \
        \
        ${MOD_PHP56} \
        ${MOD_PHP71} \
        ${MOD_PHP72} \
        ${MOD_PHP73} \
        ${MOD_PHP74} \
        ${MOD_PHP80}

     exit 0
fi

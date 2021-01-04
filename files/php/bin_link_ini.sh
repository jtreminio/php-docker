#!/usr/bin/env bash

set -e
set -x

# Manage INI files

PHP_VER="${1}"

EXTRA_MODS=(
    amqp
    apcu
    apcu_bc
    gd
    geoip
    gnupg
    imagick
    mailparse
    memcached
    mongodb
    oauth
    pdo_sqlite
    radius
    raphf
    redis
    soap
    solr
    sqlite3
    ssh2
    stomp
    uploadprogress
    uuid
    zmq
    xdebug
)

# Modules available only to PHP 7.0 and 7.1
if [[ ${PHP_VER} == 7.1 ]] || [[ ${PHP_VER} == 7.0 ]]; then
    EXTRA_MODS+=(
        lua
        mcrypt
        sodium
    )
fi

# Modules available only to PHP 7.2
if [[ ${PHP_VER} == 7.2 ]]; then
    EXTRA_MODS+=(
        lua
    )
fi

# These modules not available on PHP 8.0
if [[ ${PHP_VER} == 8.0 ]]; then
    REMOVE_MODS=(
        apcu_bc
        geoip
        gnupg
        radius
        ssh2
        stomp
        uploadprogress
    )
    for REM in ${REMOVE_MODS[@]}
    do
       EXTRA_MODS=("${EXTRA_MODS[@]/$REM}")
    done
fi

install -d -m 0755 \
    /etc/php/extra-mods \
    /p

for MOD in "${EXTRA_MODS[@]}"
do
    if [[ ! -z ${MOD} ]]; then
        install -d -m 0755 "/etc/php/extra-mods/${MOD}"
        mv "/etc/php/${PHP_VER}/mods-available/${MOD}.ini" "/etc/php/extra-mods/${MOD}/"
        ln -s "/etc/php/extra-mods/${MOD}" "/p/${MOD}"
    fi
done

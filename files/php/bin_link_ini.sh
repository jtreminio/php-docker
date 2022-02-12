#!/usr/bin/env bash

set -e
set -x

# Manage INI files

PHP_VER="${1}"

EXTRA_MODS=(
    amqp
    apcu
    gd
    imagick
    mailparse
    memcached
    mongodb
    oauth
    pdo_sqlite
    raphf
    redis
    soap
    solr
    sqlite3
    uuid
    zmq
    xdebug
)

# These modules not available on > PHP 7.4
if [[ ${PHP_VER} == 7.4 ]]; then
    EXTRA_MODS+=(
        apcu_bc
        geoip
        gnupg
        radius
        ssh2
        stomp
        uploadprogress
    )
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

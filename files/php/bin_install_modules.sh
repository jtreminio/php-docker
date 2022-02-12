#!/usr/bin/env bash

set -e
set -x

# Installs most common modules

PHP_VER="${1}"

# These modules are installed and enabled by default
MODULES_DEFAULT="
    php${PHP_VER}-bcmath
    php${PHP_VER}-cli
    php${PHP_VER}-curl
    php${PHP_VER}-intl
    php${PHP_VER}-mbstring
    php${PHP_VER}-mysql
    php${PHP_VER}-opcache
    php${PHP_VER}-xml
    php${PHP_VER}-zip
"

# These modules must have their INI directories included via PHP_INI_SCAN_DIR
MODULES_OPTIONAL="
    php${PHP_VER}-amqp
    php${PHP_VER}-apcu
    php${PHP_VER}-gd
    php${PHP_VER}-igbinary
    php${PHP_VER}-imagick
    php${PHP_VER}-mailparse
    php${PHP_VER}-memcached
    php${PHP_VER}-mongodb
    php${PHP_VER}-oauth
    php${PHP_VER}-raphf
    php${PHP_VER}-redis
    php${PHP_VER}-soap
    php${PHP_VER}-solr
    php${PHP_VER}-sqlite3
    php${PHP_VER}-uuid
    php${PHP_VER}-xdebug
    php${PHP_VER}-zmq
"

MODULES_LEGACY=""

# These modules not available on > PHP 7.4
if [[ ${PHP_VER} == 7.4 ]]; then
    MODULES_LEGACY="
        php${PHP_VER}-apcu-bc
        php${PHP_VER}-geoip
        php${PHP_VER}-gnupg
        php${PHP_VER}-json
        php${PHP_VER}-radius
        php${PHP_VER}-ssh2
        php${PHP_VER}-stomp
        php${PHP_VER}-uploadprogress
    "
fi

apt-get update &&\
apt-get install --no-install-recommends --no-install-suggests -y \
    ${MODULES_DEFAULT} \
    ${MODULES_OPTIONAL} \
    ${MODULES_LEGACY} \
    &&\
apt-get -y --purge autoremove &&\
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}

#!/usr/bin/env bash

set -e
set -x

# Installs most common modules

PHP_VER="${1}"

MODULES_FOR_VERSION=""

# Modules available only to PHP 7.0 and 7.1
if [[ ${PHP_VER} == 7.1 ]] || [[ ${PHP_VER} == 7.0 ]]; then
    MODULES_FOR_VERSION="
        php${PHP_VER}-lua
        php${PHP_VER}-mcrypt
        php${PHP_VER}-sodium
    "
fi

# Modules available only to PHP 7.2
if [[ ${PHP_VER} == 7.2 ]]; then
    MODULES_FOR_VERSION="
        php${PHP_VER}-lua
    "
fi

# 7.3+ have no modules unavailable to other versions

# These modules are installed and enabled by default
MODULES_DEFAULT="
    php${PHP_VER}-bcmath
    php${PHP_VER}-cli
    php${PHP_VER}-curl
    php${PHP_VER}-intl
    php${PHP_VER}-json
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
    php${PHP_VER}-apcu-bc
    php${PHP_VER}-gd
    php${PHP_VER}-geoip
    php${PHP_VER}-gnupg
    php${PHP_VER}-igbinary
    php${PHP_VER}-imagick
    php${PHP_VER}-mailparse
    php${PHP_VER}-memcached
    php${PHP_VER}-mongodb
    php${PHP_VER}-oauth
    php${PHP_VER}-radius
    php${PHP_VER}-raphf
    php${PHP_VER}-redis
    php${PHP_VER}-soap
    php${PHP_VER}-solr
    php${PHP_VER}-sqlite3
    php${PHP_VER}-ssh2
    php${PHP_VER}-stomp
    php${PHP_VER}-uploadprogress
    php${PHP_VER}-uuid
    php${PHP_VER}-zmq
    php-xdebug
"

# These modules not available on PHP 8.0
if [[ ${PHP_VER} == 8.0 ]]; then
    MODULES_DEFAULT=$(echo $MODULES_DEFAULT | sed "s/php${PHP_VER}-json//")
    MODULES_OPTIONAL=$(
        echo $MODULES_OPTIONAL |
        sed "s/php${PHP_VER}-apcu-bc//" |
        sed "s/php${PHP_VER}-geoip//" |
        sed "s/php${PHP_VER}-gnupg//" |
        sed "s/php${PHP_VER}-radius//" |
        sed "s/php${PHP_VER}-ssh2//" |
        sed "s/php${PHP_VER}-stomp//" |
        sed "s/php${PHP_VER}-uploadprogress//"
    )
fi

apt-get update &&\
apt-get install --no-install-recommends --no-install-suggests -y \
    ${MODULES_DEFAULT} \
    ${MODULES_OPTIONAL} \
    ${MODULES_FOR_VERSION} \
    &&\
apt-get -y --purge autoremove &&\
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}

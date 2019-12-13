#!/usr/bin/env bash

set -e
set -x

# Manage INI files

PHP_VER="${1}"

EXTRA_MODS_DIR_FOR_VERSION=""
MOVE_INI_FOR_VERSION=""
LINK_EXTRA_MODS_FOR_VERSION=""

# Modules available only to PHP 7.0 and 7.1
if [[ ${PHP_VER} == 7.1 ]] || [[ ${PHP_VER} == 7.0 ]]; then
    EXTRA_MODS_DIR_FOR_VERSION="
        install -d -m 0755 -o www-data -g www-data \
            /etc/php/extra-mods/lua \
            /etc/php/extra-mods/mcrypt \
            /etc/php/extra-mods/sodium
    "
    MOVE_INI_FOR_VERSION="
        mv /etc/php/${PHP_VER}/mods-available/lua.ini    /etc/php/extra-mods/lua/ &&\
        mv /etc/php/${PHP_VER}/mods-available/mcrypt.ini /etc/php/extra-mods/mcrypt/ &&\
        mv /etc/php/${PHP_VER}/mods-available/sodium.ini /etc/php/extra-mods/sodium/
    "
    LINK_EXTRA_MODS_FOR_VERSION="
        ln -s /etc/php/extra-mods/lua    /p/lua &&\
        ln -s /etc/php/extra-mods/mcrypt /p/mcrypt &&\
        ln -s /etc/php/extra-mods/sodium /p/sodium
    "
fi

# Modules available only to PHP 7.2
if [[ ${PHP_VER} == 7.2 ]]; then
    EXTRA_MODS_DIR_FOR_VERSION="
        install -d -m 0755 -o www-data -g www-data \
            /etc/php/extra-mods/lua
    "
    MOVE_INI_FOR_VERSION="
        mv /etc/php/${PHP_VER}/mods-available/lua.ini /etc/php/extra-mods/lua/
    "
    LINK_EXTRA_MODS_FOR_VERSION="
        ln -s /etc/php/extra-mods/lua /p/lua
    "
fi

install -d -m 0755 -o www-data -g www-data \
    /etc/php/extra-mods \
    /etc/php/extra-mods/amqp \
    /etc/php/extra-mods/apcu \
    /etc/php/extra-mods/apcu_bc \
    /etc/php/extra-mods/gd \
    /etc/php/extra-mods/geoip \
    /etc/php/extra-mods/gnupg \
    /etc/php/extra-mods/imagick \
    /etc/php/extra-mods/mailparse \
    /etc/php/extra-mods/memcached \
    /etc/php/extra-mods/mongodb \
    /etc/php/extra-mods/oauth \
    /etc/php/extra-mods/pdo_sqlite \
    /etc/php/extra-mods/radius \
    /etc/php/extra-mods/raphf \
    /etc/php/extra-mods/redis \
    /etc/php/extra-mods/soap \
    /etc/php/extra-mods/solr \
    /etc/php/extra-mods/sqlite3 \
    /etc/php/extra-mods/ssh2 \
    /etc/php/extra-mods/stomp \
    /etc/php/extra-mods/uploadprogress \
    /etc/php/extra-mods/uuid \
    /etc/php/extra-mods/zmq \
    /etc/php/extra-mods/xdebug
eval ${EXTRA_MODS_DIR_FOR_VERSION}

mv /etc/php/${PHP_VER}/mods-available/amqp.ini           /etc/php/extra-mods/amqp/
mv /etc/php/${PHP_VER}/mods-available/apcu.ini           /etc/php/extra-mods/apcu/
mv /etc/php/${PHP_VER}/mods-available/apcu_bc.ini        /etc/php/extra-mods/apcu_bc/
mv /etc/php/${PHP_VER}/mods-available/gd.ini             /etc/php/extra-mods/gd/
mv /etc/php/${PHP_VER}/mods-available/geoip.ini          /etc/php/extra-mods/geoip/
mv /etc/php/${PHP_VER}/mods-available/gnupg.ini          /etc/php/extra-mods/gnupg/
mv /etc/php/${PHP_VER}/mods-available/imagick.ini        /etc/php/extra-mods/imagick/
mv /etc/php/${PHP_VER}/mods-available/mailparse.ini      /etc/php/extra-mods/mailparse/
mv /etc/php/${PHP_VER}/mods-available/memcached.ini      /etc/php/extra-mods/memcached/
mv /etc/php/${PHP_VER}/mods-available/mongodb.ini        /etc/php/extra-mods/mongodb/
mv /etc/php/${PHP_VER}/mods-available/oauth.ini          /etc/php/extra-mods/oauth/
mv /etc/php/${PHP_VER}/mods-available/pdo_sqlite.ini     /etc/php/extra-mods/pdo_sqlite/
mv /etc/php/${PHP_VER}/mods-available/radius.ini         /etc/php/extra-mods/radius/
mv /etc/php/${PHP_VER}/mods-available/raphf.ini          /etc/php/extra-mods/raphf/
mv /etc/php/${PHP_VER}/mods-available/redis.ini          /etc/php/extra-mods/redis/
mv /etc/php/${PHP_VER}/mods-available/soap.ini           /etc/php/extra-mods/soap/
mv /etc/php/${PHP_VER}/mods-available/solr.ini           /etc/php/extra-mods/solr/
mv /etc/php/${PHP_VER}/mods-available/sqlite3.ini        /etc/php/extra-mods/sqlite3/
mv /etc/php/${PHP_VER}/mods-available/ssh2.ini           /etc/php/extra-mods/ssh2/
mv /etc/php/${PHP_VER}/mods-available/stomp.ini          /etc/php/extra-mods/stomp/
mv /etc/php/${PHP_VER}/mods-available/uploadprogress.ini /etc/php/extra-mods/uploadprogress/
mv /etc/php/${PHP_VER}/mods-available/uuid.ini           /etc/php/extra-mods/uuid/
mv /etc/php/${PHP_VER}/mods-available/zmq.ini            /etc/php/extra-mods/zmq/
mv /etc/php/${PHP_VER}/mods-available/xdebug.ini         /etc/php/extra-mods/xdebug/
eval ${MOVE_INI_FOR_VERSION}

install -d -m 0755 -o www-data -g www-data /p
ln -s /etc/php/extra-mods/amqp           /p/amqp
ln -s /etc/php/extra-mods/apcu           /p/apcu
ln -s /etc/php/extra-mods/apcu_bc        /p/apcu_bc
ln -s /etc/php/extra-mods/gd             /p/gd
ln -s /etc/php/extra-mods/geoip          /p/geoip
ln -s /etc/php/extra-mods/gnupg          /p/gnupg
ln -s /etc/php/extra-mods/imagick        /p/imagick
ln -s /etc/php/extra-mods/mailparse      /p/mailparse
ln -s /etc/php/extra-mods/memcached      /p/memcached
ln -s /etc/php/extra-mods/mongodb        /p/mongodb
ln -s /etc/php/extra-mods/oauth          /p/oauth
ln -s /etc/php/extra-mods/pdo_sqlite     /p/pdo_sqlite
ln -s /etc/php/extra-mods/radius         /p/radius
ln -s /etc/php/extra-mods/raphf          /p/raphf
ln -s /etc/php/extra-mods/redis          /p/redis
ln -s /etc/php/extra-mods/soap           /p/soap
ln -s /etc/php/extra-mods/solr           /p/solr
ln -s /etc/php/extra-mods/sqlite3        /p/sqlite3
ln -s /etc/php/extra-mods/ssh2           /p/ssh2
ln -s /etc/php/extra-mods/stomp          /p/stomp
ln -s /etc/php/extra-mods/uploadprogress /p/uploadprogress
ln -s /etc/php/extra-mods/uuid           /p/uuid
ln -s /etc/php/extra-mods/zmq            /p/zmq
ln -s /etc/php/extra-mods/xdebug         /p/xdebug
eval ${LINK_EXTRA_MODS_FOR_VERSION}

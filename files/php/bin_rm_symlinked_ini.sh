#!/usr/bin/env bash

set -e
set -x

# Removes version-specific INI symlinks

PHP_VER="${1}"
FPM_CLI="${2}"

# Move non-standard(ish) module INI files out of auto-included directory
# To include a specific module append the directory to PHP_INI_SCAN_DIR
# Shortcut directories are created at /p, eg: /p/xdebug, /p/memcached
# You can specify as PHP_INI_SCAN_DIR=:/p/xdebug:/p/memcached
# Make sure to begin the command with `:`

function rm_symlinked_ini() {
    TYPE="${1}"

    rm -f \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-amqp.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-apcu.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/25-apcu_bc.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-gd.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-geoip.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-gnupg.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-imagick.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/25-mailparse.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/25-memcached.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-mongodb.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-oauth.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-pdo_sqlite.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-radius.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-raphf.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-redis.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-soap.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-solr.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-sqlite3.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-ssh2.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-stomp.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-uploadprogress.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-uuid.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-zmq.ini \
        /etc/php/${PHP_VER}/${TYPE}/conf.d/20-xdebug.ini
}

# Inject our default INI and conf files.
# To add your own files, add to the cli or fpm conf.d directories. All INI are
# auto-loaded from this directory, and are loaded in alphabetical order. Suggested
# to start with "99-" to ensure your settings are loaded last and take precedence.
if [[ ${FPM_CLI} == "fpm" ]]; then
    rm_symlinked_ini fpm

    rm -f /etc/php/${PHP_VER}/fpm/php-fpm.conf
    ln -s /etc/php/${PHP_VER}/fpm/conf.d /etc/php/fpm-conf.d
    ln -s /etc/php/php.ini               /etc/php/${PHP_VER}/fpm/conf.d/98-env.ini
    ln -s /etc/php/php-custom.ini        /etc/php/${PHP_VER}/fpm/conf.d/99-custom.ini

    cat > /etc/php/php-custom.ini << EOF
; Add custom PHP INI directives here
EOF
fi

if [[ ${FPM_CLI} == "cli" ]]; then
    rm_symlinked_ini cli

    ln -s /etc/php/${PHP_VER}/cli/conf.d /etc/php/cli-conf.d
    ln -s /etc/php/php.ini               /etc/php/${PHP_VER}/cli/conf.d/98-env.ini
    ln -s /etc/php/cli-custom.ini        /etc/php/${PHP_VER}/cli/conf.d/99-custom.ini

    cat > /etc/php/cli-custom.ini << EOF
; Add custom PHP INI directives here
EOF
fi

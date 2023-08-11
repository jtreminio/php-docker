#!/usr/bin/env bash

set -e
set -x

# Installs Composer

install -d -m 0755 -o www -g www /.composer &&\
curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin \
           --filename=composer &&\
chown -R www:www /.composer


# curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.16 
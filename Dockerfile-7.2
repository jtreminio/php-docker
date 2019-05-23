FROM jtreminio/phpenv:latest
LABEL maintainer="Juan Treminio <jtreminio@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN update-alternatives --install /bin/sh sh /bin/bash 100

COPY files/ondrej.pgp /root/ondrej.pgp

# install base requirements
RUN apt-get update &&\
    apt-get install --no-install-recommends --no-install-suggests -y \
        ca-certificates\
        curl \
        git \
        gnupg \
        unzip \
        zip &&\
    cat /root/ondrej.pgp | apt-key add &&\
        printf "deb [arch=amd64] http://ppa.launchpad.net/ondrej/php/ubuntu bionic main\n" \
>/etc/apt/sources.list.d/ondrej.list &&\
    rm -f /root/ondrej.pgp &&\
    apt-get update &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}

ENV COMPOSER_HOME /.composer
ENV PHP_VER 7.2
ARG PHP_VER_DOT
ENV PHP_LIB_DIR 20170718

# Deletable dupe module directories not required by this version
ENV DEL_LIB_PHP_DIR /usr/lib/php/20131226 \
                    /usr/lib/php/20151012 \
                    /usr/lib/php/20160303 \
                    /usr/lib/php/20180731 \
                    /usr/lib/php/${PHP_VER}
# Deletable extra directories that may be created by installing PHP modules
ENV DEL_PHP_DIR /etc/php/5.6 \
                /etc/php/7.0 \
                /etc/php/7.1 \
                /etc/php/7.3

# Most common PHP modules, and Composer
# First group of modules are enabled by default
# Second group must have their INI directories included via PHP_INI_SCAN_DIR
RUN apt-get update &&\
    apt-get install --no-install-recommends --no-install-suggests -y \
        php${PHP_VER}-bcmath \
        php${PHP_VER}-cli \
        php${PHP_VER}-curl \
        php${PHP_VER}-fpm \
        php${PHP_VER}-intl \
        php${PHP_VER}-json \
        php${PHP_VER}-mbstring \
        php${PHP_VER}-mysql \
        php${PHP_VER}-opcache \
        php${PHP_VER}-xml \
        php${PHP_VER}-zip \
        \
        php${PHP_VER}-amqp \
        php${PHP_VER}-apcu \
        php${PHP_VER}-apcu-bc \
        php${PHP_VER}-gd \
        php${PHP_VER}-geoip \
        php${PHP_VER}-gnupg \
        php${PHP_VER}-igbinary \
        php${PHP_VER}-imagick \
        php${PHP_VER}-lua \
        php${PHP_VER}-mailparse \
        php${PHP_VER}-memcached \
        php${PHP_VER}-mongodb \
        php${PHP_VER}-oauth \
        php${PHP_VER}-radius \
        php${PHP_VER}-raphf \
        php${PHP_VER}-redis \
        php${PHP_VER}-soap \
        php${PHP_VER}-solr \
        php${PHP_VER}-sqlite3 \
        php${PHP_VER}-ssh2 \
        php${PHP_VER}-stomp \
        php${PHP_VER}-uploadprogress \
        php${PHP_VER}-uuid \
        php${PHP_VER}-zmq \
        php-xdebug &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}

# Delete directories belonging to other PHP versions
RUN rm -rf ${DEL_LIB_PHP_DIR} \
           ${DEL_PHP_DIR}

# Install Composer
RUN install -d -m 0755 -o www-data -g www-data /.composer &&\
    curl -sS https://getcomposer.org/installer | \
        php -- --install-dir=/usr/local/bin \
               --filename=composer &&\
    chown -R www-data:www-data /.composer

# Save INI and FPM conf files into non-versioned directory
# This makes managing them across several different PHP versions easier
COPY files/php.ini  /etc/php/php.ini
COPY files/fpm.conf /etc/php/fpm.conf

# Use the following to mount your custom INI files as Volumes
COPY files/blank.ini /etc/php/cli-custom.ini
COPY files/blank.ini /etc/php/php-custom.ini

# Set up PID and sessions directories
RUN install -d -m 0755 -o www-data -g www-data \
    /var/run/php-fpm \
    /var/lib/php/sessions

# Inject our default INI and conf files.
# To add your own files, add to the cli or fpm conf.d directories. All INI are
# auto-loaded from this directory, and are loaded in alphabetical order. Suggested
# to start with "99-" to ensure your settings are loaded last and take precedence.
RUN rm -f /etc/php/${PHP_VER}/fpm/php-fpm.conf &&\
    ln -s /etc/php/${PHP_VER}/fpm/conf.d /etc/php/fpm-conf.d &&\
    ln -s /etc/php/${PHP_VER}/cli/conf.d /etc/php/cli-conf.d &&\
    \
    ln -s /etc/php/php.ini        /etc/php/${PHP_VER}/cli/conf.d/98-env.ini &&\
    ln -s /etc/php/php.ini        /etc/php/${PHP_VER}/fpm/conf.d/98-env.ini &&\
    ln -s /etc/php/fpm.conf       /etc/php/${PHP_VER}/fpm/php-fpm.conf &&\
    ln -s /etc/php/cli-custom.ini /etc/php/${PHP_VER}/cli/conf.d/99-custom.ini &&\
    ln -s /etc/php/php-custom.ini /etc/php/${PHP_VER}/fpm/conf.d/99-custom.ini

# Move non-standard(ish) module INI files out of auto-included directory
# To include a specific module append the directory to PHP_INI_SCAN_DIR
# Shortcut directories are created at /p, eg: /p/xdebug, /p/memcached
# You can specify as PHP_INI_SCAN_DIR=:/p/xdebug:/p/memcached
# Make sure to begin the command with `:`
RUN rm -f \
        /etc/php/${PHP_VER}/cli/conf.d/20-amqp.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-amqp.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-apcu.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-apcu.ini \
        /etc/php/${PHP_VER}/cli/conf.d/25-apcu_bc.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/25-apcu_bc.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-gd.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-gd.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-geoip.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-geoip.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-gnupg.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-gnupg.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-imagick.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-imagick.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-lua.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-lua.ini \
        /etc/php/${PHP_VER}/cli/conf.d/25-mailparse.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/25-mailparse.ini \
        /etc/php/${PHP_VER}/cli/conf.d/25-memcached.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/25-memcached.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-mongodb.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-mongodb.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-oauth.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-oauth.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-pdo_sqlite.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-pdo_sqlite.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-radius.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-radius.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-raphf.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-raphf.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-redis.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-redis.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-soap.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-soap.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-solr.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-solr.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-sqlite3.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-sqlite3.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-ssh2.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-ssh2.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-stomp.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-stomp.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-uploadprogress.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-uploadprogress.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-uuid.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-uuid.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-zmq.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-zmq.ini \
        /etc/php/${PHP_VER}/cli/conf.d/20-xdebug.ini \
        /etc/php/${PHP_VER}/fpm/conf.d/20-xdebug.ini &&\
    \
    install -d -m 0755 -o www-data -g www-data \
        /etc/php/extra-mods \
        /etc/php/extra-mods/amqp \
        /etc/php/extra-mods/apcu \
        /etc/php/extra-mods/apcu_bc \
        /etc/php/extra-mods/gd \
        /etc/php/extra-mods/geoip \
        /etc/php/extra-mods/gnupg \
        /etc/php/extra-mods/imagick \
        /etc/php/extra-mods/lua \
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
        /etc/php/extra-mods/xdebug &&\
    \
    mv /etc/php/${PHP_VER}/mods-available/amqp.ini           /etc/php/extra-mods/amqp/ &&\
    mv /etc/php/${PHP_VER}/mods-available/apcu.ini           /etc/php/extra-mods/apcu/ &&\
    mv /etc/php/${PHP_VER}/mods-available/apcu_bc.ini        /etc/php/extra-mods/apcu_bc/ &&\
    mv /etc/php/${PHP_VER}/mods-available/gd.ini             /etc/php/extra-mods/gd/ &&\
    mv /etc/php/${PHP_VER}/mods-available/geoip.ini          /etc/php/extra-mods/geoip/ &&\
    mv /etc/php/${PHP_VER}/mods-available/gnupg.ini          /etc/php/extra-mods/gnupg/ &&\
    mv /etc/php/${PHP_VER}/mods-available/imagick.ini        /etc/php/extra-mods/imagick/ &&\
    mv /etc/php/${PHP_VER}/mods-available/lua.ini            /etc/php/extra-mods/lua/ &&\
    mv /etc/php/${PHP_VER}/mods-available/mailparse.ini      /etc/php/extra-mods/mailparse/ &&\
    mv /etc/php/${PHP_VER}/mods-available/memcached.ini      /etc/php/extra-mods/memcached/ &&\
    mv /etc/php/${PHP_VER}/mods-available/mongodb.ini        /etc/php/extra-mods/mongodb/ &&\
    mv /etc/php/${PHP_VER}/mods-available/oauth.ini          /etc/php/extra-mods/oauth/ &&\
    mv /etc/php/${PHP_VER}/mods-available/pdo_sqlite.ini     /etc/php/extra-mods/pdo_sqlite/ &&\
    mv /etc/php/${PHP_VER}/mods-available/radius.ini         /etc/php/extra-mods/radius/ &&\
    mv /etc/php/${PHP_VER}/mods-available/raphf.ini          /etc/php/extra-mods/raphf/ &&\
    mv /etc/php/${PHP_VER}/mods-available/redis.ini          /etc/php/extra-mods/redis/ &&\
    mv /etc/php/${PHP_VER}/mods-available/soap.ini           /etc/php/extra-mods/soap/ &&\
    mv /etc/php/${PHP_VER}/mods-available/solr.ini           /etc/php/extra-mods/solr/ &&\
    mv /etc/php/${PHP_VER}/mods-available/sqlite3.ini        /etc/php/extra-mods/sqlite3/ &&\
    mv /etc/php/${PHP_VER}/mods-available/ssh2.ini           /etc/php/extra-mods/ssh2/ &&\
    mv /etc/php/${PHP_VER}/mods-available/stomp.ini          /etc/php/extra-mods/stomp/ &&\
    mv /etc/php/${PHP_VER}/mods-available/uploadprogress.ini /etc/php/extra-mods/uploadprogress/ &&\
    mv /etc/php/${PHP_VER}/mods-available/uuid.ini           /etc/php/extra-mods/uuid/ &&\
    mv /etc/php/${PHP_VER}/mods-available/zmq.ini            /etc/php/extra-mods/zmq/ &&\
    mv /etc/php/${PHP_VER}/mods-available/xdebug.ini         /etc/php/extra-mods/xdebug &&\
    \
    install -d -m 0755 -o www-data -g www-data /p &&\
    ln -s /etc/php/extra-mods/amqp           /p/amqp &&\
    ln -s /etc/php/extra-mods/apcu           /p/apcu &&\
    ln -s /etc/php/extra-mods/apcu_bc        /p/apcu_bc &&\
    ln -s /etc/php/extra-mods/gd             /p/gd &&\
    ln -s /etc/php/extra-mods/geoip          /p/geoip &&\
    ln -s /etc/php/extra-mods/gnupg          /p/gnupg &&\
    ln -s /etc/php/extra-mods/imagick        /p/imagick &&\
    ln -s /etc/php/extra-mods/lua            /p/lua &&\
    ln -s /etc/php/extra-mods/mailparse      /p/mailparse &&\
    ln -s /etc/php/extra-mods/memcached      /p/memcached &&\
    ln -s /etc/php/extra-mods/mongodb        /p/mongodb &&\
    ln -s /etc/php/extra-mods/oauth          /p/oauth &&\
    ln -s /etc/php/extra-mods/pdo_sqlite     /p/pdo_sqlite &&\
    ln -s /etc/php/extra-mods/radius         /p/radius &&\
    ln -s /etc/php/extra-mods/raphf          /p/raphf &&\
    ln -s /etc/php/extra-mods/redis          /p/redis &&\
    ln -s /etc/php/extra-mods/soap           /p/soap &&\
    ln -s /etc/php/extra-mods/solr           /p/solr &&\
    ln -s /etc/php/extra-mods/sqlite3        /p/sqlite3 &&\
    ln -s /etc/php/extra-mods/ssh2           /p/ssh2 &&\
    ln -s /etc/php/extra-mods/stomp          /p/stomp &&\
    ln -s /etc/php/extra-mods/uploadprogress /p/uploadprogress &&\
    ln -s /etc/php/extra-mods/uuid           /p/uuid &&\
    ln -s /etc/php/extra-mods/zmq            /p/zmq &&\
    ln -s /etc/php/extra-mods/xdebug         /p/xdebug

RUN rm -rf /etc/apache2

# Standardize PHP-FPM executable location
RUN rm -f /usr/sbin/php-fpm &&\
    ln -s /usr/sbin/php-fpm${PHP_VER} /usr/sbin/php-fpm

# Only set PHP_INI_SCAN_DIR inside following file so it does not affect PHP CLI
# runit config
RUN mkdir /etc/service/fpm
COPY files/php-fpm /etc/service/fpm/run
RUN chmod +x /etc/service/fpm/run

# Xdebug CLI debugging
COPY files/xdebug /usr/bin/xdebug
RUN chmod +x /usr/bin/xdebug

WORKDIR /etc/php/${PHP_VER}

EXPOSE 9000

CMD ["/sbin/my_init"]

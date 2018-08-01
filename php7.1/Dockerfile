FROM blitznote/debase:18.04
LABEL maintainer="Juan Treminio <jtreminio@gmail.com>"

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

COPY ondrej.pgp /root/ondrej.pgp

# Add Ondrej PPA; This repo is used for several PHP versions
RUN cat /root/ondrej.pgp | apt-key add &&\
    printf "deb [arch=amd64] http://ppa.launchpad.net/ondrej/php/ubuntu bionic main\n" \
>/etc/apt/sources.list.d/ondrej.list &&\
    rm -f /root/ondrej.pgp

# install base requirements
RUN apt-get update &&\
    apt-get install --no-install-recommends --no-install-suggests -y \
        libfcgi0ldbl \
        libfcgi-bin \
        git &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
           /usr/lib/x86_64-linux-gnu/perl /usr/share/perl \
           /usr/lib/x86_64-linux-gnu/libperl.* /usr/share/{man,doc}

ENV COMPOSER_HOME /.composer
LABEL php-version="7.1.20"
ENV PHP_VER 7.1

# PHP INI settings are set by env vars
ENV PHP_DISPLAY_ERRORS              "Off"
ENV PHP_ERROR_REPORTING             0
ENV DATE_TIMEZONE                   "UTC"

ENV OPCACHE_ENABLE                  1
ENV OPCACHE_ENABLE_CLI              1
ENV OPCACHE_FAST_SHUTDOWN           1
ENV OPCACHE_INTERNED_STRINGS_BUFFER 16
ENV OPCACHE_MAX_ACCELERATED_FILES   40000
ENV OPCACHE_MEMORY_CONSUMPTION      256
ENV OPCACHE_REVALIDATE_FREQ         0
ENV OPCACHE_VALIDATE_TIMESTAMPS     1

ENV XDEBUG_REMOTE_HOST              "host.docker.internal"
ENV XDEBUG_DEFAULT_ENABLE           1
ENV XDEBUG_REMOTE_AUTOSTART         1
ENV XDEBUG_REMOTE_CONNECT_BACK      0
ENV XDEBUG_REMOTE_ENABLE            1
ENV XDEBUG_REMOTE_HANDLER           "dbgp"
ENV XDEBUG_REMOTE_PORT              9000

# Most common PHP modules, and Composer
# Delete dupe module directories not required by this version (20160303)
RUN apt-get update &&\
    apt-get -y install --no-install-recommends --no-install-suggests \
        php${PHP_VER}-cli \
        php${PHP_VER}-curl \
        php${PHP_VER}-fpm \
        php${PHP_VER}-imagick \
        php${PHP_VER}-intl \
        php${PHP_VER}-json \
        php${PHP_VER}-mbstring \
        php${PHP_VER}-mongodb \
        php${PHP_VER}-mysql \
        php${PHP_VER}-opcache \
        php${PHP_VER}-redis \
        php${PHP_VER}-sqlite3 \
        php${PHP_VER}-xml \
        php${PHP_VER}-zip \
        php-xdebug &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
           /usr/lib/x86_64-linux-gnu/perl /usr/share/perl \
           /usr/lib/x86_64-linux-gnu/libperl.* /usr/share/{man,doc} \
           /usr/lib/php/20131226 \
           /usr/lib/php/20151012 \
           /usr/lib/php/20170718 \
           /usr/lib/php/${PHP_VER} &&\
    install -d -m 0755 -o www-data -g www-data /.composer &&\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin \
        --filename=composer &&\
    chown -R www-data:www-data /.composer

# Save INI and FPM conf files into non-versioned directory
# This makes managing them across several different PHP versions easier
ADD --chown=www-data:www-data php.ini   /etc/php/cli.ini
ADD --chown=www-data:www-data php.ini   /etc/php/php.ini
ADD --chown=www-data:www-data fpm.conf  /etc/php/fpm.conf
ADD --chown=www-data:www-data blank.ini /etc/php/cli-custom.ini
ADD --chown=www-data:www-data blank.ini /etc/php/php-custom.ini

# Remove extra directories that may be created by installing modules above
RUN rm -rf /etc/php/5.6 \
           /etc/php/7.0 \
           /etc/php/7.2 \
           /etc/php/7.3

# Set up PID and sessions directory and ENV-enabled INI files directory
RUN install -d -m 0755 -o www-data -g www-data /var/run/php-fpm &&\
    install -d -m 0755 -o www-data -g www-data /var/lib/php/sessions &&\
    install -d -m 0755 -o www-data -g www-data /etc/php/conf-env &&\
    install -d -m 0755 -o www-data -g www-data /etc/php/conf-env/xdebug

# Inject our default INI and conf files.
# To add your own files, add to the cli or fpm conf.d directories. All INI are
# auto-loaded from this directory, and are loaded in alphabetical order. Suggested
# to start with "99-" to ensure your settings are loaded last and take precedence.
RUN rm -f /etc/php/${PHP_VER}/fpm/php-fpm.conf &&\
    ln -s /etc/php/cli.ini        /etc/php/${PHP_VER}/cli/conf.d/98-env.ini &&\
    ln -s /etc/php/php.ini        /etc/php/${PHP_VER}/fpm/conf.d/98-env.ini &&\
    ln -s /etc/php/fpm.conf       /etc/php/${PHP_VER}/fpm/php-fpm.conf &&\
    ln -s /etc/php/cli-custom.ini /etc/php/${PHP_VER}/cli/conf.d/99-custom.ini &&\
    ln -s /etc/php/php-custom.ini /etc/php/${PHP_VER}/fpm/conf.d/99-custom.ini

# Xdebug is disabled by default, use `-e PHP_INI_SCAN_DIR=:/etc/php/conf-env/xdebug` to enable
RUN rm -f /etc/php/${PHP_VER}/cli/conf.d/20-xdebug.ini \
          /etc/php/${PHP_VER}/fpm/conf.d/20-xdebug.ini &&\
    touch /etc/php/${PHP_VER}/cli/conf.d/20-xdebug.ini &&\
    touch /etc/php/${PHP_VER}/fpm/conf.d/20-xdebug.ini &&\
    mv /etc/php/${PHP_VER}/mods-available/xdebug.ini /etc/php/conf-env/xdebug/xdebug.ini

# Xdebug CLI debugging
RUN echo "#!/bin/bash" > /usr/bin/xdebug &&\
    echo "PHP_INI_SCAN_DIR=:/etc/php/conf-env/xdebug \\" \
>> /usr/bin/xdebug &&\
    echo "XDEBUG_CONFIG=\"idekey=xdebug\" php -dxdebug.remote_enable=1 \"\$@\"" \
>> /usr/bin/xdebug &&\
    chmod +x /usr/bin/xdebug

# Only set PHP_INI_SCAN_DIR inside following file so it does not affect PHP CLI
RUN echo "#!/bin/bash" > /usr/bin/php-fpm &&\
    echo "PHP_INI_SCAN_DIR=\${PHP_INI_SCAN_DIR:-/etc/php/${PHP_VER}/fpm/conf.d/}" \
>> /usr/bin/php-fpm &&\
    echo "/usr/sbin/php-fpm${PHP_VER} -c \${PHP_INI_SCAN_DIR} -F -R -O 2>&1 | sed -u 's,.*: \\\"\(.*\)$,\1,'| sed -u 's,\"$,,' 1>&1" \
>> /usr/bin/php-fpm &&\
    chmod +x /usr/bin/php-fpm

WORKDIR /etc/php/${PHP_VER}

EXPOSE 9000

CMD /usr/bin/php-fpm

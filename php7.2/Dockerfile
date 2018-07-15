FROM blitznote/debase:18.04
LABEL maintainer="Juan Treminio <jtreminio@gmail.com>"

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV COMPOSER_HOME /.composer

# Add Ondrej PPA; This repo is used for several PHP versions
RUN get-gpg-key 0x14AA40EC0831756756D7F66C4F4EA0AAE5267A6C | apt-key add &&\
    printf "deb [arch=amd64] http://ppa.launchpad.net/ondrej/php/ubuntu bionic main\n" \
>/etc/apt/sources.list.d/ondrej.list

LABEL php-version="7.2.7"
ENV PHP_VER 7.2

# Most common PHP modules
RUN apt-get update &&\
    apt-get -y install --no-install-recommends --no-install-suggests \
        git \
        php${PHP_VER}-cli \
        php${PHP_VER}-curl \
        php${PHP_VER}-fpm \
        php${PHP_VER}-gd \
        php${PHP_VER}-intl \
        php${PHP_VER}-json \
        php${PHP_VER}-mbstring \
        php${PHP_VER}-opcache \
        php${PHP_VER}-xml \
        php${PHP_VER}-zip \
        \
        php${PHP_VER}-iconv \
        php${PHP_VER}-imagick \
        php${PHP_VER}-ldap \
        php${PHP_VER}-memcached \
        php${PHP_VER}-mongodb \
        php${PHP_VER}-mysql \
        php${PHP_VER}-mysqli \
        php${PHP_VER}-mysqlnd \
        php${PHP_VER}-oauth \
        php${PHP_VER}-odbc \
        php${PHP_VER}-pdo \
        php${PHP_VER}-pdo-dblib \
        php${PHP_VER}-pdo-mysql \
        php${PHP_VER}-pdo-odbc \
        php${PHP_VER}-pdo-pgsql \
        php${PHP_VER}-pdo-sqlite \
        php${PHP_VER}-pgsql \
        php${PHP_VER}-phar \
        php${PHP_VER}-posix \
        php${PHP_VER}-ps \
        php${PHP_VER}-readline \
        php${PHP_VER}-redis \
        php${PHP_VER}-simplexml \
        php${PHP_VER}-soap \
        php${PHP_VER}-sockets \
        php${PHP_VER}-solr \
        php${PHP_VER}-sqlite3 \
        php${PHP_VER}-ssh2 \
        php${PHP_VER}-uuid \
        php${PHP_VER}-xdebug \
        php${PHP_VER}-xmlreader \
        php${PHP_VER}-xmlrpc \
        php${PHP_VER}-xmlwriter \
        php${PHP_VER}-xsl \
        php${PHP_VER}-yaml \
        php${PHP_VER}-zmq \
        php-pear &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    rm -rf /usr/share/{man,doc}

# Set up PID and sessions directory and install Composer
RUN install -d -m 0755 -o www-data -g www-data /var/run/php-fpm &&\
    install -d -m 0755 -o www-data -g www-data /var/lib/php/sessions &&\
    install -d -m 0755 -o www-data -g www-data /.composer &&\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin \
        --filename=composer &&\
    chown www-data:www-data /.composer

# Save INI and FPM conf files into non-versioned directory
# This makes managing them across several different PHP versions easier
ADD --chown=www-data:www-data php.ini  /etc/php/cli.ini
ADD --chown=www-data:www-data php.ini  /etc/php/fpm.ini
ADD --chown=www-data:www-data fpm.conf /etc/php/fpm.conf

RUN ln -s /etc/php/cli.ini  /etc/php/${PHP_VER}/cli/conf.d/zzzz_custom.ini &&\
    ln -s /etc/php/fpm.ini  /etc/php/${PHP_VER}/fpm/conf.d/zzzz_custom.ini &&\
    rm -f /etc/php/${PHP_VER}/fpm/php-fpm.conf &&\
    ln -s /etc/php/fpm.conf /etc/php/${PHP_VER}/fpm/php-fpm.conf

RUN echo "#!/bin/bash" > /usr/bin/php-fpm &&\
    echo "/usr/sbin/php-fpm${PHP_VER} -F -R -O 2>&1 | sed -u 's,.*: \\\"\(.*\)$,\1,'| sed -u 's,\"$,,' 1>&1" \
>> /usr/bin/php-fpm &&\
    chmod +x /usr/bin/php-fpm

WORKDIR /etc/php/${PHP_VER}

EXPOSE 9000

CMD /usr/bin/php-fpm

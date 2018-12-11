#### Supported tags and respective `Dockerfile` links

* `7.3`, ([php7.3/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.3))
* `7.2`, `latest` ([php7.2/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.2))
* `7.1` ([php7.1/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.1))
* `7.0` ([php7.0/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.0))
* `5.6` ([php5.6/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-5.6))

[All minor version tags can be found here.](https://hub.docker.com/r/jtreminio/php/tags/)

#### [This README best viewed on Github for formatting](https://github.com/jtreminio/php-docker/blob/master/README.md)

## How to use this image

### With Command Line

For PHP projects run through the command line interface (CLI), you can do the following.

#### Create a Dockerfile in your PHP project

    FROM jtreminio/php:7.2
    COPY . /usr/src/myapp
    WORKDIR /usr/src/myapp
    CMD [ "php", "./your-script.php" ]

Then, run the commands to build and run the Docker image:

    # docker build -t my-php-app .
    # docker run -it --rm --name my-running-app my-php-app

#### Run a single PHP script
For many simple, single file projects, you may find it inconvenient  to write a complete `Dockerfile`. In such cases, you can run a PHP script by using the PHP Docker image directly:

    # docker run -it --rm \
        --name my-running-script \
        -v "$PWD":/usr/src/myapp \
        -w /usr/src/myapp \
        jtreminio/php:7.2 php your-script.php

Note that all variants of the PHP image contain the PHP CLI.

### With Nginx

As long as the PHP and Nginx containers are on the same Network, Nginx simply needs to use `fastcgi_pass php:9000;`.

The following is an example for a Symfony 2 and Symfony 3 app:

    server {
        listen *:8080 default_server;
    
        server_name _;
        root /var/www/public;
    
        autoindex off;
    
        location / {
            try_files $uri /app.php$is_args$args;
        }
    
        location ~ ^/(app_dev|config)\.php(/|$) {
            set $path_info $fastcgi_path_info;
    
            fastcgi_pass php:9000;
            fastcgi_split_path_info ^(.+\.php)(/.*)$;
    
            include fastcgi_params;
    
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param DOCUMENT_ROOT $realpath_root;
        }
    
        location ~ ^/app\.php(/|$) {
            set $path_info $fastcgi_path_info;
    
            fastcgi_pass php:9000;
            fastcgi_split_path_info ^(.+\.php)(/.*)$;
    
            include fastcgi_params;
    
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param DOCUMENT_ROOT $realpath_root;
    
            internal;
        }
    
        location ~ \.php$ {
            return 404;
        }
    }


## About these images

These images are built from [Ondřej Surý's PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php)

They come with the most common PHP modules baked in. For a full list, please see the [official Github repo](https://github.com/jtreminio/php-docker).

`Composer` is installed at `/usr/local/bin/composer`

PHP-CGI and PHP-CLI INI files, and PHP-FPM conf file are saved to standard location across all versions to make managing them all simpler.

- PHP INI used by PHP-FPM is at `/etc/php/fpm.ini`
- PHP INI use by CLI is at `/etc/php/cli.ini`
- PHP-FPM main conf is at `/etc/php/fpm.conf`

Two blank INI files have been provided for you to write your custom INI settings.

- /etc/php/cli-custom.ini
- /etc/php/php-custom.ini

Use `-v your-file.ini:/etc/php/cli-custom.ini` to add your settings. These two files are loaded last so its contents will take precedence over everything else.

PHP-FPM includes fix for logging to stdout and stderr created by https://github.com/phpdocker-io/base-images

PHP-FPM listens on port `9000` and is run by calling `/usr/bin/php-fpm`

## INI Through Environment Variables

You can set a large number of PHP INI settings using environment variables.

[A full list of supported directives can be found here](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-env).

[You can read about this in more detail here](https://jtreminio.com/blog/docker-php/php-fpm-configuration-via-environment-variables/).

    # docker container run -it --rm \
        jtreminio/php:7.2 php -i | grep display_errors
    100:display_errors => Off => Off

vs

    # docker container run -it --rm \
        -e PHP.display_errors=1 \
        jtreminio/php:7.2 php -i | grep display_errors
    100:display_errors => STDOUT => STDOUT

## Installed Modules

Many modules are installed and enabled by default:

* [Enabled Modules for 7.3](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.3#L50)
* [Enabled Modules for 7.2](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.2#L49)
* [Enabled Modules for 7.1](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.1#L49)
* [Enabled Modules for 7.0](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.0#L49)
* [Enabled Modules for 5.6](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-5.6#L49)

Many modules are installed by _not_ enabled by default:

* [Installed, not Enabled Modules for 7.3](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.3#L62)
* [Installed, not Enabled Modules for 7.2](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.2#L61)
* [Installed, not Enabled Modules for 7.1](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.1#L61)
* [Installed, not Enabled Modules for 7.0](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-7.0#L61)
* [Installed, not Enabled Modules for 5.6](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-5.6#L61)

You can enable these modules by using the `PHP_INI_SCAN_DIR` env var. A special shortcut has been created to more easily add modules:

    # docker container run -it --rm \
        -e PHP_INI_SCAN_DIR=:/p/amqp:/p/mailparse \
        jtreminio/php:latest php -v

The `/p` directory contains symlinks to others:

    /p/amqp            -> /etc/php/extra-mods/amqp
    /p/apcu            -> /etc/php/extra-mods/apcu
    /p/geoip           -> /etc/php/extra-mods/geoip
    /p/gnupg           -> /etc/php/extra-mods/gnupg
    /p/imagick         -> /etc/php/extra-mods/imagick
    /p/lua             -> /etc/php/extra-mods/lua
    /p/mailparse       -> /etc/php/extra-mods/mailparse
    /p/memcached       -> /etc/php/extra-mods/memcached
    /p/mongodb         -> /etc/php/extra-mods/mongodb
    /p/oauth           -> /etc/php/extra-mods/oauth
    /p/pdo_sqlite      -> /etc/php/extra-mods/pdo_sqlite
    /p/radius          -> /etc/php/extra-mods/radius
    /p/raphf           -> /etc/php/extra-mods/raphf
    /p/redis           -> /etc/php/extra-mods/redis
    /p/solr            -> /etc/php/extra-mods/solr
    /p/sqlite3         -> /etc/php/extra-mods/sqlite3
    /p/ssh2            -> /etc/php/extra-mods/ssh2
    /p/stomp           -> /etc/php/extra-mods/stomp
    /p/uploadprogress  -> /etc/php/extra-mods/uploadprogress
    /p/uuid            -> /etc/php/extra-mods/uuid
    /p/xdebug          -> /etc/php/extra-mods/xdebug
    /p/zmq             -> /etc/php/extra-mods/zmq

You can add as many of these as you want to `PHP_INI_SCAN_DIR`, make sure to prepend `:`.

## Xdebug

Xdebug is _installed_ but _disabled_ by default:

    # docker container run -it --rm jtreminio/php:latest php -v
    PHP 7.2.7-1+ubuntu18.04.1+deb.sury.org+1 (cli) (built: Jun 22 2018 08:45:49) ( NTS )
    Copyright (c) 1997-2018 The PHP Group
    Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
        with Zend OPcache v7.2.7-1+ubuntu18.04.1+deb.sury.org+1, Copyright (c) 1999-2018, by Zend Technologies

To enable (ONLY on non-public servers!) you must use the `PHP_INI_SCAN_DIR` env var:

    # docker container run -it --rm \
        -e PHP_INI_SCAN_DIR=:/p/xdebug \
        jtreminio/php:latest php -v
    PHP 7.2.7-1+ubuntu18.04.1+deb.sury.org+1 (cli) (built: Jun 22 2018 08:45:49) ( NTS )
    Copyright (c) 1997-2018 The PHP Group
    Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
        with Zend OPcache v7.2.7-1+ubuntu18.04.1+deb.sury.org+1, Copyright (c) 1999-2018, by Zend Technologies
        with Xdebug v2.6.0, Copyright (c) 2002-2018, by Derick Rethans

Note the prepended `:` in `:/p/xdebug`.

`xdebug.remote_host` is set to `host.docker.internal` by default. [This will not work in Linux (yet)](https://github.com/docker/for-linux/issues/264).
You must either pass your host IP directly, or use a gateway. I have found `172.17.0.1` to work in most cases:

    # docker container run -it --rm \
        -e PHP_INI_SCAN_DIR=:/p/xdebug \
        -e PHP.xdebug.remote_host=172.17.0.1 \
        jtreminio/php:latest php -i | grep xdebug.remote_host
    860:xdebug.remote_host => 127.0.0.1 => 127.0.0.1
    
A helper script has been created at `/usr/bin/xdebug` to help you debug CLI applications.

To use it, call it instead of `php` directly:

    # docker container run -it --rm \
        -e PHP_INI_SCAN_DIR=:/p/xdebug \
        jtreminio/php:latest xdebug -v
    PHP 7.2.8-1+ubuntu18.04.1+deb.sury.org+1 (cli) (built: Jul 25 2018 10:52:19) ( NTS )
    Copyright (c) 1997-2018 The PHP Group
    Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
        with Zend OPcache v7.2.8-1+ubuntu18.04.1+deb.sury.org+1, Copyright (c) 1999-2018, by Zend Technologies
        with Xdebug v2.6.0, Copyright (c) 2002-2018, by Derick Rethans

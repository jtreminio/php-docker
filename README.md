#### Supported tags and respective `Dockerfile` links

* `7.2.7`, `7.2`, `latest` ([php7.2/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/php7.2/Dockerfile))
* `7.1.19`, `7.1` ([php7.1/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/php7.1/Dockerfile))
* `7.0.30`, `7.0` ([php7.0/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/php7.0/Dockerfile))
* `5.6.36`, `5.6` ([php5.6/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/php5.6/Dockerfile))

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

PHP-FPM includes fix for logging to stdout and stderr created by https://github.com/phpdocker-io/base-images

PHP-FPM listens on port `9000` and is run by calling `/usr/bin/php-fpm`

## INI Through Environment Variables

Common PHP INI values are set via env vars.

Only a small subset of values work right now. Any more will require a PR.

The INI file in the container looks like this:

    [custom]
    session.save_path = "/var/lib/php/sessions"
    display_errors = "${PHP_DISPLAY_ERRORS}"
    error_reporting = ${PHP_ERROR_REPORTING}
    date.timezone = "${DATE_TIMEZONE}"
    opcache.enable = ${OPCACHE_ENABLE}
    opcache.enable_cli = ${OPCACHE_ENABLE_CLI}
    opcache.fast_shutdown = ${OPCACHE_FAST_SHUTDOWN}
    opcache.interned_strings_buffer = ${OPCACHE_INTERNED_STRINGS_BUFFER}
    opcache.max_accelerated_files = ${OPCACHE_MAX_ACCELERATED_FILES}
    opcache.memory_consumption = ${OPCACHE_MEMORY_CONSUMPTION}
    opcache.revalidate_freq = ${OPCACHE_REVALIDATE_FREQ}
    opcache.validate_timestamps = ${OPCACHE_VALIDATE_TIMESTAMPS}
    
    [xdebug]
    xdebug.remote_host = "${XDEBUG_REMOTE_HOST}"
    xdebug.default_enable = ${XDEBUG_DEFAULT_ENABLE}
    xdebug.remote_autostart = ${XDEBUG_REMOTE_AUTOSTART}
    xdebug.remote_connect_back = ${XDEBUG_REMOTE_CONNECT_BACK}
    xdebug.remote_enable = ${XDEBUG_REMOTE_ENABLE}
    xdebug.remote_handler = "${XDEBUG_REMOTE_HANDLER}"
    xdebug.remote_port = ${XDEBUG_REMOTE_PORT}

With the default values set in the `Dockerfile` PHP then reads the above as:

    [custom]
    session.save_path = "/var/lib/php/sessions"
    display_errors = "Off"
    error_reporting = 0
    date.timezone = "UTC"
    opcache.enable = ${OPCACHE_ENABLE}
    opcache.enable_cli = 1
    opcache.fast_shutdown = 1
    opcache.interned_strings_buffer = 1
    opcache.max_accelerated_files = 16
    opcache.memory_consumption = 40000
    opcache.revalidate_freq = 256
    opcache.validate_timestamps = 0
    
    [xdebug]
    xdebug.remote_host = "host.docker.internal"
    xdebug.default_enable = 1
    xdebug.remote_autostart = 1
    xdebug.remote_connect_back = 0
    xdebug.remote_enable = 1
    xdebug.remote_handler = "dbgp"
    xdebug.remote_port = 9000

You can override any of the above values by using the `-e` flag:

    # docker container run -it --rm jtreminio/php:7.2 php -i | grep display_errors
    100:display_errors => Off => Off

vs

    # docker container run -it --rm \
        -e PHP_DISPLAY_ERRORS=1 \
        jtreminio/php:7.2 php -i | grep display_errors
    100:display_errors => STDOUT => STDOUT

## Xdebug

Xdebug is _installed_ but _disabled_ by default:

    # docker container run -it --rm jtreminio/php:latest php -v
    PHP 7.2.7-1+ubuntu18.04.1+deb.sury.org+1 (cli) (built: Jun 22 2018 08:45:49) ( NTS )
    Copyright (c) 1997-2018 The PHP Group
    Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
        with Zend OPcache v7.2.7-1+ubuntu18.04.1+deb.sury.org+1, Copyright (c) 1999-2018, by Zend Technologies

To enable (ONLY on non-public servers!) you must use the `PHP_INI_SCAN_DIR` env var:

    # docker container run -it --rm \
        -e PHP_INI_SCAN_DIR=:/etc/php/xdebug \
        jtreminio/php:latest php -v
    PHP 7.2.7-1+ubuntu18.04.1+deb.sury.org+1 (cli) (built: Jun 22 2018 08:45:49) ( NTS )
    Copyright (c) 1997-2018 The PHP Group
    Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
        with Zend OPcache v7.2.7-1+ubuntu18.04.1+deb.sury.org+1, Copyright (c) 1999-2018, by Zend Technologies
        with Xdebug v2.6.0, Copyright (c) 2002-2018, by Derick Rethans

Note the prepended `:` in `:/etc/php/xdebug`.

`xdebug.remote_host` is set to `host.docker.internal` by default. [This will not work in Linux (yet)](https://github.com/docker/for-linux/issues/264).
You must either pass your host IP directly, or use a gateway. I have found `172.17.0.1` to work in most cases:

    # docker container run -it --rm \
        -e PHP_INI_SCAN_DIR=:/etc/php/xdebug \
        -e XDEBUG_REMOTE_HOST=172.17.0.1 \
        jtreminio/php:latest php -i | grep xdebug.remote_host
    860:xdebug.remote_host => 127.0.0.1 => 127.0.0.1
    
A helper script has been created at `/usr/bin/xdebug` to help you debug CLI applications.

To use it, call it instead of `php` directly:

    # docker container run -it --rm \
        -e PHP_INI_SCAN_DIR=:/etc/php/xdebug \
        jtreminio/php:latest xdebug /path/to/file.php

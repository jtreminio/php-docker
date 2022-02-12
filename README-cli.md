#### Supported tags

* `jtreminio/php-cli:8.1`
* `jtreminio/php-cli:8.0`
* `jtreminio/php-cli:7.4`

[All minor version tags can be found here.](https://hub.docker.com/r/jtreminio/php-cli/tags/)

[Dockerfile can be found here.](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-php-cli)

#### [This README best viewed on Github for formatting](https://github.com/jtreminio/php-docker/blob/master/README-cli.md)

## How to use this image

### With Command Line

For PHP projects run through the command line interface (CLI), you can do the following.

#### Create a Dockerfile in your PHP project

```dockerfile
FROM jtreminio/php-cli:8.1
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
CMD [ "php", "./your-script.php" ]

```

Then, run the commands to build and run the Docker image:

```shell
docker build -t my-php-app .
docker run -it --rm --name my-running-app my-php-app

```

#### Run a single PHP script
For many simple, single file projects, you may find it inconvenient  to write a complete `Dockerfile`. In such cases, you can run a PHP script by using the PHP Docker image directly:

```shell
docker run -it --rm \
    --name my-running-script \
    -v "$PWD":/usr/src/myapp \
    -w /usr/src/myapp \
    jtreminio/php-cli:8.1 php your-script.php

```

Note that all variants of the PHP image contain the PHP CLI.

## With PHP-FPM

I have created images with PHP-FPM.

[Click here for `jtreminio/php`](https://hub.docker.com/r/jtreminio/php).

## With Nginx or Apache

I have created full-featured Nginx/Apache versions of these images.

[Click here for `jtreminio/php-nginx`](https://hub.docker.com/r/jtreminio/php-nginx).

[Click here for `jtreminio/php-apache`](https://hub.docker.com/r/jtreminio/php-apache).

## About these images

These images are built from [Ondřej Surý's PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php)

They come with the most common PHP modules baked in. For a full list please see below.

`Composer` is installed at `/usr/local/bin/composer`

PHP-CLI INI files are saved to standard location across all versions to make managing them simpler.

* PHP INI use by CLI is at `/etc/php/cli.ini`

Two blank INI files have been provided for you to write your custom INI settings.

* /etc/php/cli-custom.ini
* /etc/php/php-custom.ini

Use `-v your-file.ini:/etc/php/cli-custom.ini` to add your settings. These two files are loaded last so its contents will take precedence over everything else.

## INI Through Environment Variables

You can set a large number of PHP INI settings using environment variables.

[A full list of supported directives can be found here](https://github.com/jtreminio/php-docker/blob/master/Dockerfile-env).

[You can read about this in more detail here](https://jtreminio.com/blog/docker-php/php-fpm-configuration-via-environment-variables/).

```shell
docker container run -it --rm \
    jtreminio/php-cli:8.1 php -i | grep display_errors

100:display_errors => Off => Off

```

vs

```shell
docker container run -it --rm \
    -e PHP.display_errors=1 \
    jtreminio/php-cli:8.1 php -i | grep display_errors

100:display_errors => STDOUT => STDOUT

```

## Installed Modules

Many modules are installed and enabled by default:

* php-bcmath
* php-cli
* php-curl
* php-intl
* php-json
* php-mbstring
* php-mysql
* php-opcache
* php-xml
* php-zip

More modules are installed but _not_ enabled by default:

* php-amqp
* php-apcu
* php-gd
* php-igbinary
* php-imagick
* php-mailparse
* php-memcached
* php-mongodb
* php-oauth
* php-raphf
* php-redis
* php-soap
* php-solr
* php-sqlite3
* php-uuid
* php-zmq
* php-xdebug

PHP 7.4 also comes with

* apcu_bc
* geoip
* gnupg
* radius
* ssh2
* stomp
* uploadprogress

You can enable these modules by using the `PHP_INI_SCAN_DIR` env var. A special shortcut has been created to more easily add modules:

```shell
docker container run -it --rm \
    -e PHP_INI_SCAN_DIR=:/p/amqp:/p/mailparse \
    jtreminio/php-cli:8.1 php -v

```

The `/p` directory contains symlinks to other directories (if PHP version supports the module)

```
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

```

You can add as many of these as you want to `PHP_INI_SCAN_DIR`, make sure to prepend `:`.

You can read about this in greater detail by going to [PHP Modules Toggled via Environment Variables](https://jtreminio.com/blog/php-modules-toggled-via-environment-variables/).

## Xdebug

Xdebug is _installed_ but _disabled_ by default:

```shell
docker container run -it --rm jtreminio/php-cli:7.2 php -v

PHP 8.1.2 (cli) (built: Jan 24 2022 10:42:15) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.2, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.2, Copyright (c), by Zend Technologies

```

To enable Xdebug (ONLY on non-public servers!) you may use the `PHP_INI_SCAN_DIR` env var:

```shell
docker container run -it --rm \
    -e PHP_INI_SCAN_DIR=:/p/xdebug \
    jtreminio/php-cli:8.1 php -v

PHP 8.1.2 (cli) (built: Jan 24 2022 10:42:15) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.2, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.2, Copyright (c), by Zend Technologies
    with Xdebug v3.1.2, Copyright (c) 2002-2021, by Derick Rethans

```

Note the prepended `:` in `:/p/xdebug`.

`xdebug.remote_host` is set to `host.docker.internal` by default. [This will not work in Linux (yet)](https://github.com/docker/for-linux/issues/264).
You must either pass your host IP directly, or use a gateway. I have found `172.17.0.1` to work in most cases:

```shell
docker container run -it --rm \
    -e PHP_INI_SCAN_DIR=:/p/xdebug \
    -e PHP.xdebug.client_host=172.17.0.1 \
    jtreminio/php-cli:8.1 php -i | grep xdebug.client_host

639:xdebug.client_host => 172.17.0.1 => 172.17.0.1

```

A helper script has been created at `/usr/bin/xdebug` to help you debug CLI applications.

To use it, call it instead of `php` directly:

```shell
docker container run -it --rm \
    jtreminio/php-cli:8.1 xdebug -v

PHP 8.1.2 (cli) (built: Jan 24 2022 10:42:15) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.2, Copyright (c) Zend Technologies
    with Zend OPcache v8.1.2, Copyright (c), by Zend Technologies
    with Xdebug v3.1.2, Copyright (c) 2002-2021, by Derick Rethans

```

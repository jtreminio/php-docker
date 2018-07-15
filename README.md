# Official PHP images used by Dashtainer.com

These images are built from 
[Ondřej Surý's PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php)

[Docker Hub link](https://hub.docker.com/r/jtreminio/php/)

The most common PHP modules are baked in:

- calendar [[book](http://php.net/manual/en/book.calendar.php)]
- cli
- curl [[book](http://php.net/manual/en/book.curl.php)]
- ctype [[book](http://php.net/manual/en/book.ctype.php)]
- dom [[book](http://php.net/manual/en/book.dom.php)]
- exif [[book](http://php.net/manual/en/book.exif.php)]
- fileinfo [[book](http://php.net/manual/en/book.fileinfo.php)]
- fpm [[book](http://php.net/manual/en/install.fpm.php)]
- ftp [[book](http://php.net/manual/en/book.ftp.php)]
- gettext [[book](http://php.net/manual/en/book.gettext.php)]
- iconv [[book](http://php.net/manual/en/ref.iconv.php)]
- igbinary
- imagick [[book](http://php.net/manual/en/book.imagick.php)]
- intl [[book](http://php.net/manual/en/book.intl.php)]
- json [[book](http://php.net/manual/en/book.json.php)]
- mbstring [[book](http://php.net/manual/en/book.mbstring.php)]
- mongodb [[book](http://php.net/manual/en/set.mongodb.php)]
- mysqli [[book](http://php.net/manual/en/book.mysqli.php)]
- opcache [[book](http://php.net/manual/en/book.opcache.php)]
- pdo [[book](http://php.net/manual/en/book.pdo.php)]
- pdo_mysql [[book](http://php.net/manual/en/ref.pdo-mysql.php)]
- pdo_sqlite [[book](http://php.net/manual/en/ref.pdo-sqlite.php)]
- phar [[book](http://php.net/manual/en/book.phar.php)]
- posix [[book](http://php.net/manual/en/book.posix.php)]
- readline [[book](http://php.net/manual/en/book.readline.php)]
- redis
- shmop [[book](http://php.net/manual/en/book.shmop.php)]
- simplexml [[book](http://php.net/manual/en/book.simplexml.php)]
- sockets [[book](http://php.net/manual/en/book.sockets.php)]
- sqlite3 [[book](http://php.net/manual/en/book.sqlite3.php)]
- tokenizer [[book](http://php.net/manual/en/book.tokenizer.php)]
- wddx [[book](http://php.net/manual/en/book.wddx.php)]
- xmlreader [[book](http://php.net/manual/en/book.xmlreader.php)]
- xmlwriter [[book](http://php.net/manual/en/refs.xml.php)]
- xsl [[book](http://php.net/manual/en/book.xsl.php)]
- zip [[book](http://php.net/manual/en/book.zip.php)]
- xdebug [[* disabled by default](#xdebug)]

Composer is installed at `/usr/local/bin/composer`

PHP-CGI and PHP-CLI INI files, and PHP-FPM conf file are saved to standard location
across all versions to make managing them all simpler.

- PHP INI used by PHP-FPM is at `/etc/php/fpm.ini`
- PHP INI use by CLI is at `/etc/php/cli.ini`
- PHP-FPM main conf is at `/etc/php/fpm.conf`

PHP-FPM includes fix for logging to stdout and stderr created by
https://github.com/phpdocker-io/base-images

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

    $ docker container run -it --rm jtreminio/php:7.2 php -i | grep display_errors
    100:display_errors => Off => Off

vs

    $ docker container run -it --rm \
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

`xdebug.remote_host` is set to `host.docker.internal` by default.
[This will not work in Linux (yet)](https://github.com/docker/for-linux/issues/264).
You must either pass your host IP directly, or use a gateway. I have found
`172.17.0.1` to work in most cases:

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

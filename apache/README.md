#### Supported tags and respective `Dockerfile` links

* `jtreminio/php-apache:7.3` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-apache-7.3))
* `jtreminio/php-apache:7.2` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-apache-7.2))
* `jtreminio/php-apache:7.1` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-apache-7.1))
* `jtreminio/php-apache:7.0` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-apache-7.0))
* `jtreminio/php-apache:5.6` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-apache-5.6))

#### [This README best viewed on Github for formatting](https://github.com/jtreminio/php-docker/blob/master/apache/README.md)

## How to use this image

### Apache config

These PHP-FPM + Apache images come several vhost configs baked in.

[You can see the full list by going here](https://github.com/jtreminio/php-docker/tree/master/apache/files/vhost).

You can choose what vhost to use by passing the `VHOST` environment variable:

    docker container run --rm -it \
        -e VHOST=html \
        jtreminio/php-apache:7.3
    
    *** Running /etc/my_init.d/00_regen_ssh_host_keys.sh...
    *** Running /etc/my_init.d/10_syslog-ng.init...
    Dec 20 03:17:48 5f92dfc2d54d syslog-ng[13]: syslog-ng starting up; version='3.13.2'
    *** Booting runit daemon...
    *** Runit started as PID 20
    Using /etc/apache2/sites-available/html.conf
    [... snip ...]

`VHOST` can be one of

* drupal
* fpm
* html
* laravel
* symfony2
* symfony3
* symfony4
* wordpress

Visit the Github link above to explore the details of each. If `VHOST` is not defined the image defaults to `fpm`:

    docker container run --rm -it \
        jtreminio/php-apache:7.3
    
    *** Running /etc/my_init.d/00_regen_ssh_host_keys.sh...
    *** Running /etc/my_init.d/10_syslog-ng.init...
    Dec 20 03:20:13 1ebf826685db syslog-ng[13]: syslog-ng starting up; version='3.13.2'
    *** Booting runit daemon...
    *** Runit started as PID 20
    Using /etc/apache2/sites-available/fpm.conf
    [... snip ...]

The default FPM vhost config looks like:

    # /etc/apache2/sites-available/fpm.conf
    # Basic FPM
    
    <VirtualHost *:8080>
        ServerName default.localhost
        ServerAlias *
    
        DocumentRoot /var/www
    
        <FilesMatch "\.php$">
            <If "%{HTTP_COOKIE} =~ /XDEBUG_SESSION/">
                SetHandler proxy:fcgi://127.0.0.1:${PHPFPM_XDEBUG_PORT}
            </If>
            <Else>
                SetHandler proxy:fcgi://127.0.0.1:9000
            </Else>
        </FilesMatch>
    
        <Directory "/var/www">
            Options Indexes FollowSymlinks MultiViews
            AllowOverride All
            Require all granted
            DirectoryIndex index.html index.php
        </Directory>
    
        ErrorLog "/dev/stderr"
        CustomLog "/dev/stdout" combined
        LogLevel warn
        ServerSignature Off
        SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
    </VirtualHost>

The expected location of your `index.php` file is at `/var/www/index.php`.

### Custom Vhost Config

You can use your own custom vhost config by writing to file `/etc/apache2/sites-enabled/default.conf`.

If `/etc/apache2/sites-enabled/default.conf` exists then `VHOST` env var will be ignored. 

If you wish to use the built-in Xdebug support make sure to use the following `FilesMatch` directive:

    <FilesMatch "\.php$">
        <If "%{HTTP_COOKIE} =~ /XDEBUG_SESSION/">
            SetHandler proxy:fcgi://127.0.0.1:${PHPFPM_XDEBUG_PORT}
        </If>
        <Else>
            SetHandler proxy:fcgi://127.0.0.1:9000
        </Else>
    </FilesMatch>

You can read about this in greater detail at my blog post [All-in-One PHP-FPM + Nginx/Apache Containers](https://jtreminio.com/blog/all-in-one-php-fpm-nginx-apache-containers/). 

#### Built-in Xdebug support

These images come with Xdebug support but it is **disabled** by default.

To enabled Xdebug support you must pass environment variable `PHPFPM_XDEBUG=on`.

A second PHP-FPM instance will be created with Xdebug enabled, listening to port 9999. **The main PHP-FPM instance listening on port 9000 will _not_ have Xdebug enabled!**

You can debug your applications by [using PhpStorm's bookmarklets](https://www.jetbrains.com/phpstorm/marklets/).

For more information please refer to my blog post [Developing at Full Speed with Xdebug](https://jtreminio.com/blog/developing-at-full-speed-with-xdebug/), and [All-in-One PHP-FPM + Nginx/Apache Containers](https://jtreminio.com/blog/all-in-one-php-fpm-nginx-apache-containers/).

Note: If `PHPFPM_XDEBUG` is not set to `on`, the second PHP-FPM instance will NOT be created.

### docker-compose

The following example uses [Traefik](https://hub.docker.com/_/traefik/). First spin up a Traefik container:

    docker network create --driver bridge traefik_webgateway

    docker container run -d \
        --name traefik_proxy \
        --network traefik_webgateway \
        --publish 80:80 \
        --publish 8080:8080 \
        --restart always \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume /dev/null:/traefik.toml \
        traefik --api --docker \
            --docker.domain=docker.localhost --logLevel=DEBUG

Then create a `docker-compose.yml` that would look like this:

    version: '3.2'
    networks:
      public:
        external:
          name: traefik_webgateway
    services:
      web:
        image: jtreminio/php-apache:7.2
        labels:
          - traefik.backend=php-apache
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-apache.localhost
          - traefik.port=8080
        networks:
          - public
        volumes:
          - ${PWD}/index.php:/var/www/index.php

You can pass PHP INI settings like so:

    version: '3.2'
    networks:
      public:
        external:
          name: traefik_webgateway
    services:
      web:
        image: jtreminio/php-apache:7.2
        labels:
          - traefik.backend=php-apache
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-apache.localhost
          - traefik.port=8080
        networks:
          - public
        volumes:
          - ${PWD}/index.php:/var/www/index.php
        environment:
          - PHP.display_errors=On
          - PHP.error_reporting=-1

If you want to enable Xdebug support you must also pass `PHPFPM_XDEBUG`:

    version: '3.2'
    networks:
      public:
        external:
          name: traefik_webgateway
    services:
      web:
        image: jtreminio/php-apache:7.2
        labels:
          - traefik.backend=php-apache
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-apache.localhost
          - traefik.port=8080
        networks:
          - public
        volumes:
          - ${PWD}/index.php:/var/www/index.php
        environment:
          - PHP.display_errors=On
          - PHP.error_reporting=-1
          - PHPFPM_XDEBUG=On

You can easily switch vhost configs by using `VHOST`:

    version: '3.2'
    networks:
      public:
        external:
          name: traefik_webgateway
    services:
      web:
        image: jtreminio/php-apache:7.2
        labels:
          - traefik.backend=php-apache
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-apache.localhost
          - traefik.port=8080
        networks:
          - public
        volumes:
          - ${PWD}/index.php:/var/www/index.php
        environment:
          - PHP.display_errors=On
          - PHP.error_reporting=-1
          - PHPFPM_XDEBUG=On
          - VHOST=symfony2

Or, you can easily use a custom vhost config:

    version: '3.2'
    networks:
      public:
        external:
          name: traefik_webgateway
    services:
      web:
        image: jtreminio/php-apache:7.2
        labels:
          - traefik.backend=php-apache
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-apache.localhost
          - traefik.port=8080
        networks:
          - public
        volumes:
          - ${PWD}/index.php:/var/www/index.php
          - ${PWD}/vhost.conf:/etc/apache2/sites-enabled/default.conf
        environment:
          - PHP.display_errors=On
          - PHP.error_reporting=-1
          - PHPFPM_XDEBUG=On

You would need to create an `index.php` file at the same location as your `docker-compose.yml` file.

The resulting container would then be available at http://php-apache.localhost if you are using Chrome, or have installed dnsmasq.

## About these images

These images are built from [jtreminio/php](https://hub.docker.com/r/jtreminio/php/)

All PHP INI and env var features from those images apply here.

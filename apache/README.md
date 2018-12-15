#### Supported tags and respective `Dockerfile` links

* `7.3` ([php7.3-apache/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-7.3))
* `7.2` ([php7.2-apache/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-7.2))
* `7.1` ([php7.1-apache/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-7.1))
* `7.0` ([php7.0-apache/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-7.0))
* `5.6` ([php5.6-apache/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/apache/Dockerfile-5.6))

#### [This README best viewed on Github for formatting](https://github.com/jtreminio/php-docker/blob/master/apache/README.md)

## How to use this image

### Apache config

These images come with Apache preinstalled. The vhost config is good enough for a basic PHP application:

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

If you create your own custom vhost config, make sure to include the `<If>` and `<Else>` blocks for `SetHandler`.

#### Xdebug support

These images come with Xdebug support but it is **disabled** by default.

To enabled Xdebug support you must pass environment variable `PHPFPM_XDEBUG=on`.

A second PHP-FPM instance will be created with Xdebug enabled, listening to port 9999. **The main PHP-FPM instance listening on port 9000 will _not_ have Xdebug enabled!**

You can debug your applications by [using PhpStorm's bookmarklets](https://www.jetbrains.com/phpstorm/marklets/).

For more information please refer to my blog post [Developing at Full Speed with Xdebug](https://jtreminio.com/blog/developing-at-full-speed-with-xdebug/).

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
          - traefik.backend=php-apache-apache
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
          - traefik.backend=php-apache-apache
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
          - traefik.backend=php-apache-apache
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

You would need to create an `index.php` file at the same location as your `docker-compose.yml` file.

The resulting container would then be available at http://php-apache.localhost if you are using Chrome, or have installed dnsmasq.

## About these images

These images are built from [jtreminio/php](https://hub.docker.com/r/jtreminio/php/)

All PHP INI and env var features from those images apply here.

#### Supported tags and respective `Dockerfile` links

* `7.3` ([php7.3-nginx/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-7.3))
* `7.2` ([php7.2-nginx/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-7.2))
* `7.1` ([php7.1-nginx/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-7.1))
* `7.0` ([php7.0-nginx/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-7.0))
* `5.6` ([php5.6-nginx/Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-5.6))

#### [This README best viewed on Github for formatting](https://github.com/jtreminio/php-docker/blob/master/nginx/README.md)

## How to use this image

### Nginx config

These images come with Nginx preinstalled. The vhost config is good enough for a basic PHP application:

    map $cookie_XDEBUG_SESSION $my_fastcgi_pass {
        default 127.0.0.1:9000;
        xdebug  127.0.0.1:${phpfpm_xdebug_port};
    }
    
    server {
        listen *:8080 default_server;
    
        server_name _;
        root /var/www;
        index index.html index.php;
    
        location / {
            try_files $uri $uri/ /index.php$is_args$args;
        }
    
        location ~ \.php$ {
            set $path_info $fastcgi_path_info;
    
            fastcgi_pass $my_fastcgi_pass;
            fastcgi_index index.php;
            fastcgi_split_path_info ^(.+\.php)(/.*)$;
    
            include fastcgi_params;
    
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param DOCUMENT_ROOT $realpath_root;
        }
    }

The expected location of your `index.php` file is at `/var/www/index.php`.

If you create your own custom vhost config, make sure to include the `map` function at the top of your file and use `fastcgi_pass $my_fastcgi_pass`.

#### Xdebug support

These images come with Xdebug support but it is **disabled** by default.

To enabled Xdebug support you must pass environment variable `PHPFPM_XDEBUG=on`.

A second PHP-FPM instance will be created with Xdebug enabled, listening to port 9999. **The main PHP-FPM instance listening on port 9000 will _not_ have Xdebug enabled!**

You can debug your applications by [using PhpStorm's bookmarklets](https://www.jetbrains.com/phpstorm/marklets/). The IDE key must be `xdebug`, NOT `PHPSTORM`.

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
        image: jtreminio/php-nginx:7.2
        labels:
          - traefik.backend=php-nginx-nginx
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-nginx.localhost
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
        image: jtreminio/php-nginx:7.2
        labels:
          - traefik.backend=php-nginx-nginx
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-nginx.localhost
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
        image: jtreminio/php-nginx:7.2
        labels:
          - traefik.backend=php-nginx-nginx
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-nginx.localhost
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

The resulting container would then be available at http://php-nginx.localhost if you are using Chrome, or have installed dnsmasq.

## About these images

These images are built from [jtreminio/php](https://hub.docker.com/r/jtreminio/php/)

All PHP INI and env var features from those images apply here.

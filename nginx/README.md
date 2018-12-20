#### Supported tags and respective `Dockerfile` links

* `jtreminio/php-nginx:7.3` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-nginx-7.3))
* `jtreminio/php-nginx:7.2` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-nginx-7.2))
* `jtreminio/php-nginx:7.1` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-nginx-7.1))
* `jtreminio/php-nginx:7.0` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-nginx-7.0))
* `jtreminio/php-nginx:5.6` ([Dockerfile](https://github.com/jtreminio/php-docker/blob/master/nginx/Dockerfile-nginx-5.6))

#### [This README best viewed on Github for formatting](https://github.com/jtreminio/php-docker/blob/master/nginx/README.md)

## How to use this image

### Nginx config

These PHP-FPM + Nginx images come several vhost configs baked in.

[You can see the full list by going here](https://github.com/jtreminio/php-docker/tree/master/nginx/files/vhost).

You can choose what vhost to use by passing the `VHOST` environment variable:

    docker container run --rm -it \
        -e VHOST=html \
        jtreminio/php-nginx:7.3
    
    ** Running /etc/my_init.d/00_regen_ssh_host_keys.sh...
    *** Running /etc/my_init.d/10_syslog-ng.init...
    Dec 20 03:33:24 195edf7f2180 syslog-ng[13]: syslog-ng starting up; version='3.13.2'
    *** Booting runit daemon...
    *** Runit started as PID 20
    Using /etc/nginx/sites-available/html.conf
    [... snip ...]

`VHOST` can be one of

* drupal6
* drupal7
* drupal8
* fpm
* html
* laravel
* symfony2-dev (DEVELOPMENT ONLY)
* symfony2-prod
* symfony3-dev (DEVELOPMENT ONLY)
* symfony3-prod
* symfony4
* wordpress

Visit the Github link above to explore the details of each. If `VHOST` is not defined the image defaults to `fpm`:

    docker container run --rm -it \
        jtreminio/php-nginx:7.3
    
    ** Running /etc/my_init.d/00_regen_ssh_host_keys.sh...
    *** Running /etc/my_init.d/10_syslog-ng.init...
    Dec 20 03:35:07 4768163b60c4 syslog-ng[13]: syslog-ng starting up; version='3.13.2'
    *** Booting runit daemon...
    *** Runit started as PID 22
    Using /etc/nginx/sites-available/fpm.conf
    [... snip ...]

The default FPM vhost config looks like:

    # /etc/nginx/sites-available/fpm.conf
    # Basic FPM
    
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

### Custom Vhost Config

You can use your own custom vhost config by writing to file `/etc/nginx/sites-enabled/default`.

If `/etc/nginx/sites-enabled/default` exists then `VHOST` env var will be ignored. 

If you wish to use the built-in Xdebug support make sure to use the following `map` and `fastcgi_pass` directives, like above:

    map $cookie_XDEBUG_SESSION $my_fastcgi_pass {
        default 127.0.0.1:9000;
        xdebug  127.0.0.1:${phpfpm_xdebug_port};
    }
    
    server {
        [...]
        
        fastcgi_pass $my_fastcgi_pass;
        
        [...]
    }

You can read about this in greater detail at my blog post [All-in-One PHP-FPM + Nginx/Apache Containers](https://jtreminio.com/blog/all-in-one-php-fpm-nginx-apache-containers/). 

#### Built-in Xdebug support

These images come with Xdebug support but it is **disabled** by default.

To enabled Xdebug support you must pass environment variable `PHPFPM_XDEBUG=on`.

A second PHP-FPM instance will be created with Xdebug enabled, listening to port 9999. **The main PHP-FPM instance listening on port 9000 will _not_ have Xdebug enabled!**

You can debug your applications by [using PhpStorm's bookmarklets](https://www.jetbrains.com/phpstorm/marklets/). The IDE key must be `xdebug`, NOT `PHPSTORM`.

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
        image: jtreminio/php-nginx:7.2
        labels:
          - traefik.backend=php-nginx
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
          - traefik.backend=php-nginx
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
          - traefik.backend=php-nginx
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

You can easily switch vhost configs by using `VHOST`:

    version: '3.2'
    networks:
      public:
        external:
          name: traefik_webgateway
    services:
      web:
        image: jtreminio/php-nginx:7.2
        labels:
          - traefik.backend=php-nginx
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
          - VHOST=symfony2

Or, you can easily use a custom vhost config:

    version: '3.2'
    networks:
      public:
        external:
          name: traefik_webgateway
    services:
      web:
        image: jtreminio/php-nginx:7.2
        labels:
          - traefik.backend=php-nginx
          - traefik.docker.network=traefik_webgateway
          - traefik.frontend.rule=Host:php-nginx.localhost
          - traefik.port=8080
        networks:
          - public
        volumes:
          - ${PWD}/index.php:/var/www/index.php
          - ${PWD}/vhost.conf:/etc/nginx/sites-enabled/default
        environment:
          - PHP.display_errors=On
          - PHP.error_reporting=-1
          - PHPFPM_XDEBUG=On

You would need to create an `index.php` file at the same location as your `docker-compose.yml` file.

The resulting container would then be available at http://php-nginx.localhost if you are using Chrome, or have installed dnsmasq.

## About these images

These images are built from [jtreminio/php](https://hub.docker.com/r/jtreminio/php/)

All PHP INI and env var features from those images apply here.

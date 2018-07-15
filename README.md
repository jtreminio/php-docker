# Official PHP images used by Dashtainer.com

These images are built from 
[Ondřej Surý's PPA](https://launchpad.net/~ondrej/+archive/ubuntu/php)

The most common PHP modules are baked in:

- cli
- curl
- fpm
- intl
- json
- mbstring
- opcache
- xml
- zip

Composer is installed at `/usr/local/bin/composer`

PHP, CLI and FPM ini/conf files are saved to standard location across all
versions to make managing them all simpler.

- PHP INI used by PHP-FPM is at `/etc/php/fpm.ini`
- PHP INI use by CLI is at `/etc/php/cli.ini`
- PHP-FPM main conf is at `/etc/php/fpm.conf`

PHP-FPM includes fix for logging to stdout and stderr created by
https://github.com/phpdocker-io/base-images

PHP-FPM listens on port `9000` and is run by calling `/usr/bin/php-fpm`

FROM jtreminio/php:7.0
LABEL maintainer="Juan Treminio <jtreminio@gmail.com>"

RUN printf "deb [arch=amd64] http://ppa.launchpad.net/ondrej/apache2/ubuntu bionic main\n" \
>/etc/apt/sources.list.d/ondrej-apache2.list &&\
    apt-get update &&\
    apt-get install --no-install-recommends --no-install-suggests -y \
        apache2 &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}

RUN a2enmod env headers proxy proxy_http proxy_fcgi rewrite

# Set proper permissions for Apache
RUN chown -R www-data:www-data \
        /var/www &&\
    rm -rf /var/www/html

COPY files/ports.conf /etc/apache2/ports.conf
COPY files/vhost/* /etc/apache2/sites-available/
RUN rm -f /etc/apache2/sites-enabled/000-default.conf

# runit config
RUN mkdir /etc/service/apache
COPY files/apache /etc/service/apache/run
RUN chmod +x /etc/service/apache/run

RUN mkdir /etc/service/fpm-xdebug
COPY files/fpm-xdebug /etc/service/fpm-xdebug/run
RUN chmod +x /etc/service/fpm-xdebug/run &&\
    touch /var/log/fpm-xdebug-tail

# Default Apache vhost to basic FPM config
ENV VHOST=fpm

# Replace 0.0.0.0:9000
ENV FPM.listen="127.0.0.1:9000"

EXPOSE 8080

CMD ["/sbin/my_init"]

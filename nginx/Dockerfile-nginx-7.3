FROM jtreminio/php:7.3
LABEL maintainer="Juan Treminio <jtreminio@gmail.com>"

RUN printf "deb [arch=amd64] http://ppa.launchpad.net/ondrej/nginx/ubuntu bionic main\n" \
>/etc/apt/sources.list.d/ondrej-nginx.list &&\
    apt-get update &&\
    apt-get install --no-install-recommends --no-install-suggests -y \
        nginx \
        libnginx-mod-http-perl &&\
    apt-get -y --purge autoremove &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}

# Set proper permissions for Nginx
RUN chown -R www-data:www-data \
        /var/lib/nginx \
        /var/www &&\
    install -d -m 0755 -o www-data -g www-data \
        /var/cache/nginx \
        /var/run/nginx &&\
    rm -rf /var/www/html

COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/vhost/* /etc/nginx/sites-available/
RUN rm -f /etc/nginx/sites-enabled/default

# runit config
RUN mkdir /etc/service/nginx
COPY files/nginx /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

RUN mkdir /etc/service/fpm-xdebug
COPY files/fpm-xdebug /etc/service/fpm-xdebug/run
RUN chmod +x /etc/service/fpm-xdebug/run &&\
    touch /var/log/fpm-xdebug-tail

# Default Nginx vhost to basic FPM config
ENV VHOST=fpm

# Replace 0.0.0.0:9000
ENV FPM.listen="127.0.0.1:9000"

EXPOSE 8080

CMD ["/sbin/my_init"]

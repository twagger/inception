# syntax=docker/dockerfile:1

FROM    alpine:3.15

# •---------•
# | PHP-FPM |
# •---------•
# prerequisites & dependencies
RUN     apk add --no-cache \
            php7 \
            php7-fpm \
            php7-opcache

# configure PHP
COPY    conf/php.ini    "/usr/local/php/php.ini"
COPY    conf/www.conf   "/usr/local/etc/php-fpm.d/www.conf"

# •-----------•
# | WORDPRESS |
# •-----------•

EXPOSE  9000

CMD     ["php-fpm7"]
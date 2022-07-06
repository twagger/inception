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

# create the directory for pages on the container
RUN     addgroup -g 82 -S www-data ; \
        adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# configure PHP
COPY    conf/php.ini        "/etc/php7/php.ini"
COPY    conf/php-fpm.conf   "/etc/php7/php-fpm.conf"
COPY    conf/www.conf       "/etc/php7/php-fpm.d/www.conf"

# •-----------•
# | WORDPRESS |
# •-----------•

EXPOSE  9000

CMD     ["php-fpm7", "--fpm-config", "/etc/php7/php-fpm.conf"]
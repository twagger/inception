# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# install PHP from package manager
RUN     apk update && apk upgrade && apk add --update --no-cache \
            php8 \
            php8-fpm \
            php8-opcache \
            php8-mysqli \
            php8-phar \
            php8-iconv \
            mysql-client \
 &&     rm -f /var/cache/apk/* \

# bin link
 &&     ln -s /usr/bin/php8 /usr/bin/php \

# create the user and group on the container (system group, user no pwd)
 &&     addgroup -g 82 -S www-data ; \
        adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# make www dir and adjust rights
RUN     mkdir /var/www /var/www/wordpress \
 &&     chown -R www-data:www-data /var/www

# configure PHP
COPY    conf/php-fpm.conf   /etc/php8/
COPY    conf/www.conf       /etc/php8/php-fpm.d/

# copy entrypoint
COPY    script/docker-entrypoint.sh /usr/local/bin/

EXPOSE  9000

# launch command as non root
USER    www-data

ENTRYPOINT ["docker-entrypoint.sh"]
#CMD     ["php-fpm8"]
# syntax=docker/dockerfile:1
FROM    alpine:3.15

# Labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# args
ARG     wp_db_host
ARG     wp_db_user
ARG     wp_dp_password
ARG     wp_db_name
ARG     wp_table_prefix
ARG     wp_db_charset
ARG     wp_db_collate

# install PHP from package manager
RUN     apk add --no-cache \
            php8 \
            php8-fpm \
            php8-opcache \
            php8-mysqli \
            php8-phar

# bin link
 &&     ln -s /usr/bin/php8 /usr/bin/php \

# create the user and group on the container
 &&     addgroup -g 82 -S www-data ; \
        adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# configure PHP
COPY    conf/php-fpm.conf   /etc/php8/
COPY    conf/www.conf       /etc/php8/php-fpm.d/

# get wordpress files and overload with parameters

# install from latest source with wp-cli
RUN     mkdir /www \
 &&     cd /www \
 &&     wget \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 &&     chmod +x wp-cli.phar \
 &&     mv wp-cli.phar /usr/local/bin/wp \
# download wp files
 &&     wp core download \ 
# configure wp
 &&     wp config create \
            --dbname=wp_db_name \
            --dbuser=wp_db_user \
            --dbpass=wp_db_password \
            --dbhost=wp_db_host \
            --dbprefix=wp_table_prefix \
            --dbcharset=wp_db_charset \
            --dbcollate=wp_db_collate

# configure wordpress using wp-cli

EXPOSE  9000

# launch command as non root
USER    www-data

CMD     ["php-fpm8"]
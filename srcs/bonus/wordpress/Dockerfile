# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# args for proper user rights management
ARG     USER_ID=${USER_ID}
ARG     GROUP_ID=${GROUP_ID}

# workdir
WORKDIR /var/www/wordpress

# copy sql config script
COPY    .bonus/wordpress/conf/wp_db_user.sql         /tmp/mysql

# install PHP from package manager and shadow (login and pass utilities)
RUN     apk update && apk upgrade && apk add --update --no-cache \
            php8 \
            php8-fpm \
            php8-opcache \
            php8-mysqli \
            php8-phar \
            php8-iconv \
            mysql-client \
            shadow \
 &&     rm -f /var/cache/apk/* \
\
# bin link
 &&     ln -s /usr/bin/php8 /usr/bin/php \
\
# modify existing user and group on the container (system group, user no pwd)
 &&     useradd www-data -g www-data \
 &&     usermod -u ${USER_ID} www-data \
 &&     groupmod -g ${GROUP_ID} www-data \
 &&     mkdir -p /home/www-data \
 &&     chown -R www-data:www-data /home/www-data /var/www/wordpress \
\
# add tmp/mysql folder to host a config file
 &&     mkdir -p /tmp/mysql \
 &&     chown -R www-data:www-data /tmp/mysql

# configure PHP
COPY    ./requirements/wordpress/conf/php-fpm.conf   /etc/php8/
COPY    ./requirements/wordpress/conf/www.conf       /etc/php8/php-fpm.d/

# copy entrypoint
COPY    ./bonus/wordpress/script/docker-entrypoint.sh /usr/local/bin/

EXPOSE  9000

# launch command as non root
USER    www-data

ENTRYPOINT ["docker-entrypoint.sh"]

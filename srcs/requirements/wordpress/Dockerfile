# syntax=docker/dockerfile:1
FROM    alpine:3.15

# Labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# args
ARG     WP_DB_HOST
ARG     WP_DB_USER
ARG     WP_DP_PASSWORD
ARG     WP_DB_NAME
ARG     WP_TABLE_PREFIX
ARG     WP_DB_CHARSET
ARG     WP_DB_COLLATE
ARG     WP_SITE_URL
ARG     WP_SITE_TITLE
ARG     WP_ADMIN_EMAIL

# install PHP from package manager
RUN     apk update && apk upgrade && apk add --update --no-cache \
            php8 \
            php8-fpm \
            php8-opcache \
            php8-mysqli \
            php8-phar \
            mysql-client \

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
 &&     mv wp-cli.phar /usr/local/bin/wp 
# # download wp files
#  &&     wp core download \
# # configure wp
#  &&     wp config create \
#             --dbname=$WP_DB_NAME \
#             --dbuser=$WP_DB_USER \
#             --dbpass=$WP_DB_PASSWORD \
#             --dbhost=$WP_DB_HOST \
#             --dbprefix=$WP_TABLE_PREFIX \
#             --dbcharset=$WP_DB_CHARSET \
#             --dbcollate=$WP_DB_COLLATE \
#  &&     wp db create \
#  &&     wp core install \
#             --url=$WP_SITE_URL \
#             --title=$WP_SITE_TITLE \
#             --admin_user=$WP_DB_USER \
#             --admin_password=$WP_DB_PASSWORD \
#             --admin_email=$WP_ADMIN_EMAIL

EXPOSE  9000

# launch command as non root
#USER    www-data

CMD     ["php-fpm8"]
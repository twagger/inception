# syntax=docker/dockerfile:1
FROM    alpine:3.15

# Labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# install PHP from package manager
RUN     apk add --no-cache \
            php8 \
            php8-fpm \
            php8-opcache \
            php8-mysqli \
            php8-phar \

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
 &&     wget http://wordpress.org/latest.tar.gz \
 &&     tar -xzvf latest.tar.gz \
 &&     rm latest.tar.gz \
 &&     chown -R www-data:www-data wordpress \
 &&     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 &&     chmod +x wp-cli.phar \
 &&     mv wp-cli.phar /usr/local/bin/wp
#add wp-cli

# configure wordpress using wp-cli

EXPOSE  9000

# launch command as non root
USER    www-data

CMD     ["php-fpm8"]
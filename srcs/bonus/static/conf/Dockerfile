# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0

# create a folder for the website
RUN     mkdir -p /var/www/twagner

# copy website files
COPY    conf/php-fpm.conf   /etc/php8/
COPY    conf/www.conf       /etc/php8/php-fpm.d/

EXPOSE  9042

# launch command as non root
USER    adminer

CMD     ["php-fpm8"]

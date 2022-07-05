FROM    alpine:3.15

# •---------•
# | PHP-FPM |
# •---------•
# env variables
ENV     PHP_VERSION 8.1.7
ENV     PHP_URL="https://www.php.net/distributions/php-8.1.7.tar.gz"
ENV     PHP_SHA256=\
            "5f0b422a117633c86d48d028934b8dc078309d4247e7565ea34b2686189abdd8"
ENV     PHP_INI="/usr/local/php/php.ini"
ENV     WWW_CONF="/usr/local/etc/php-fpm.d/www.conf"

# prerequisites & dependencies
RUN apk add --no-cache \
        curl \
        tar \
        dpkg-dev \
        dpkg \
        xz \
        g++ \
        gcc \
        autoconf \
        pkgconf \
        automake \
        make \
        libtool \
        libc-dev \
        re2c \
        bison \
        libxml2-dev \ 
        sqlite-dev

# install PHP + PHP-FPM module
RUN     mkdir -p /usr/src && cd /usr/src ;\
        curl -fsSL -o php.tar.xz "$PHP_URL" \
        && tar zxf php.tar.xz \
        && cd ./php-8.1.7 \
        && ./configure --enable-fpm --with-mysqli \
        && make \
        && sudo make install \
        && cp php.ini-development "$PHP_INI" \
        && cp /usr/local/etc/php-fpm.d/www.conf.default "$WWW_CONF" \
        && cp sapi/fpm/php-fpm /usr/local/bin

# configure PHP
RUN     sed -i "s|;cgi.fix_pathinfo=1|cgi.fix_pathinfo=0|g" "$PHP_INI" \
        sed -i "s|user = @php_fpm_user@|user = www-data|g" "$WWW_CONF" \
        sed -i "s|group = @php_fpm_group@|group = www-data|g" "$WWW_CONF"

# •-----------•
# | WORDPRESS |
# •-----------•

EXPOSE  9000

CMD     ["/usr/local/bin/php-fpm"]
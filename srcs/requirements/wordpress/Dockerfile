FROM    alpine:3.15

# •---------•
# | PHP-FPM |
# •---------•
# env variables
ENV PHP_VERSION 8.1.7
ENV PHP_URL="https://www.php.net/distributions/php-8.1.7.tar.gz"
ENV PHP_SHA256="5f0b422a117633c86d48d028934b8dc078309d4247e7565ea34b2686189abdd8"
ENV PKG_CONFIG_PATH="/dlib-install/usr/local/lib64/pkgconfig/"

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
        && cp php.ini-development /usr/local/php/php.ini \
        && cp /usr/local/etc/php-fpm.d/www.conf.default \
            /usr/local/etc/php-fpm.d/www.conf \
        && cp sapi/fpm/php-fpm /usr/local/bin

# configure PHP

# •-----------•
# | WORDPRESS |
# •-----------•

EXPOSE  9000

CMD     ["php-fpm"]
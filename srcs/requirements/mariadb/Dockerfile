# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# install MariaDB from package manager
RUN     apk update && apk upgrade && apk add --update --no-cache \
            mariadb \
            mariadb-common \
            mariadb-client \
 &&     rm -f /var/cache/apk/* \

# modify rights + creating folder for mysql pid and socket
 &&     mkdir /run/mysqld /tmp/mysql \
 &&     chown -R mysql:mysql /etc/mysql /run/mysqld /var/lib/mysql \
        /usr/lib/mariadb /tmp/mysql \

# modify conf file
 &&     sed -i \
        's|\[client-server\]|\[client-server\]\nport=3306\nsocket=/run/mysqld/mysqld.sock|g' \
        /etc/my.cnf \
 
 &&     sed -i \
        's|\[mysqld\]|\[mysqld\]\nuser=mysql\ndatadir=/var/lib/mysql|g' \
        /etc/my.cnf \

 &&     sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" \
        /etc/my.cnf.d/mariadb-server.cnf \

 &&     sed -i "s|.*skip-networking.*|#skip-networking|g" \
        /etc/my.cnf.d/mariadb-server.cnf

#HEALTHCHECK --start-period=5m \
#            CMD mariadb -e 'SELECT @@datadir;' || exit 1

EXPOSE  3306

COPY    conf/docker-entrypoint.sh /usr/local/bin/
COPY    conf/db_config.sql        /tmp/mysql

# launch command as non root
USER    mysql

ENTRYPOINT ["docker-entrypoint.sh"]

#CMD     ["mysqld_safe"]
#CMD     ["tail", "-f", "/dev/null"]

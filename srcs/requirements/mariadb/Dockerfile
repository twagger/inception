# syntax=docker/dockerfile:1
FROM    alpine:3.15

# Labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# install MariaDB from package manager
RUN     apk update && apk upgrade && apk add --update --no-cache \
            mariadb \
            mariadb-common \
            mariadb-client \
            openrc \
 &&     rm -f /var/cache/apk/* \

# create system tables in mysql database
&&     mysql_install_db \
            --user=mysql \
            --datadir=/var/lib/mysql \

# modify /etc/my.cnf for mariadb conf
 &&     sed -i 's|\[client-server\]|\[client-server\]\nport=3306\n\
        socket=/var/lib/mysql/mysql.sock|' /etc/my.cnf \ 

 &&     sed -i 's|\[mysqld\]|\[mysqld\]\nuser=mysql\n\
        socket=/var/lib/mysql/mysql.sock|' /etc/my.cnf \

 &&     sed -i 's|skip-networking|#skip-networking|' \
        /etc/my.cnf.d/mariadb-server.cnf \

 &&     sed -i 's|#bind-address=0.0.0.0|bind-address=0.0.0.0|' \
        /etc/my.cnf.d/mariadb-server.cnf

#HEALTHCHECK --start-period=5m \
#            CMD mariadb -e 'SELECT @@datadir;' || exit 1

EXPOSE  3306

COPY    conf/docker-entrypoint.sh /usr/local/bin/

# launch command as non root
USER    mysql

ENTRYPOINT ["docker-entrypoint.sh"]

#CMD     ["mysqld_safe"]

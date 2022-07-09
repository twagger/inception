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

# create system tables in mysql database
 &&     mysql_install_db --user=mysql --ldata=/var/lib/mysql \

# modify /etc/my.cnf for mariadb conf
 &&     sed -i 's|\[client-server\]|\
        \[client-server\]\n \
        port=3306|' \
        /etc/my.cnf \ 
 &&     sed -i 's|\[mysqld\]|\
        \[mysqld\]\n \
        user=mysql\n \
        skip-networking=0\n \
        socket=/var/lib/mysql/mysql.sock|' \
        /etc/my.cnf

# secure mysql for production < Load a sql file from conf
# &&     mysql_secure_installation --user=mysql

HEALTHCHECK --start-period=5m \
            CMD mariadb -e 'SELECT @@datadir;' || exit 1

EXPOSE  3306

# launch command as non root
USER    mysql

CMD     ["mysqld_safe"]

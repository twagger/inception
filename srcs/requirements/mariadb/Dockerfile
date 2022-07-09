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
            mariadb-client

EXPOSE  3306

HEALTHCHECK --start-period=5m \
            CMD mariadb -e 'SELECT @@datadir;' || exit 1

# launch command as non root
#USER    www-data

CMD     ["mysqld"]

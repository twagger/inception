#!/bin/sh

# ENV variable init / collection
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_ROOT_USER=${MYSQL_ROOT_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}

# start service in background to execute command with client
rc-service mariadb start

# secure install
mysql -e "UPDATE mysql.user SET Password = PASSWORD('changeme') WHERE User = 'root'"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"

# users
mysql -e "USE mysql"
mysql -e "GRANT ALL ON *.* TO '${MYSQL_ROOT_USER}'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION"
mysql -e "GRANT ALL ON *.* TO '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION"
mysql -e "SET PASSWORD FOR '${MYSQL_ROOT_USER}'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}')"
mysql -e "FLUSH PRIVILEGES"

# stop daemon to launch in foreground
rc-service mariadb stop

# exec
exec mysqld_safe

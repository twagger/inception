#!/bin/sh

# ENV variable init / collection
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_ROOT_USER=${MYSQL_ROOT_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}

# init database directory
# install system databases
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# temporary startup for init purposes
service mysql start

# secure install
mysql -e "UPDATE mysql.user SET Password = PASSWORD('twag') WHERE User = 'root'"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"

# new users
mysql -e "USE mysql"
mysql -e "GRANT ALL ON *.* TO '${MYSQL_ROOT_USER}'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION"
mysql -e "GRANT ALL ON *.* TO '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION"
mysql -e "SET PASSWORD FOR '${MYSQL_ROOT_USER}'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}')"
mysql -e "FLUSH PRIVILEGES"

# stop daemon
service mysql stop

# start mysql in foreground
mysqld_safe

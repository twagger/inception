#!/bin/sh

# create a verif to launch only on setup

# install system databases
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# temp launch for init purpose (adm user creation, basic securization)
mysqld_safe --datadir=/var/lib/mysql/ &
sleep 20
eval "echo \"$(cat /tmp/mysql/db_config.sql)\"" | mariadb
pkill mariadb
rm -f /tmp/mysql/db_config.sql

# start mysql in foreground
mysqld_safe --datadir=/var/lib/mysql/

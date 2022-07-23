#!/bin/sh

# patch the install script to fix pam auth issue
patch /usr/bin/mariadb-install-db /tmp/mysql/patch_auth.txt
rm -f /tmp/mysql/patch_auth.txt

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

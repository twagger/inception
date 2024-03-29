#!/bin/sh

# download wp-cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# download wp files
./wp-cli.phar core download

# configure wp
./wp-cli.phar config create \
    --dbname=$WP_DB_NAME \
    --dbuser=$WP_DB_ADM_USER \
    --dbpass=$WP_DB_ADM_PASSWORD \
    --dbhost=$WP_DB_HOST \
    --dbprefix=$WP_TABLE_PREFIX \
    --dbcharset=$WP_DB_CHARSET \
    --dbcollate=$WP_DB_COLLATE

# create wordpress database
./wp-cli.phar db create

# install wordpress
./wp-cli.phar core install \
    --url=$WP_SITE_URL \
    --title=$WP_SITE_TITLE \
    --admin_user=$WP_DB_ADM_USER \
    --admin_password=$WP_DB_ADM_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email

# add a non root user
eval "echo \"$(cat /tmp/mysql/wp_db_user.sql)\"" > /tmp/mysql/import.sql
mysql -h mariadb -u $WP_DB_ADM_USER --password=$WP_DB_ADM_PASSWORD < "/tmp/mysql/import.sql"
rm -rf /tmp/mysql/wp_db_user.sql /tmp/mysql/import.sql

# add a theme
./wp-cli.phar theme install twentytwenty --activate

# launch php-fpm
php-fpm8

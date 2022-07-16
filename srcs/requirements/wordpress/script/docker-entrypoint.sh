#!/bin/sh

cd /var/www/wordpress

# download wp-cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# download wp files
wp core download

# wait for mariadb server to be fully up
#sleep 30

# configure wp
wp config create \
    --dbname=$WP_DB_NAME \
    --dbuser=$WP_DB_USER \
    --dbpass=$WP_DB_PASSWORD \
    --dbhost=$WP_DB_HOST \
    --dbprefix=$WP_TABLE_PREFIX \
    --dbcharset=$WP_DB_CHARSET \
    --dbcollate=$WP_DB_COLLATE \

# create wordpress database
wp db create

# install wordpress
wp core install \
    --url=$WP_SITE_URL \
    --title=$WP_SITE_TITLE \
    --admin_user=$WP_DB_USER \
    --admin_password=$WP_DB_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL

# launch php-fpm
php-fpm8

USE wordpress;

-- new admin user
GRANT ALL ON *.* TO '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON *.* TO '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
SET PASSWORD FOR '$MYSQL_ROOT_USER'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD');

-- new standard user
GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON *.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;
SET PASSWORD FOR '$MYSQL_USER'@'localhost'=PASSWORD('$MYSQL_PASSWORD');

-- secure install
DELETE FROM mysql.user WHERE User = 'root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP USER IF EXISTS ''@'$HOSTNAME';
DROP USER IF EXISTS ''@'localhost';
DROP DATABASE IF EXISTS test;

-- apply
FLUSH PRIVILEGES;

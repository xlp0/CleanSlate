-- create databases
CREATE DATABASE IF NOT EXISTS `matomo`;
CREATE DATABASE IF NOT EXISTS `nextdb`;

-- create matomo user
CREATE USER 'matomodb'@'localhost' IDENTIFIED BY 'matomo-pass';
GRANT ALL PRIVILEGES ON *.* TO 'matomodb'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'matomodb'@'localhost';

-- create nextcloud user
CREATE USER 'nextdb'@'localhost' IDENTIFIED BY 'nextdb-pass';
GRANT ALL PRIVILEGES ON *.* TO 'nextdb'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'nextdb'@'localhost';
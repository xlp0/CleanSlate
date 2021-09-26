-- create databases
CREATE DATABASE IF NOT EXISTS `matomo`;
CREATE DATABASE IF NOT EXISTS `gitea`;

-- create matomo user
CREATE USER 'matomodb'@'%' IDENTIFIED BY 'matomo-pass';
GRANT ALL PRIVILEGES ON *.* TO 'matomodb'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'matomodb'@'%';

-- create gitea user
CREATE USER 'gitea'@'%' IDENTIFIED BY 'gitea-pass';
GRANT ALL PRIVILEGES ON *.* TO 'gitea'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'gitea'@'%';

FLUSH PRIVILEGES;
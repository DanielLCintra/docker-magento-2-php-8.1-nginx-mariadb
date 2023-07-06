CREATE USER 'magento2'@'localhost' IDENTIFIED BY 'secret';
CREATE DATABASE magento2;
GRANT ALL PRIVILEGES ON magento2.* TO 'magento2'@'localhost';
FLUSH PRIVILEGES;
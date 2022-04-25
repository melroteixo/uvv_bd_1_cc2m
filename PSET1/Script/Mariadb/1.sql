CREATE USER 'vtm' IDENTIFIED BY 'vtm';

CREATE DATABASE uvv CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

GRANT ALL PRIVILEGES ON uvv * . * TO 'vtm';

SYSTEM mysql -u vtm -p;

USE uvv;


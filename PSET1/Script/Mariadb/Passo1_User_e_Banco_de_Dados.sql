CREATE USER vtm IDENTIFIED BY '';

GRANT ALL PRIVILEGES ON *.* TO vtm;
--Entrar com senha: vtm
SYSTEM mysql -u vtm -p;

CREATE DATABASE uvv CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;




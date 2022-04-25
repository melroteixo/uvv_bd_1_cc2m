-- Cria usuário do SGBD
CREATE USER vinicius IDENTIFIED BY '';

-- Cria Banco de dados UVV com suas propriedades e permissões
CREATE DATABASE uvv CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Concede todos privilégios de administrador ao usuário
GRANT ALL PRIVILEGES ON uvv.* TO vinicius; 

-- Entra com o usuário criado no SGBD
SYSTEM mysql -u vinicius -p;




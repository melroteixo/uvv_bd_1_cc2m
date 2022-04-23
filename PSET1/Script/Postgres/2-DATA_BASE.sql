--create database--
CREATE DATABASE uvv
    WITH 
    OWNER  viniciusteixeiramelo
    TEMPLATE  template0 
    ENCODING  'UTF8'
    LC_COLLATE  'pt_BR.UTF-8' 
    LC_CTYPE  'pt_BR.UTF-8'
    ALLOW_CONNECTIONS  true;

--trocando para uvv
\connect uvv
--
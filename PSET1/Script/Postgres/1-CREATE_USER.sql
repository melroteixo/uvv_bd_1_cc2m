--criando role
CREATE ROLE viniciusteixeiramelo 
  WITH
      SUPERUSER
      CREATEDB 
      CREATEROLE
      INHERIT
      LOGIN
      NOREPLICATION 
      BYPASSRLS
      CONNECTION LIMIT  -1
      PASSWORD 'vmt';
--
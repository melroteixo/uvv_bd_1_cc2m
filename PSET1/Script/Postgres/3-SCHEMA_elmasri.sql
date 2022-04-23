--criando schema--

CREATE SCHEMA IF NOT EXISTS elmasri
    AUTHORIZATION viniciusteixeiramelo;

-- direcionando para o schema elmasri
ALTER ROLE viniciusteixeiramelo 
SET search_path TO elmasri, viniciusteixeiramelo, public;

--criando role--
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

  
--criando schema

CREATE SCHEMA IF NOT EXISTS elmasri
    AUTHORIZATION viniciusteixeiramelo;

-- direcionando para o schema elmasri
ALTER ROLE viniciusteixeiramelo 
SET search_path TO elmasri, viniciusteixeiramelo, public;


CREATE TABLE elmasri.funcionario (
                cpf_funcionario VARCHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1) CHECK(sexo = 'M' or sexo = 'F' or sexo = 'm' or sexo = 'f'),
                cpf_supervisor VARCHAR(11),
                salario NUMERIC(10,2),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT cpf_funcionario_pk PRIMARY KEY (cpf_funcionario)
);


CREATE TABLE elmasri.dependente (
                nome_dependente VARCHAR(15) NOT NULL,
                cpf_funcionario VARCHAR(11) NOT NULL,
                sexo CHAR(1) CHECK(sexo = 'M' or sexo = 'F' or sexo = 'm' or sexo = 'f'),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT cpf_funcionario_dependente_pk PRIMARY KEY (nome_dependente, cpf_funcionario)
);


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL CHECK (numero_departamento > 0 AND numero_departamento < 21),
                cpf_gerente VARCHAR(11) NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT numero_departamento_pk PRIMARY KEY (numero_departamento)
);


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.localizacoes_departamento (
                local VARCHAR(50) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT numero_departamento_localizacao_pk PRIMARY KEY (local, numero_departamento)
);


CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                numero_departamento INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(50),
                CONSTRAINT numero_projeto_pk PRIMARY KEY (numero_projeto)
);


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario VARCHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1),
                CONSTRAINT cpf_funcionario_trabalhaem_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk1
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

-- Inserindo objetos
--Inserindo objetos na tabela funcionario
INSERT INTO elmasri.funcionario
    (primeiro_nome, nome_meio, ultimo_nome, cpf_funcionario, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento) 
        VALUES
        ('Jorge'    , 'E'   , 'Brito'    , '88866555576'    , '10-11-1937'  , 'R.do Horto,35,São Paulo,SP'            , 'M' , 55000 , NULL          , 1),
        ('Fernando' , 'T'   , 'Wong'     , '33344555587'    , '1955-12-08'  , 'R.da Lapa,34,São Paulo,SP'             , 'M' , 40000 , '88866555576' , 5),
        ('João'     , 'B'   , 'Silva'    , '12345678966'    , '1965-01-09'  , 'R.das Flores,751,São Paulo,SP'         , 'M' , 30000 , '33344555587' , 5),
        ('Jennifer' , 'S'   , 'Souza'    , '98765432168'    , '1941-06-20'  , 'Av. Arthur de Lima,54,Santo André,SP'  , 'F' , 43000 , '88866555576' , 4),
        ('Ronaldo'  , 'K'   , 'Lima'     , '66688444476'    , '1962-09-15'  , 'R.Rebouças,65,Piracicaba,SP'           , 'M' , 38000 , '33344555587' , 5),
        ('Joice'    , 'A'   , 'Leite'    , '45345345376'    , '1972-07-31'  , 'Av.Lucas Obes,74,São Paulo,SP'         , 'F' , 25000 , '33344555587' , 5),
        ('André'    , 'V'   , 'Perreira' , '98798798733'    , '1969-03-29'  , 'R.Timbira,35,São Paulo,SP'             , 'M' , 25000 , '98765432168' , 4),
        ('Alice'    , 'J'   , 'Zelaya'   , '99988777767'    , '1968-01-19'  , 'R.Souza Lima,35,Curitiba,PR'           , 'F' , 25000 , '98765432168' , 4)
;

-- Inserindo objetos na tabela 
INSERT INTO elmasri.departamento
    (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente) 
        VALUES
        ('Pesquisa'    ,  5  , '33344555587', 05-22-1988),
        ('Administração' ,  4  , '987554' , '),
        
;
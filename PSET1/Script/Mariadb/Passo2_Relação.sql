--Conectando ao banco de dados uvv
USE uvv;

--Inserindo dados na tabela
CREATE TABLE funcionario (
                cpf_funcionario VARCHAR(11) NOT NULL COMMENT 'CPF do funcionário. Será a PK da tabela.',
                primeiro_nome VARCHAR(15) NOT NULL COMMENT 'Primeiro nome do funcionário.',
                nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.',
                ultimo_nome VARCHAR(15) NOT NULL COMMENT 'Sobrenome do funcionário.',
                data_nascimento DATE COMMENT 'Data de nascimento do funcionário.',
                endereco VARCHAR(50) COMMENT 'Endereço do funcionário.',
                sexo CHAR(1) COMMENT 'Sexo do funcionário'	
                    CHECK(sexo = 'M' or sexo = 'F' or sexo = 'm' or sexo = 'f'),
                cpf_supervisor VARCHAR(11) COMMENT 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).'
                    CHECK (cpf_supervisor != cpf_funcionario),
                salario NUMERIC(10,2) COMMENT 'Salário do funcionário',
                numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento do funcionário.',
                CONSTRAINT cpf_funcionario_pk PRIMARY KEY (cpf_funcionario)
);
-- Table comments
ALTER TABLE funcionario COMMENT 'Tabela que armazena as informações dos funcionários. Cpf do funcionario, primeiro nome, segundo nome, ultimo nome, nascimento, endereço, sexo, cpf do supervidor daquele funcionario,salario e numero do departamento';
-- End Table Funcionario

CREATE TABLE dependente (
                nome_dependente VARCHAR(15) NOT NULL COMMENT 'Nome do dependente. É a PK desta tabela,.',
                cpf_funcionario VARCHAR(11) NOT NULL COMMENT 'CPF do funcionário. É a PK desta tabela e é uma FK da tabela funcionário referenciando cpf_funcionario.',
                sexo CHAR(1) COMMENT 'Sexo do dependente. Masculino(M/m)/Feminino(F/f)' 
                    CHECK(sexo = 'M' or sexo = 'F' or sexo = 'm' or sexo = 'f'), 	
                data_nascimento DATE COMMENT 'Data de nascimento do dependente. ANO/MES/DIA',
                parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.',
                CONSTRAINT cpf_funcionario_dependente_pk PRIMARY KEY (nome_dependente, cpf_funcionario)
);
-- Table comments
ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários. Nome, cpf do funcionario, sexo, nascimento e parentesco';
-- End Table dependente


CREATE TABLE departamento (
                numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento. É a PK desta tabela.'
                    CHECK (numero_departamento > 0 AND numero_departamento < 21) ,
                cpf_gerente VARCHAR(11) NOT NULL COMMENT 'CPF do gerente do departamento. É uma FK para a tabela funcionários referenciando o cpf do funcionario.',
                nome_departamento VARCHAR(15) NOT NULL COMMENT 'Nome do departamento. Deve ser único.',
                data_inicio_gerente DATE COMMENT 'Data do início desse gerente nesse departamento.',
                CONSTRAINT numero_departamento_pk PRIMARY KEY (numero_departamento)
);
-- Table comments
ALTER TABLE departamento COMMENT 'Tabela que armazena as informaçoẽs dos departamentos. Numero do departamento, cpf do gerente, nome do departamento e data de inicio do gerente.';
-- End Table Departamento

CREATE UNIQUE INDEX departamento_idx
 ON uvv.departamento
 ( nome_departamento );


CREATE TABLE localizacoes_departamento (
                local VARCHAR(50) NOT NULL COMMENT 'Localização do departamento. Faz parte da PK desta tabela. ',
                numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.',
                CONSTRAINT numero_departamento_localizacao_pk PRIMARY KEY (local, numero_departamento)
);

-- Table comments
ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos. Localização e numero do departamento';
-- End Table localizacoes_departamento




CREATE TABLE projeto (
                numero_projeto INTEGER NOT NULL COMMENT 'Número do projeto. É a PK desta tabela.',
                numero_departamento INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL COMMENT 'Nome do projeto. Deve ser único.',
                local_projeto VARCHAR(50) COMMENT 'Localização do projeto.',
                CONSTRAINT numero_projeto_pk PRIMARY KEY (numero_projeto)
);
-- Table comments
ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';
-- End Table Projeto

CREATE UNIQUE INDEX projeto_idx
 ON uvv.projeto
 ( nome_projeto );


CREATE TABLE trabalha_em (
                cpf_funcionario VARCHAR(11) NOT NULL COMMENT 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.',
                numero_projeto INTEGER NOT NULL COMMENT 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.',
                horas NUMERIC(3,1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.',
                CONSTRAINT cpf_funcionario_trabalhaem_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);

-- Table comments
ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
-- End Table trabalha_em
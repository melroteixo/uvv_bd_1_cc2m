--Inserindo objetos na tabela funcionario
INSERT INTO uvv.funcionario
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

--Inserindo objetos na tabela departamento
INSERT INTO uvv.departamento
(numero_departamento, cpf_gerente, nome_departamento, data_inicio_gerente)
	VALUES  
    (5, '33344555587', 'Pesquisa', '1988-05-22'),
	(4,'98765432168', 'Administração', '1995-01-01'),
	(1,'88866555576', 'Matriz', '1981-06-19')
	;
--Inserindo objetos na tabela localizacoes departamento
    INSERT INTO uvv.localizacoes_departamento
    (local, numero_departamento)
	VALUES 
    ('São Paulo', 1),
	('Mauá', 4),
	('Santo André', 5),
	('Itu', 5),
	('São Paulo', 5);
-- Inserindo objetos na tabela projeto
INSERT INTO uvv.projeto
(numero_projeto, numero_departamento, nome_projeto, local_projeto)
	VALUES 	
    (1, 5, 'ProdutoX', 'Santo André'),
	(2, 5, 'ProdutoY', 'Itu'),
	(3, 5, 'ProdutoZ', 'São Paulo'),
	(10, 4, 'Informatização', 'Mauá'),
	(20, 1,'Reorganização' , 'São Paulo'),
	(30, 4, 'Novosbeneficios', 'Mauá');

INSERT INTO uvv.dependente(
	nome_dependente, cpf_funcionario, sexo, data_nascimento, parentesco)
	VALUES
    ('Alicia','33344555587','F','1986-04-05','Filha'),
    ('Tiago','33344555587','M','1983-10-25','Filho'),
    ('Janaia','33344555587','F','1958-05-03','Esposa'),
    ('Antonio','98765432168','M','1942-02-28','Marido'),
    ('Michel','12345678966','M', '1988-01-04','Filho'),
    ('Alicia','12345678966','F', '1988-12-30','Filha'),
    ('Elizabeth','12345678966','F', '1967-05-05','Esposa');

INSERT INTO uvv.trabalha_em(
	cpf_funcionario, numero_projeto, horas)
	VALUES 
    ('12345678966',1,32.5),
    ('12345678966',2,7.5),
    ('66688444476',3,40.0),
    ('45345345376',1,20.0),
    ('45345345376',2,20.0),
    ('33344555587',2,10.0),
    ('33344555587',3,10.0),
    ('33344555587',10,10.0),
    ('33344555587',20,10.0),
    ('99988777767',30,30.0),
    ('99988777767',10,10.0),
    ('98798798733',10,35.0),
    ('98798798733',30,5.0),
    ('98765432168',30,20.0),
    ('98765432168',20,15.0),
    ('88866555576',20,NULL);
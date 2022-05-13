-- Questão 1) Prepare um relatório que mostre a média salarial dos funcionários de cada departamento:

SELECT depa.nome_departamento , CAST(AVG(salario) AS DECIMAL (10,2)) AS "media do salario"
FROM funcionario AS fun
INNER JOIN
departamento AS depa ON depa.numero_departamento = fun.numero_departamento
GROUP BY depa.nome_departamento;

--inner join = apenas oque ambas tabelas tem em comum
-- Group by = organizar por X
-------------------------------------------------------------------

-- Questão 2) prepare um relatório que mostre a média salarial dos homens e das mulheres:


SELECT (CASE WHEN(fun.sexo = 'M') THEN 'Homens' END) AS sexo, 
CAST(AVG(salario) AS DECIMAL(10, 2)) AS "media do salario por sexo"
FROM funcionario AS fun
WHERE fun.sexo = 'M'
GROUP BY fun.sexo
UNION
SELECT (CASE WHEN(fun.sexo = 'F') THEN 'Mulheres' END) AS sexo, 
CAST(AVG(salario) AS DECIMAL(10, 2)) AS "media do salario por sexo"
FROM funcionario AS fun
WHERE fun.sexo = 'F'
GROUP BY fun.sexo; 

-- cast = formatar para um certo tipo (invocar informacao como X)
-- case = if - then - else - end (caso algo ocorra entao isso deve tbm mudar)
-------------------------------------------------------------------

-- Questão 3) prepare um relatório que liste o nome dos departamentos e, para cada departamento, inclua as seguintes informações de seus funcionários: 
-- o nome completo, a data de nascimento, a idade em anos completos e o salário:
SELECT depa.nome_departamento, (fun.primeiro_nome||' '||fun.nome_meio||' '||fun.ultimo_nome) AS nome_completo, DATE_PART('year', AGE(fun.data_nascimento)) AS idade, fun.salario
FROM departamento AS depa
INNER JOIN funcionario AS fun
ON depa.numero_departamento = fun.numero_departamento;
-------------------------------------------------------------------


-- Questão 4) Relatório do nome do departamento e o nome completo, data de nascimento, idade e salário de cada funcionário:
SELECT depa.nome_departamento, (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS nome_completo, fun.data_nascimento, DATE_PART('year', AGE(fun.data_nascimento)) AS idade, 
CAST(fun.salario AS DECIMAL(10,2))
FROM funcionario AS fun
INNER JOIN
departamento AS depa ON (fun.numero_departamento = depa.numero_departamento);
-------------------------------------------------------------------

-- Questão 5) Relatório que apresenta o nome completo dos funcionários, idade, salário atual e o salário reajustado em 20% caso o atual 
-- seja inferior à 35 mil ou em 15% caso seja superior a esse valor:
SELECT (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS nome_completo, DATE_PART('year', AGE(fun.data_nascimento)) AS idade, 
CAST(fun.salario AS DECIMAL(10,2)) AS "salario atual", CAST(fun.salario*1.2 AS DECIMAL(10,2)) AS "salario pós reajuste"
FROM funcionario AS fun, departamento AS depa
WHERE salario < 35000 AND fun.numero_departamento = depa.numero_departamento
UNION
SELECT DISTINCT (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS nome_completo, DATE_PART('year', AGE(fun.data_nascimento)) AS idade, 
CAST(fun.salario AS DECIMAL(10,2)) AS "salario atual", CAST(fun.salario*1.15 AS DECIMAL(10,2)) AS "salario pós reajuste"
FROM funcionario AS fun, departamento AS depa
WHERE salario >= 35000 AND fun.numero_departamento = depa.numero_departamento;
-------------------------------------------------------------------

-- Questão 6)  Relatório com a lista o nome do gerente e dos funcionários de cada departamento e ordena por nome do departamento (em ordem crescente) 
-- e pelo salário dos funcionários (em ordem decrescente):
SELECT depa.nome_departamento,
(CASE WHEN(depa.cpf_gerente = '88866555576') THEN 'Jorge E Brito' WHEN(depa.cpf_gerente = '98765432168') THEN 'Jennifer S Souza' WHEN(depa.cpf_gerente = '33344555587') THEN 'Fernando T Wong' END) 
AS "nome do gerente", (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS "nome do funcionario", fun.salario
FROM departamento AS depa, funcionario AS fun
WHERE depa.numero_departamento = fun.numero_departamento
ORDER BY depa.nome_departamento ASC, fun.salario DESC;
-------------------------------------------------------------------

-- Questão 7) Relatório com o nome completo dos funcionários que possuem pelo menos um dependente, o departamento onde 
-- trabalham e o nome completo, idade e sexo do(s) dependente(s):
SELECT depa.nome_departamento, (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS "nome do funcionário", dep.nome_dependente, DATE_PART('year', AGE(dep.data_nascimento)) AS "idade do dependente", 
(CASE WHEN(dep.sexo = 'M') THEN 'Masculino' WHEN (dep.sexo = 'F') THEN 'Feminino' END) AS sexo
FROM funcionario AS fun
INNER JOIN
dependente AS dep ON dep.cpf_funcionario = fun.cpf
INNER JOIN
departamento AS depa ON depa.numero_departamento = fun.numero_departamento;
-------------------------------------------------------------------

-- Questão 8) Relatório com o nome completo, departamento e salário de cada funcionário que não possui dependente:
SELECT (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS "nome do funcionário", d.nome_departamento, 
CAST(salario AS DECIMAL(10,2))
FROM funcionario AS fun, departamento AS d
WHERE fun.cpf NOT IN (SELECT d.cpf_funcionario FROM dependente AS d) AND d.numero_departamento = fun.numero_departamento;
-------------------------------------------------------------------

-- Questão 9) Relatório que mostra, para cada departamento, os seus projetos e nome completo de cada funcionário alocado em cada projeto e o número de horas trabalhadas:
SELECT depa.numero_departamento, pro.nome_projeto, (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS "nome do funcionário", 
CAST(trab.horas AS DECIMAL(3,1)) 
FROM funcionario AS fun
INNER JOIN
trabalha_em AS trab ON fun.cpf = trab.cpf_funcionario
INNER JOIN 
projeto AS pro ON trab.numero_projeto = pro.numero_projeto
INNER JOIN
departamento AS depa ON depa.numero_departamento = pro.numero_departamento
ORDER BY depa.nome_departamento ASC, pro.nome_projeto ASC;
-------------------------------------------------------------------

-- Questão 10) Relatório da soma total das horas de cada projeto em cada departamento, o nome do departamento e do projeto:
SELECT depa.nome_departamento, pro.nome_projeto, SUM(trab.horas) AS "horas trabalhadas"
FROM trabalha_em AS trab
INNER JOIN 
projeto AS pro ON pro.numero_projeto = trab.numero_projeto
INNER JOIN
departamento AS depa ON depa.numero_departamento = pro.numero_departamento
GROUP BY depa.nome_departamento, pro.nome_projeto
ORDER BY depa.nome_departamento ASC;
-------------------------------------------------------------------

-- Questão 11) Relatório do nome completo do funcionário, nome do projeto em que ele trabalha e o valor que ele receberá referente às horas trabalhadas neles, considerando 50 reais por hora:
SELECT (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS nome_funcionário, pro.nome_projeto, CAST(trab.horas*50 AS DECIMAL (10,2)) AS valor_pagamento
FROM funcionario AS fun
INNER JOIN
trabalha_em AS trab ON trab.cpf_funcionario = fun.cpf
INNER JOIN
projeto AS pro ON pro.numero_projeto = trab.numero_projeto;
-------------------------------------------------------------------

-- Questão 12) Relatório que exibe o nome do departamento, do projeto e o nome dos funcionários que não registraram nenhuma hora trabalhada:
SELECT depa.numero_departamento, pro.numero_projeto, (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS nome_funcionário, 
(CASE WHEN(trab.horas IS NULL) THEN 'Nenhuma' END) AS horas_trabalhadas
FROM funcionario AS fun
INNER JOIN
trabalha_em AS trab ON trab.cpf_funcionario = fun.cpf AND trab.horas IS NULL
INNER JOIN
projeto AS pro ON pro.numero_projeto = trab.numero_projeto
INNER JOIN
departamento AS depa ON depa.numero_departamento = pro.numero_departamento;
-------------------------------------------------------------------

-- Questão 13) Relatório que exibe o nome completo, sexo e idade de todos os funcionários e seus dependentes em ordem decrescente da idade em anos completos:
SELECT (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS nome, fun.sexo, DATE_PART('year', AGE(fun.data_nascimento)) AS idade
FROM funcionario AS fun
UNION
SELECT dep.nome_dependente AS nome, dep.sexo, DATE_PART('year', AGE(dep.data_nascimento)) AS idade
FROM dependente AS dep
ORDER BY idade DESC;
-------------------------------------------------------------------

-- Questão 14) Relatório que exibe a quantidade de funcionários de cada departamento:
SELECT depa.nome_departamento, COUNT(fun.cpf) AS numero_funcionarios
FROM funcionario AS fun
INNER JOIN
departamento AS depa ON depa.numero_departamento = fun.numero_departamento
GROUP BY depa.nome_departamento;
-------------------------------------------------------------------

-- Questão 15) Relatório com o nome completo dos funcionários, seu departamento e o nome dos projetos em que cada um está alocado:
SELECT (fun.primeiro_nome ||' '|| fun.nome_meio ||' '|| fun.ultimo_nome) AS nome_funcionario, depa.nome_departamento, pro.nome_projeto
FROM funcionario AS fun
INNER JOIN
departamento AS depa ON fun.numero_departamento = depa.numero_departamento
INNER JOIN 
trabalha_em AS trab ON trab.cpf_funcionario = fun.cpf
INNER JOIN
projeto AS pro ON pro.numero_projeto = trab.numero_projeto
ORDER BY nome_funcionario ASC;
-------------------------------------------------------------------
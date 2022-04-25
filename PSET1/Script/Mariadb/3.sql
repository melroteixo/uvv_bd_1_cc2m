ALTER TABLE uvv.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES uvv.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE uvv.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES uvv.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE uvv.departamento ADD CONSTRAINT funcionario_departamento_fk 
FOREIGN KEY (cpf_gerente)
REFERENCES uvv.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE uvv.departamento ADD CONSTRAINT funcionario_departamento_fk1
FOREIGN KEY (cpf_gerente)
REFERENCES uvv.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE uvv.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES uvv.funcionario (cpf_funcionario)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE uvv.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES uvv.departamento (numero_departamento)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE uvv.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES uvv.departamento (numero_departamento)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

ALTER TABLE uvv.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES uvv.projeto (numero_projeto)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
;

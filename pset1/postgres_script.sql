CREATE USER mariafiorio WITH 
CREATEDB
CREATEROLE
INHERIT
LOGIN;

CREATE DATABASE uvv 
owner mariafiorio 
template template0 
encoding utf8 
lc_collate 'pt_BR.UTF-8'
lc_ctype 'pt_BR.UTF-8' 
allow_connections true;

\c uvv;

CREATE SCHEMA elmasri AUTHORIZATION mariafiorio;
select current_schema ();
show search_path;
set search_path to elmasri, "$user", public;


CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
);

COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'Data de nascimento do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário.';


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
);

COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazenas as informações dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para tabela. funcionários.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente do departamento,';


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Número do departameno. É uma FK para a tabela departamento,';


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_pk PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parte da PK desta tabela e também é uma FK  para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';


CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes e dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela e é uma FK para tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';


ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



ALTER TABLE elmasri.funcionario ALTER COLUMN endereco TYPE varchar(100);

ALTER TABLE elmasri.funcionario ALTER COLUMN cpf_supervisor DROP NOT NULL;

ALTER TABLE elmasri.trabalha_em ALTER COLUMN horas DROP NOT NULL;

INSERT INTO elmasri.funcionario
(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES
('João','B','Silva','12345678966', '01-09-1965', 'Rua das Flores,751, São Paulo, SP', 'M',30.000, '33344555587',4),
('Fernando','T','Wong','33344555587','12-08-1955','Rua da Lapa, 34, São Paulo, SP', 'M',40.000, '88866555576', 5),
('Alice', 'J','Zelaya','99988777767','01-19-1968','Rua Souza Lima, 35, Curitiba, PR', 'F',25.000,'98765432168',4),
('Jennifer', 'S','Souza', '98765432168','06-20-1941', 'Av. Arthur de Lima, 54, Santo André, SP','F',43.000,'88866555576',4),
('Ronaldo', 'K','Lima', '66688444476','09-15-1962', 'Rua Rebouças, 65, Piracicaba,SP','M',38.000,'33344555587',5),
('Joice', 'A','Leite', '45345345376','07-31-1972', 'Av. Lucas Obes, 74, São Paulo, SP','F',25.000,'33344555587',5),
('André', 'V','Pereira', '98798798733','03-29-1969', 'Rua Timbira, 35, São Paulo, SP','M',25.000,'98765432168',4),
('Jorge', 'E','Brito', '88866555576','11-10-1937', 'Rua do Horto, 35, São Paulo, SP','M',55.000,NULL,1)
;



INSERT INTO elmasri.departamento
(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES
('Pesquisa',5,'33344555587','05-22-1988'),
('Administração',4, '98765432168', '01-01-1995'),
('Matriz',1,'88866555576', '06-19-1981');

INSERT INTO elmasri.localizacoes_departamento
(numero_departamento, local)
VALUES
('1', 'São Paulo'),
('4', 'Mauá'),
('5', 'Santo André'),
('5', 'Itu'),
('5', 'São Paulo');

INSERT INTO elmasri.projeto
(nome_projeto, numero_projeto, local_projeto, numero_departamento)
values
('ProdutoX',1,'Santo André',5),
('ProdutoY',2,'Itu',5),
('ProdutoZ',3,'São Paulo',5),
('Informatização',10,'Mauá',4),
('Reorganização',20,'São Paulo',1),
('Novosbenefícios',30,'Mauá',4);

INSERT INTO elmasri.dependente
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES
('33344555587', 'Alicia','F','04-05-1986','Filha'),
('33344555587', 'Tiago','M','10-25-1983','Filho'),
('33344555587', 'Janaína','F','05-03-1958','Esposa'),
('98765432168', 'Antonio','M','04-05-1986','Marido'),
('12345678966', 'Michael','M','04-05-1986','Filho'),
('12345678966', 'Alicia','F','04-05-1986','Filha'),
('12345678966', 'ELizabeth','F','04-05-1986','Esposa');


INSERT INTO elmasri.trabalha_em
(cpf_funcionario, numero_projeto, horas)
VALUES
('12345678966', 1,'32.5'),
('12345678966', 2,'7.5'),
('66688444476', 3,'40.0'),
('45345345376', 1,'20.0'),
('45345345376', 2,'20.0'),
('33344555587', 2,'10.0'),
('33344555587', 3,'10.0'),
('33344555587', 10,'10.0'),
('33344555587', 20,'10.0'),
('99988777767', 30,'30.0'),
('99988777767', 10,'10.0'),
('98798798733', 10,'35.0'),
('98798798733', 30,'5.0'),
('98765432168', 30,'20.0'),
('98765432168', 20,'15.0'),
('88866555576', 20, NULL);

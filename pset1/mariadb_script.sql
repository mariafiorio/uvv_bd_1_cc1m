CREATE USER 'mariafiorio'@'%' IDENTIFIED BY '123';

create database uvv;

use uvv;

grant all privileges on uvv.* to mariafiorio;

create table funcionario ( -- Tabela que armazena as informações dos funcionários.
                cpf CHAR(11) NOT NULL, -- CPF do funcionário. Será a PK da tabela.
                primeiro_nome VARCHAR(15) NOT NULL, -- Primeiro nome do funcionário.
                nome_meio CHAR(1), -- Inicial do nome do meio.
                ultimo_nome VARCHAR(15) NOT NULL, -- Sobrenome do funcionário.
                data_nascimento DATE, -- Data de nascimento do funcionário.
                endereco VARCHAR(100), -- Endereço do funcionário.
                sexo CHAR(1), -- Sexo do funcionário.
                salario NUMERIC(10,2), -- Salário do funcionário.
                cpf_supervisor CHAR(11), -- CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).
                numero_departamento INTEGER NOT NULL, -- Número do departamento do funcionário.
                PRIMARY KEY (cpf)
);

alter table funcionario add constraint check (sexo in ('M','F')); -- Garante a restrição de resposta do campo para F ou M.



create table departamento ( -- Tabela que armazenas as informações dos departamentos.
                numero_departamento INTEGER NOT NULL, -- Número do departamento. É a PK desta tabela.
                nome_departamento VARCHAR(15) NOT NULL, -- Nome do departamento. Deve ser único.
                cpf_gerente CHAR(11) NOT NULL, -- CPF do gerente do departamento. É uma FK para tabela. funcionários.
                data_inicio_gerente DATE, -- Data do início do gerente do departamento.
                PRIMARY KEY (numero_departamento)
);

create unique index departamento_idx
on departamento 
(nome_departamento);

create table projeto ( -- Tabela que armazena as informações sobre os projetos dos departamentos.
                numero_projeto INTEGER NOT NULL,-- Número do projeto. É a PK desta tabela.
                nome_projeto VARCHAR(15) NOT NULL, -- Nome do projeto. Deve ser único.
                local_projeto VARCHAR(15), -- Localização do projeto.
                numero_departamento INTEGER NOT NULL, -- Número do departamento. É uma FK para a tabela departamento.
                PRIMARY KEY (numero_projeto)
);



create unique index projeto_idx
 on projeto
 ( nome_projeto );


create table localizacoes_departamento ( -- Tabela que armazena as possíveis localizações dos departamentos.
                numero_departamento INTEGER NOT NULL, -- Número do departamento. Faz parte da PK desta tabela e também é uma FK  para a tabela departamento.
                local VARCHAR(15) NOT NULL, -- Localização do departamento. Faz parte da PK desta tabela.
                PRIMARY KEY (numero_departamento, local)
);


create table trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL, -- Tabela para armazenar quais funcionários trabalham em quais projetos.
                numero_projeto INTEGER NOT NULL, -- CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.
                horas NUMERIC(3,1) NOT NULL, -- Horas trabalhadas pelo funcionário neste projeto.
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);


create table dependente (
                cpf_funcionario CHAR(11) NOT NULL, -- Tabela que armazena as informações dos dependentes e dos funcionários.
                nome_dependente VARCHAR(15) NOT NULL, -- CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.
                sexo CHAR(1), -- Sexo do dependente.
                data_nascimento DATE, -- Data de nascimento do dependente.
                parentesco VARCHAR(15), -- Descrição do parentesco do dependente com o funcionário.
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);

alter table dependente -- Garante a restrição de resposta do campo para F ou M.
add constraint check (sexo in ('M','F'));

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



INSERT INTO funcionario
(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES
('Jorge', 'E','Brito', '88866555576','1937-11-10', 'Rua do Horto, 35, São Paulo, SP','M',55.000,NULL,1),
('Fernando','T','Wong','33344555587','1955-08-12','Rua da Lapa, 34, São Paulo, SP', 'M',40.000, '88866555576', 5),
('João','B','Silva','12345678966', '1965-09-01', 'Rua das Flores,751, São Paulo, SP', 'M',30.000, '33344555587',4),
('Jennifer', 'S','Souza', '98765432168','1941-06-20', 'Av. Arthur de Lima, 54, Santo André, SP','F',43.000,'88866555576',4),
('Ronaldo', 'K','Lima', '66688444476','1962-09-15', 'Rua Rebouças, 65, Piracicaba,SP','M',38.000,'33344555587',5),
('Joice', 'A','Leite', '45345345376','1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP','F',25.000,'33344555587',5),
('André', 'V','Pereira', '98798798733','1969-03-29', 'Rua Timbira, 35, São Paulo, SP','M',25.000,'98765432168',4),
('Alice', 'J','Zelaya','99988777767','1968-01-19','Rua Souza Lima, 35, Curitiba, PR', 'F',25.000,'98765432168',4)
;

INSERT INTO departamento
(nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES
('Pesquisa',5,'33344555587','1988-05-22'),
('Administração',4, '98765432168', '1995-01-01'),
('Matriz',1,'88866555576', '1981-06-19');



INSERT INTO localizacoes_departamento
(numero_departamento, local)
VALUES
('1', 'São Paulo'),
('4', 'Mauá'),
('5', 'Santo André'),
('5', 'Itu'),
('5', 'São Paulo');

INSERT INTO projeto
(nome_projeto, numero_projeto, local_projeto, numero_departamento)
values
('ProdutoX',1,'Santo André',5),
('ProdutoY',2,'Itu',5),
('ProdutoZ',3,'São Paulo',5),
('Informatização',10,'Mauá',4),
('Reorganização',20,'São Paulo',1),
('Novosbenefícios',30,'Mauá',4);

INSERT INTO dependente
(cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES
('33344555587', 'Alicia','F','1986-04-05','Filha'),
('33344555587', 'Tiago','M', '1983-10-25','Filho'),
('33344555587', 'Janaína','F','1958-05-03','Esposa'),
('98765432168', 'Antonio','M','1942-02-20','Marido'),
('12345678966', 'Michael','M','1986-04-05','Filho'),
('12345678966', 'Alicia','F','1986-04-05','Filha'),
('12345678966', 'ELizabeth','F','1986-04-05','Esposa');


INSERT INTO trabalha_em
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
('88866555576', 20, '0');





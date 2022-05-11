-- QUESTÃO 01: prepare um relatório que mostre a média salarial dos funcionários de cada departamento.
SELECT numero_departamento as 'Numero_departamento', ROUND(AVG(salario) ,3) as MediaSalarial_departamento
FROM funcionario 
GROUP BY numero_departamento ;

-- QUESTÃO 02: prepare um relatório que mostre a média salarial dos homens e das mulheres.
SELECT ROUND(AVG(salario),3) as MediaSalarial_sexo,
CASE WHEN sexo = 'F' then 'Mulheres'
WHEN sexo = 'M' THEN 'Homens' END AS sexo
FROM funcionario f GROUP BY sexo;

-- QUESTÃO 03: prepare um relatório que liste o nome dos departamentos e, para cada departamento, inclua as seguintes
-- informações de seus funcionários: o nome completo, a data de nascimento, a idade em anos completos e o salário.
SELECT 
nome_departamento as 'Departamento', CONCAT(primeiro_nome,' ' ,nome_meio, ' ' ,ultimo_nome) as 'Nome Completo', data_nascimento as 'Data de Nascimento',YEAR(CURRENT_TIMESTAMP())-YEAR(data_nascimento) 
as 'Idade', salario as 'Salário' 
FROM departamento do INNER JOIN funcionario f
WHERE f.numero_departamento = do.numero_departamento 
ORDER BY nome_departamento;

/*QUESTÃO 04: prepare um relatório que mostre o nome completo dos funcionários, a idade em anos completos, o salário atual e o salário com um reajuste que
obedece ao seguinte critério: se o salário atual do funcionário é inferior a 35.000 o
reajuste deve ser de 20%, e se o salário atual do funcionário for igual ou superior a
35.000 o reajuste deve ser de 15%.*/


/*QUESTÃO 05: prepare um relatório que liste, para cada departamento, o nome
do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento (em ordem crescente) e por salário dos funcionários (em ordem decrescente).*/


/*QUESTÃO 06: prepare um relatório que mostre o nome completo dos funcionários que têm dependentes, o departamento onde eles trabalham e, para cada funcionário, também liste o nome completo dos dependentes, a idade em anos de cada
dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer
como “Masculino” ou “Feminino”).*/

/*QUESTÃO 07: prepare um relatório que mostre, para cada funcionário que NÃO TEM dependente, seu nome completo, departamento e salário.*/

/*QUESTÃO 08: prepare um relatório que mostre, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados
em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário, em cada projeto./*

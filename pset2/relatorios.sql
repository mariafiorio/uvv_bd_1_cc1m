-- QUESTÃO 01: prepare um relatório que mostre a média salarial dos funcionários de cada departamento.

SELECT numero_departamento as 'Numero_departamento', ROUND(AVG(salario) ,3) as MediaSalarial_departamento
FROM funcionario 
GROUP BY numero_departamento ;

-- QUESTÃO 02: prepare um relatório que mostre a média salarial dos homens e das mulheres.

SELECT ROUND(AVG(salario),3) as MediaSalarial_sexo,
CASE WHEN sexo = 'F' then 'Mulheres'
WHEN sexo = 'M' THEN 'Homens' END AS sexo
FROM funcionario f GROUP BY sexo;

/*QUESTÃO 03: prepare um relatório que liste o nome dos departamentos e, para cada departamento, inclua as seguintes
informações de seus funcionários: o nome completo, a data de nascimento, a idade em anos completos e o salário.*/

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
 
 SELECT CONCAT(primeiro_nome,' ' ,nome_meio, ' ' ,ultimo_nome) as 'Nome Completo', YEAR(CURRENT_TIMESTAMP())-YEAR(data_nascimento) as 'Idade', salario as 'Salario',
 if (salario < 35.000, salario * 1.2, salario * 1.15) as 'Salario Reajustado'
 FROM funcionario;

/*QUESTÃO 05: prepare um relatório que liste, para cada departamento, o nome
do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento (em ordem crescente) e por salário dos funcionários (em ordem decrescente).*/

SELECT do.nome_departamento as 'Departamento', CONCAT(g.primeiro_nome,' ' ,nome_meio, ' ' ,ultimo_nome) as 'Gerente', CONCAT(f.primeiro_nome,' ' ,nome_meio, ' ' ,ultimo_nome) as funcionario, salario as 'salario do funcionário'
FROM departamento do INNER JOIN funcionario f, 
(SELECT primeiro_nome, cpf FROM funcionario f INNER JOIN departamento do WHERE f.cpf = do.cpf_gerente) as g
WHERE f.numero_departamento = do.numero_departamento AND g.cpf = do.cpf_gerente ORDER BY do.nome_departamento asc, f.salario desc;

/*QUESTÃO 06: prepare um relatório que mostre o nome completo dos funcionários que têm dependentes, o departamento onde eles trabalham e, para cada funcionário, também liste o nome completo dos dependentes, a idade em anos de cada
dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer
como “Masculino” ou “Feminino”).*/

SELECT CONCAT(f.primeiro_nome,' ' ,nome_meio, ' ' ,ultimo_nome) as 'Nome do funcionário', do.nome_departamento as 'Departamento', dpe.nome_dependente as 'Nome do dependente', YEAR(CURRENT_TIMESTAMP())-YEAR(dpe.data_nascimento) as 'Idade do dependente',
CASE WHEN dpe.sexo = 'F' THEN 'Feminino'
WHEN dpe.sexo = 'M' THEN 'Masculino' END AS 'Sexo do dependente'
FROM funcionario f 
INNER JOIN dependente dpe INNER JOIN departamento do WHERE  dpe.cpf_funcionario = f.cpf AND f.numero_departamento = do.numero_departamento;

/*QUESTÃO 07: prepare um relatório que mostre, para cada funcionário que NÃO TEM dependente, seu nome completo, departamento e salário.*/

SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as 'Nome do Funcionário', do.nome_departamento as'Departamento', salario
FROM funcionario f
INNER JOIN dependente dpe 
INNER JOIN departamento do 
WHERE do.numero_departamento = f.numero_departamento 
AND f.cpf NOT IN
(SELECT dpe.cpf_funcionario FROM dependente dpe);

/*QUESTÃO 08: prepare um relatório que mostre, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados
em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário, em cada projeto.*/

SELECT nome_departamento as 'Departamento', nome_projeto as 'Projeto', CONCAT(f.primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as 'Funcionário', horas as 'Horas trabalhadas' 
FROM funcionario f INNER JOIN departamento do INNER JOIN projeto pro INNER JOIN trabalha_em t
WHERE do.numero_departamento = f.numero_departamento AND
pro.numero_projeto = t.numero_projeto AND
f.cpf = t.cpf_funcionario
ORDER BY nome_projeto;

/*QUESTÃO 09: prepare um relatório que mostre a soma total das horas de cada
projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento, o nome do projeto e a soma total das horas.*/

SELECT nome_projeto as 'Projeto', nome_departamento as 'Departamento', sum(horas) as 'Horas trabalhadas'
FROM departamento do INNER JOIN projeto pro INNER JOIN trabalha_em t
WHERE do.numero_departamento = pro.numero_departamento AND pro.numero_projeto = t.numero_projeto GROUP BY nome_projeto;

/*QUESTÃO 10: prepare um relatório que mostre a média salarial dos funcionários
de cada departamento.*/

SELECT numero_departamento as 'Numero_departamento', ROUND(AVG(salario) ,3) as MediaSalarial_departamento
FROM funcionario 
GROUP BY numero_departamento;

/*QUESTÃO 11: considerando que o valor pago por hora trabalhada em um projeto
é de 50 reais, prepare um relatório que mostre o nome completo do funcionário, o
nome do projeto e o valor total que o funcionário receberá referente às horas trabalhadas naquele projeto.*/

SELECT nome_projeto as 'Projeto', 
CONCAT(f.primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as 'Funcionário', (horas * 50) as 'Valor Total'
FROM funcionario f INNER JOIN projeto pro INNER JOIN  trabalha_em te 
WHERE pro.numero_projeto = te.numero_projeto AND f.cpf = te.cpf_funcionario ;

/*QUESTÃO 12: seu chefe está verificando as horas trabalhadas pelos funcionários
nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum
projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório que liste o nome do departamento, o nome do projeto e o nome dos funcionários
que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada.*/

SELECT nome_departamento as 'Departamento', nome_projeto as 'Projeto', CONCAT(f.primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as 'Funcionário', horas as 'Horas trabalhadas' 
from funcionario f inner join departamento do inner join projeto pro inner join trabalha_em t
where do.numero_departamento = f.numero_departamento and
pro.numero_projeto = t.numero_projeto and f.cpf = t.cpf_funcionario 
and t.horas = 0;

/*QUESTÃO 13: durante o natal deste ano a empresa irá presentear todos os funcionários e todos os dependentes (sim, a empresa vai dar um presente para cada
funcionário e um presente para cada dependente de cada funcionário) e pediu para
que você preparasse um relatório que listasse o nome completo das pessoas a serem
presenteadas (funcionários e dependentes), o sexo e a idade em anos completos
(para poder comprar um presente adequado). Esse relatório deve estar ordenado
pela idade em anos completos, de forma decrescente.*/

SELECT CONCAT(f.primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as 'Pessoas presenteadas', f.sexo as Sexo, YEAR(CURRENT_TIMESTAMP())-YEAR(f.data_nascimento) as 'Idade'
FROM funcionario f
UNION 
SELECT dpe.nome_dependente as 'Pessoas Presenteadas', dpe.sexo as sexo, YEAR(CURRENT_TIMESTAMP())-YEAR(dpe.data_nascimento) as 'Idade' 
FROM dependente dpe
ORDER BY Idade DESC;

/*QUESTÃO 14: prepare um relatório que exiba quantos funcionários cada departamento tem.*/

SELECT COUNT(f.numero_departamento) as  'Qtd de funcionários', nome_departamento as 'Departamento' 
FROM funcionario f INNER JOIN departamento do
WHERE f.numero_departamento = do.numero_departamento 
GROUP BY nome_departamento 
ORDER BY 'Qtd de funcionários' DESC;

/*QUESTÃO 15: como um funcionário pode estar alocado em mais de um projeto,
prepare um relatório que exiba o nome completo do funcionário, o departamento
desse funcionário e o nome dos projetos em que cada funcionário está alocado.
Atenção: se houver algum funcionário que não está alocado em nenhum projeto,
o nome completo e o departamento também devem aparecer no relatório.*/

SELECT  CONCAT(f.primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as 'Nome Completo', nome_departamento as 'Departamento', nome_projeto as 'Projetos'
FROM funcionario f INNER JOIN trabalha_em te INNER JOIN projeto pro INNER JOIN departamento do
WHERE te.cpf_funcionario = f.cpf AND pro.numero_projeto = te.numero_projeto AND do.numero_departamento = f.numero_departamento 
ORDER BY f.cpf DESC; 

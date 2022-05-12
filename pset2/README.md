> Este PSet-2 depende totalmente do PSet-1 e tem como objetivo gerar diversos
relatórios SQL a partir dos dados inseridos no banco de dados criado no
primeiro PSet. Assim, praticando consultas e subconsultas em SQL.



#### QUESTÃO 01: prepare um relatório que mostre a média salarial dos funcionários de cada departamento.
| Departamento | Media Salarial |
| ----------- | ----------- |
| 1 | 55.000 |
| 4 |    30.750 |
|5  | 34.333|


#### QUESTÃO 02: prepare um relatório que mostre a média salarial dos homens e das mulheres.
sexo|MediaSalarial_sexo|
----|------------------|
F   |            31.000|
M   |            37.600|
#### QUESTÃO 03: prepare um relatório que liste o nome dos departamentos e, para cada departamento, inclua as seguintes informações de seus funcionários: o nome completo, a data de nascimento, a idade em anos completos e o salário.
Nome_departamento|nomeCompleto    |data_nascimento|idade|salario|
----------------|----------------|---------------|-----|-------|
Administração    |Alice J Zelaya  |     1968-01-19|   54|  25.00|
Administração    |João B Silva    |     1965-09-01|   57|  30.00|
Administração    |Jennifer S Souza|     1941-06-20|   81|  43.00|
Administração    |André V Pereira |     1969-03-29|   53|  25.00|
Matriz           |Jorge E Brito   |     1937-11-10|   85|  55.00|
Pesquisa         |Ronaldo K Lima  |     1962-09-15|   60|  38.00|
Pesquisa         |Fernando T Wong |     1955-08-12|   67|  40.00|
Pesquisa         |Joice A Leite   |     1972-07-31|   50|  25.00|
#### QUESTÃO 04: prepare um relatório que mostre o nome completo dos funcionários, a idade em anos completos, o salário atual e o salário com um reajuste que obedece ao seguinte critério: se o salário atual do funcionário é inferior a 35.000 o reajuste deve ser de 20%, e se o salário atual do funcionário for igual ou superior a 35.000 o reajuste deve ser de 15%.
Nome Completo   |Idade|Salario|Salario Reajustado|
----------------|-----|-------|------------------|
João B Silva    |   57|  30.00|           36.0000|
Fernando T Wong |   67|  40.00|           46.0000|
Joice A Leite   |   50|  25.00|           30.0000|
Ronaldo K Lima  |   60|  38.00|           43.7000|
Jorge E Brito   |   85|  55.00|           63.2500|
Jennifer S Souza|   81|  43.00|           49.4500|
André V Pereira |   53|  25.00|           30.0000|
Alice J Zelaya  |   54|  25.00|           30.0000|
#### QUESTÃO 05: prepare um relatório que liste, para cada departamento, o nome do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento (em ordem crescente) e por salário dos funcionários (em ordem decrescente).
departamento |gerente           |funcionario     |salario do funcionário|
-------------|------------------|----------------|----------------------|
Administração|Jennifer S Souza  |Jennifer S Souza|                 43.00|
Administração|Jennifer B Silva  |João B Silva    |                 30.00|
Administração|Jennifer J Zelaya |Alice J Zelaya  |                 25.00|
Administração|Jennifer V Pereira|André V Pereira |                 25.00|
Matriz       |Jorge E Brito     |Jorge E Brito   |                 55.00|
Pesquisa     |Fernando T Wong   |Fernando T Wong |                 40.00|
Pesquisa     |Fernando K Lima   |Ronaldo K Lima  |                 38.00|
Pesquisa     |Fernando A Leite  |Joice A Leite   |                 25.00|
#### QUESTÃO 06: prepare um relatório que mostre o nome completo dos funcionários que têm dependentes, o departamento onde eles trabalham e, para cada funcionário, também liste o nome completo dos dependentes, a idade em anos de cada dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer como “Masculino” ou “Feminino”).
Nome do funcionário|Departamento |Nome do dependente|Idade do dependente|Sexo do dependente|
-------------------|-------------|------------------|-------------------|------------------|
João B Silva       |Administração|Alicia            |                 36|Feminino          |
João B Silva       |Administração|ELizabeth         |                 36|Feminino          |
João B Silva       |Administração|Michael           |                 36|Masculino         |
Fernando T Wong    |Pesquisa     |Alicia            |                 36|Feminino          |
Fernando T Wong    |Pesquisa     |Janaína           |                 64|Feminino          |
Fernando T Wong    |Pesquisa     |Tiago             |                 39|Masculino         |
Jennifer S Souza   |Administração|Antonio           |                 80|Masculino         |
#### QUESTÃO 07: prepare um relatório que mostre, para cada funcionário que NÃO TEM dependente, seu nome completo, departamento e salário.
Nome do funcionário|Departamento |Nome do dependente|Idade do dependente|Sexo do dependente|
-------------------|-------------|------------------|-------------------|------------------|
João B Silva       |Administração|Alicia            |                 36|Feminino          |
João B Silva       |Administração|ELizabeth         |                 36|Feminino          |
João B Silva       |Administração|Michael           |                 36|Masculino         |
Fernando T Wong    |Pesquisa     |Alicia            |                 36|Feminino          |
Fernando T Wong    |Pesquisa     |Janaína           |                 64|Feminino          |
Fernando T Wong    |Pesquisa     |Tiago             |                 39|Masculino         |
Jennifer S Souza   |Administração|Antonio           |                 80|Masculino         |
#### QUESTÃO 08: prepare um relatório que mostre, para cada departamento, os projetos desse departamento e o nome completo dos funcionários que estão alocados em cada projeto. Além disso inclua o número de horas trabalhadas por cada funcionário, em cada projeto.
Nome do funcionário|Departamento |Nome do dependente|Idade do dependente|Sexo do dependente|
-------------------|-------------|------------------|-------------------|------------------|
João B Silva       |Administração|Alicia            |                 36|Feminino          |
João B Silva       |Administração|ELizabeth         |                 36|Feminino          |
João B Silva       |Administração|Michael           |                 36|Masculino         |
Fernando T Wong    |Pesquisa     |Alicia            |                 36|Feminino          |
Fernando T Wong    |Pesquisa     |Janaína           |                 64|Feminino          |
Fernando T Wong    |Pesquisa     |Tiago             |                 39|Masculino         |
Jennifer S Souza   |Administração|Antonio           |                 80|Masculino         |
#### QUESTÃO 09: prepare um relatório que mostre a soma total das horas de cada projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento, o nome do projeto e a soma total das horas.
Projeto        |Departamento |Horas trabalhadas|
---------------|-------------|-----------------|
Informatização |Administração|             55.0|
Novosbenefícios|Administração|             55.0|
ProdutoX       |Pesquisa     |             52.5|
ProdutoY       |Pesquisa     |             37.5|
ProdutoZ       |Pesquisa     |             50.0|
Reorganização  |Matriz       |             25.0|
#### QUESTÃO 10: prepare um relatório que mostre a média salarial dos funcionários de cada departamento.
| Departamento | Media Salarial |
| ----------- | ----------- |
| 1 | 55.000 |
| 4 |    30.750 |
|5  | 34.333|
#### QUESTÃO 11: considerando que o valor pago por hora trabalhada em um projeto é de 50 reais, prepare um relatório que mostre o nome completo do funcionário, o nome do projeto e o valor total que o funcionário receberá referente às horas trabalhadas naquele projeto.
Projeto        |Funcionário     |Valor Total|
---------------|----------------|-----------|
ProdutoX       |João B Silva    |     1625.0|
ProdutoY       |João B Silva    |      375.0|
ProdutoY       |Fernando T Wong |      500.0|
ProdutoZ       |Fernando T Wong |      500.0|
Informatização |Fernando T Wong |      500.0|
Reorganização  |Fernando T Wong |      500.0|
ProdutoX       |Joice A Leite   |     1000.0|
ProdutoY       |Joice A Leite   |     1000.0|
ProdutoZ       |Ronaldo K Lima  |     2000.0|
Reorganização  |Jorge E Brito   |        0.0|
Reorganização  |Jennifer S Souza|      750.0|
Novosbenefícios|Jennifer S Souza|     1000.0|
Informatização |André V Pereira |     1750.0|
Novosbenefícios|André V Pereira |      250.0|
Informatização |Alice J Zelaya  |      500.0|
Novosbenefícios|Alice J Zelaya  |     1500.0|
#### QUESTÃO 12: seu chefe está verificando as horas trabalhadas pelos funcionário nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório que liste o nome do departamento, o nome do projeto e o nome dos funcionários que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada.
Departamento|Projeto      |Funcionário  |Horas trabalhadas|
------------|-------------|-------------|-----------------|
Matriz      |Reorganização|Jorge E Brito|              0.0|
#### QUESTÃO 13: durante o natal deste ano a empresa irá presentear todos os funcionários e todos os dependentes (sim, a empresa vai dar um presente para cada funcionário e um presente para cada dependente de cada funcionário) e pediu para que você preparasse um relatório que listasse o nome completo das pessoas a serem presenteadas (funcionários e dependentes), o sexo e a idade em anos completos (para poder comprar um presente adequado). Esse relatório deve estar ordenado pela idade em anos completos, de forma decrescente.
Pessoas presenteadas|Sexo|Idade|
--------------------|----|-----|
Jorge E Brito       |M   |   85|
Jennifer S Souza    |F   |   81|
Antonio             |M   |   80|
Fernando T Wong     |M   |   67|
Janaína             |F   |   64|
Ronaldo K Lima      |M   |   60|
João B Silva        |M   |   57|
Alice J Zelaya      |F   |   54|
André V Pereira     |M   |   53|
Joice A Leite       |F   |   50|
Tiago               |M   |   39|
ELizabeth           |F   |   36|
Michael             |M   |   36|
Alicia              |F   |   36|
#### QUESTÃO 14: prepare um relatório que exiba quantos funcionários cada departamento tem.
| Qtd de funcionários | Departamento |
| ----------- | ----------- |
| 4 | Administração |
| 3 |    Pesquisa |
| 1 | Matriz|

#### QUESTÃO 15: como um funcionário pode estar alocado em mais de um projeto, prepare um relatório que exiba o nome completo do funcionário, o departamento desse funcionário e o nome dos projetos em que cada funcionário está alocado. Atenção: se houver algum funcionário que não está alocado em nenhum projeto, o nome completo e o departamento também devem aparecer no relatório.
Nome Completo   |Departamento |Projetos       |
----------------|-------------|---------------|
Alice J Zelaya  |Administração|Informatização |
Alice J Zelaya  |Administração|Novosbenefícios|
André V Pereira |Administração|Novosbenefícios|
André V Pereira |Administração|Informatização |
Jennifer S Souza|Administração|Reorganização  |
Jennifer S Souza|Administração|Novosbenefícios|
Jorge E Brito   |Matriz       |Reorganização  |
Ronaldo K Lima  |Pesquisa     |ProdutoZ       |
Joice A Leite   |Pesquisa     |ProdutoY       |
Joice A Leite   |Pesquisa     |ProdutoX       |
Fernando T Wong |Pesquisa     |ProdutoY       |
Fernando T Wong |Pesquisa     |Informatização |
Fernando T Wong |Pesquisa     |Reorganização  |
Fernando T Wong |Pesquisa     |ProdutoZ       |
João B Silva    |Administração|ProdutoX       |
João B Silva    |Administração|ProdutoY       |

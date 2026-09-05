USE bd_empresa	

SELECT nom_empregado
	 , 'Data de Nascimento' +
	   CONVERT(varchar(10), dat_nascimento, 103) AS [Data de Nascimento]
FROM empregado

SELECT nom_empregado
	 , dat_nascimento
	 , DAY(dat_nascimento)			AS DIA
	 , MONTH(dat_nascimento)		AS MES
	 , YEAR(dat_nascimento)			AS ANO
	 , 2026 - YEAR(dat_nascimento)  AS IDADE
FROM empregado

USE bd_filmes

SELECT dat_lancamento
	 , DATEADD(YEAR, 10, dat_lancamento) AS  mais_10_anos
	 , DATEADD(DAY, -10, dat_lancamento) AS menos_10_dias
	 , DATEDIFF(YEAR, dat_lancamento, getdate()) AS anos
FROM filmes
WHERE dsc_filme = 'Matrix'


-- 1 - Gerar a lista de aniversariantes da empresa com mês, dia e nome do empregado ordem cronológica
USE bd_empresa

SELECT nom_empregado
	 , CONVERT(VARCHAR(10), dat_nascimento, 103) AS [DATA DE NASCIMENTO]
	 , MONTH(dat_nascimento) AS MES
	 , DAY(dat_nascimento)	 AS DIA
FROM empregado
ORDER BY
	MES, DIA

-- 2 - Listar os departamentos e seus gerentes com tempo de gerência em anos ordenando pelo mais antigo

SELECT a.nom_depto
	 , b.nom_empregado
	 , CONVERT(CHAR(2), DATEDIFF(YEAR, a.dat_inicio_gerente, GETDATE())) + ' Anos' AS tempo_gerencia
FROM departamento a 
JOIN empregado    b
	ON a.num_matricula_gerente = b.num_matricula
ORDER BY
	tempo_gerencia DESC

-- 3 - Listar os funcionários  que terão mais que 65 a partir de 2021

SELECT nom_empregado
	 , dat_nascimento
	 , DATEDIFF(YEAR, dat_nascimento, GETDATE() - 5) AS IDADE
	 , YEAR(GETDATE()) - 5
FROM empregado
WHERE DATEDIFF(YEAR, dat_nascimento, GETDATE() - 5) >= 65

USE bd_empresa

-- 1 - Listar a quantidade de empregados com idade média por supervisor

SELECT sup.nom_empregado	AS SUPERVISOR
	 , COUNT(*)				AS QTD_EMPREGADOS
	 , AVG( DATEDIFF( YEAR, e.dat_nascimento, GETDATE() ) ) AS IDADE_MEDIA
FROM empregado e
JOIN empregado sup
	ON  e.num_matricula_supervisor = sup.num_matricula
GROUP BY
	sup.nom_empregado 


-- 2 - Listar nome dos departamentos com nomes dos empregados e a quantidade de dependentes, se houver.

SELECT d.nom_depto				AS DEPARTAMENTO
	 , e.nom_empregado			AS EMPREGADO
	 , COUNT(f.nom_dependente)	AS DEPENDENTES
FROM departamento    d   
LEFT JOIN empregado		 e
	ON d.cod_depto = e.cod_depto
LEFT JOIN dependente f
	ON f.num_matricula = e.num_matricula
GROUP BY
	 d.nom_depto	
	,e.nom_empregado

-- 3 - Listar somente os locais e a quantidade de projetos onde houver mais de 2 projetos alocados

SELECT nom_local
	 , COUNT(*)		AS QTD_PROJETOS
FROM projeto
GROUP BY
	nom_local
HAVING COUNT(*) > 2

SELECT *
FROM departamento_local
SELECT *
FROM alocacao
SELECT *
FROM projeto



USE bd_empresa
/*
1 - Listar o nome do empregado e o nome do respectivo departamento para todos os empregados que não estão alocados em projetos, resolver com:

a) NOT EXISTS

b) NOT IN

c) LEFT JOIN
*/

-- LEFT JOIN
SELECT a.nom_empregado
	 , b.nom_depto
 FROM empregado			a
 JOIN departamento		b
	ON	a.cod_depto = b.cod_depto
 LEFT JOIN alocacao		c
	ON c.num_matricula = a.num_matricula
 WHERE c.num_matricula IS NULL

-- NOT EXISTS
SELECT a.nom_empregado
	 , b.nom_depto
FROM empregado    a
JOIN departamento b
	ON a.cod_depto = b.cod_depto
WHERE NOT EXISTS (SELECT *
					FROM alocacao c
					WHERE c.num_matricula = a.num_matricula)
 
-- NOT IN
SELECT a.nom_empregado
	 , b.nom_depto
FROM empregado    a
JOIN departamento b
	ON a.cod_depto = b.cod_depto
WHERE a.num_matricula NOT IN (SELECT num_matricula
							  FROM alocacao)


SELECT * FROM departamento
SELECT * FROM PROJETO
select * from alocacao
	
-- 2 - Listar o empregado, o número de horas e o projeto cuja alocação de horas 
-- no projeto é maior do que a média de alocação do referido projeto.

SELECT a.nom_empregado
	 , b.num_horas
	 , c.nom_projeto
	 , media
FROM empregado a
JOIN alocacao  b
	ON a.num_matricula = b.num_matricula
JOIN projeto   c
	ON c.cod_projeto = b.cod_projeto
JOIN( SELECT cod_projeto 
		   , AVG(num_horas) AS media
	  FROM alocacao c
		GROUP BY cod_projeto) al 
	ON c.cod_projeto = al.cod_projeto
WHERE num_horas > media

SQLSalario.sql 
-- Declara a variável final para armazenar o resultado
DECLARE @soma_total DECIMAL(10,2);

-- Subconsulta: soma dos salários dos empregados do depto de Sistemas com > 4h em projetos
DECLARE @soma_sistemas DECIMAL(10,2);
SELECT @soma_sistemas = SUM(e.salario)
FROM empregados e
JOIN projetos p ON e.id = p.empregado_id
JOIN departamentos d ON e.departamento_id = d.id
WHERE d.nome = 'Sistemas' AND p.carga_horaria > 4;

-- Subconsulta: média salarial de empregados do depto de Antropologia com filhos homens
DECLARE @media_antropologia DECIMAL(10,2);
SELECT @media_antropologia = AVG(e.salario)
FROM empregados e
JOIN filhos f ON e.id = f.empregado_id
JOIN departamentos d ON e.departamento_id = d.id
WHERE d.nome = 'Antropologia' AND f.sexo = 'M';

-- Soma final
SET @soma_total = ISNULL(@soma_sistemas, 0) + ISNULL(@media_antropologia, 0);

-- Resultado
SELECT @soma_total AS Resultado_Final;

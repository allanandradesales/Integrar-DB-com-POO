SQLInfoparatodos.sql 
-- Declaração das variáveis
DECLARE @maior_carga DECIMAL(5,2);
DECLARE @menor_carga DECIMAL(5,2);
DECLARE @media_carga DECIMAL(5,2);

-- Maior carga horária no projeto "Informática para todos" para empregados que NÃO são do depto Sistemas
SELECT @maior_carga = MAX(p.carga_horaria)
FROM projetos p
JOIN empregados e ON p.empregado_id = e.id
JOIN departamentos d ON e.departamento_id = d.id
WHERE p.nome = 'Informática para todos' AND d.nome <> 'Sistemas';

-- Menor carga horária no mesmo projeto para empregados do depto Sistemas
SELECT @menor_carga = MIN(p.carga_horaria)
FROM projetos p
JOIN empregados e ON p.empregado_id = e.id
JOIN departamentos d ON e.departamento_id = d.id
WHERE p.nome = 'Informática para todos' AND d.nome = 'Sistemas';

-- Cálculo da média entre os dois valores
SET @media_carga = (@maior_carga + @menor_carga) / 2.0;

-- Resultado final
SELECT 
    @maior_carga AS Maior_Carga_Horaria,
    @menor_carga AS Menor_Carga_Horaria,
    @media_carga AS Media_Entre_As_Cargas;


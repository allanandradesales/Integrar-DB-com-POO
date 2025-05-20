treinando07.sql
CREATE PROCEDURE sp_SomaSalariosPorDepartamento
AS
BEGIN
    SELECT 
        d.id AS CodigoDepartamento,
        d.nome AS NomeDepartamento,
        SUM(e.salario) AS SomaSalarios
    FROM 
        empregados e
    INNER JOIN 
        departamentos d ON e.departamento_id = d.id
    GROUP BY 
        d.id, d.nome
    ORDER BY 
        d.nome;
END;

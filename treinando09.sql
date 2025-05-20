treinando09.sql
CREATE OR REPLACE PROCEDURE info_departamento_salario(
    IN cod_departamento INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    qtd_funcionarios INT;
    soma_salarios NUMERIC(10,2);
    existe BOOLEAN;
BEGIN
    -- Verifica se o departamento existe (1 a 4)
    SELECT EXISTS (
        SELECT 1 FROM departamentos WHERE id = cod_departamento
    ) INTO existe;

    IF NOT existe THEN
        RAISE NOTICE 'Departamento com código % não existe.', cod_departamento;
        RETURN;
    END IF;

    -- Consulta quantidade e soma de salários
    SELECT 
        COUNT(*), 
        COALESCE(SUM(salario), 0)
    INTO 
        qtd_funcionarios, soma_salarios
    FROM empregados
    WHERE departamento_id = cod_departamento;

    -- Exibe os resultados
    RAISE NOTICE 'Departamento: %', cod_departamento;
    RAISE NOTICE 'Quantidade de Funcionários: %', qtd_funcionarios;
    RAISE NOTICE 'Soma dos Salários: R$ %', soma_salarios;
END;
$$;

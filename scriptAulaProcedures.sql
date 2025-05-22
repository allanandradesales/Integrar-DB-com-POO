/* =========================================================
   SCRIPT DE PREPARAÇÃO DE AMBIENTE (PostgreSQL)
   ──────────────────────────────────────────────────────────
   • Cria todas as tabelas
   • Popula cada tabela com **no mínimo 10 registros**
   • NÃO contém as respostas dos exercícios — apenas dados
   ========================================================= */

/* ---------- LIMPEZA (torna o script reexecutável) -------- */
DROP TABLE IF EXISTS dependentes           CASCADE;
DROP TABLE IF EXISTS projetos_empregados   CASCADE;
DROP TABLE IF EXISTS projetos              CASCADE;
DROP TABLE IF EXISTS empregados            CASCADE;
DROP TABLE IF EXISTS departamentos         CASCADE;

/* ---------- 1. TABELAS ----------------------------------- */
CREATE TABLE departamentos (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE empregados (
    matricula       SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    salario         NUMERIC(10,2) NOT NULL,
    id_departamento INT REFERENCES departamentos(id),
    gerente         BOOLEAN DEFAULT FALSE
);

CREATE TABLE dependentes (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(100),
    sexo         CHAR(1) CHECK (sexo IN ('M','F')),
    id_empregado INT REFERENCES empregados(matricula)
);

CREATE TABLE projetos (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE projetos_empregados (
    id_empregado  INT REFERENCES empregados(matricula),
    id_projeto    INT REFERENCES projetos(id),
    carga_horaria INT,
    PRIMARY KEY (id_empregado, id_projeto)
);

/* ---------- 2. DADOS DE EXEMPLO (≥ 10 POR TABELA) -------- */

/* ▸ Departamentos (10) */
INSERT INTO departamentos (nome) VALUES
('Sistemas'), ('Antropologia'), ('Administração'), ('Fisioterapia'),
('Contabilidade'), ('Marketing'), ('Recursos Humanos'), ('Engenharia'),
('Logística'), ('Pesquisa & Desenvolvimento');

/* ▸ Empregados (20) */
INSERT INTO empregados (nome, salario, id_departamento, gerente) VALUES
-- Sistemas (id 1)
('Bruno',    4500, 1, TRUE ),   -- gerente
('Alice',    4000, 1, FALSE),
('Fernanda', 3600, 1, FALSE),
('Mariana',  3700, 1, FALSE),
('Nicolas',  3800, 1, FALSE),
-- Antropologia (id 2)
('Carlos',   4200, 2, FALSE),
('Diana',    3800, 2, FALSE),
('Olivia',   3900, 2, FALSE),
-- Administração (id 3)
('Eduardo',        3500, 3, FALSE),
('Eubiglenivaldo', 3200, 3, FALSE),
-- Fisioterapia (id 4)
('Eubiglenivaldo', 3900, 4, FALSE),
('Pablo',          3400, 4, FALSE),
-- Contabilidade (id 5)
('Gabriel',  4100, 5, TRUE ),
-- Marketing (id 6)
('Helena',   3600, 6, TRUE ),
('Renata',   3550, 6, FALSE),
-- Recursos Humanos (id 7)
('Igor',     3700, 7, TRUE ),
-- Engenharia (id 8)
('Juliana',  4300, 8, TRUE ),
-- Logística (id 9)
('Kelvin',   3450, 9, TRUE ),
-- P&D (id 10)
('Larissa',  4600,10, TRUE ),
('Tiago',    4000, 1, FALSE);  -- extra no depto Sistemas

/* ▸ Dependentes (12) */
INSERT INTO dependentes (nome, sexo, id_empregado) VALUES
('Lucas',  'M', (SELECT matricula FROM empregados WHERE nome='Bruno'   AND id_departamento=1)),
('Sofia',  'F', (SELECT matricula FROM empregados WHERE nome='Bruno'   AND id_departamento=1)),
('Pedro',  'M', (SELECT matricula FROM empregados WHERE nome='Carlos'  AND id_departamento=2)),
('Joana',  'F', (SELECT matricula FROM empregados WHERE nome='Diana'   AND id_departamento=2)),
('Leo',    'M', (SELECT matricula FROM empregados WHERE nome='Eubiglenivaldo' AND id_departamento=4)),
('Lara',   'F', (SELECT matricula FROM empregados WHERE nome='Eubiglenivaldo' AND id_departamento=4)),
('Gustavo','M', (SELECT matricula FROM empregados WHERE nome='Fernanda'AND id_departamento=1)),
('Bia',    'F', (SELECT matricula FROM empregados WHERE nome='Alice'   AND id_departamento=1)),
('Diego',  'M', (SELECT matricula FROM empregados WHERE nome='Eduardo' AND id_departamento=3)),
('Clara',  'F', (SELECT matricula FROM empregados WHERE nome='Helena'  AND id_departamento=6)),
('Miguel', 'M', (SELECT matricula FROM empregados WHERE nome='Gabriel' AND id_departamento=5)),
('Ana',    'F', (SELECT matricula FROM empregados WHERE nome='Igor'    AND id_departamento=7));

/* ▸ Projetos (10) */
INSERT INTO projetos (nome) VALUES
('Informática para Todos'), ('Projeto Memória'), ('Gestão de RH'),
('Sistema Solar'), ('Green Planet'), ('Segurança Digital'),
('Saúde em Foco'), ('Smart City'), ('Rede Solidária'), ('Educação 4.0');

/* ▸ Ligações empregado↔projeto (25) */
-- Projeto 1 – Informática para Todos
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Bruno'   AND id_departamento=1), 1, 8),
((SELECT matricula FROM empregados WHERE nome='Alice'   AND id_departamento=1), 1, 6),
((SELECT matricula FROM empregados WHERE nome='Fernanda'AND id_departamento=1), 1,10),
((SELECT matricula FROM empregados WHERE nome='Carlos'  AND id_departamento=2), 1, 7),
((SELECT matricula FROM empregados WHERE nome='Olivia'  AND id_departamento=2), 1,12),
((SELECT matricula FROM empregados WHERE nome='Pablo'   AND id_departamento=4), 1, 9);

-- Projeto 2 – Projeto Memória
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Diana'   AND id_departamento=2), 2, 5),
((SELECT matricula FROM empregados WHERE nome='Nicolas' AND id_departamento=1), 2, 4);

-- Projeto 3 – Gestão de RH
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Igor'    AND id_departamento=7), 3, 8),
((SELECT matricula FROM empregados WHERE nome='Eduardo' AND id_departamento=3), 3, 4);

-- Projeto 4 – Sistema Solar
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Juliana' AND id_departamento=8), 4, 6),
((SELECT matricula FROM empregados WHERE nome='Larissa' AND id_departamento=10),4, 7),
((SELECT matricula FROM empregados WHERE nome='Tiago'   AND id_departamento=1), 4, 5);

-- Projeto 5 – Green Planet
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Kelvin'  AND id_departamento=9), 5, 3),
((SELECT matricula FROM empregados WHERE nome='Helena'  AND id_departamento=6), 5, 4);

-- Projeto 6 – Segurança Digital
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Bruno'   AND id_departamento=1), 6, 9),
((SELECT matricula FROM empregados WHERE nome='Mariana' AND id_departamento=1), 6, 6);

-- Projeto 7 – Saúde em Foco
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Eubiglenivaldo' AND id_departamento=4), 7, 5),
((SELECT matricula FROM empregados WHERE nome='Eubiglenivaldo' AND id_departamento=3), 7, 4);

-- Projeto 8 – Smart City
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Gabriel' AND id_departamento=5), 8, 7),
((SELECT matricula FROM empregados WHERE nome='Renata'  AND id_departamento=6), 8, 6);

-- Projeto 9 – Rede Solidária
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Fernanda'AND id_departamento=1), 9, 5);

-- Projeto 10 – Educação 4.0
INSERT INTO projetos_empregados VALUES
((SELECT matricula FROM empregados WHERE nome='Alice'   AND id_departamento=1),10, 4),
((SELECT matricula FROM empregados WHERE nome='Diana'   AND id_departamento=2),10, 3);

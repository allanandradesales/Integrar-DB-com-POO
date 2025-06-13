-- 1. Criar banco de dados
DROP DATABASE IF EXISTS checkinone;
CREATE DATABASE checkinone;
USE checkinone;

-- 2. Tabelas principais
CREATE TABLE Evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nome_evento VARCHAR(100) NOT NULL,
    data_evento DATE NOT NULL,
    local VARCHAR(100) NOT NULL
);

CREATE TABLE Participante (
    id_participante INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_nascimento DATE
);

CREATE TABLE Inscricao (
    id_inscricao INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT,
    id_participante INT,
    numero_inscricao VARCHAR(20) NOT NULL,
    data_inscricao DATE NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento),
    FOREIGN KEY (id_participante) REFERENCES Participante(id_participante)
);

-- 3. Inserir dados
INSERT INTO Evento (nome_evento, data_evento, local) VALUES
('Tech Summit 2025', '2025-08-10', 'São Paulo'),
('Data Day', '2025-09-15', 'Recife'),
('IA para Todos', '2025-07-05', 'João Pessoa'),
('Cloud Week', '2025-10-20', 'Belo Horizonte'),
('Cidades Inteligentes', '2025-11-11', 'Curitiba');

INSERT INTO Participante (nome, email, data_nascimento) VALUES
('Ana Souza', 'ana@gmail.com', '1990-05-10'),
('Carlos Lima', 'carlos@gmail.com', '1985-03-20'),
('Fernanda Rocha', 'fernanda@gmail.com', '1995-08-17'),
('João Mendes', 'joao@gmail.com', '2000-01-03'),
('Luiza Teixeira', 'luiza@gmail.com', '1992-11-25');

INSERT INTO Inscricao (id_evento, id_participante, numero_inscricao, data_inscricao) VALUES
(1, 1, 'EVT001', '2025-08-01'),
(2, 2, 'EVT002', '2025-09-01'),
(3, 3, 'EVT003', '2025-07-01'),
(4, 4, 'EVT004', '2025-10-01'),
(5, 5, 'EVT005', '2025-11-01');

-- 4. Trigger: impedir inscrições duplicadas para o mesmo evento
DELIMITER //
CREATE TRIGGER trg_prevent_duplicate_inscricao
BEFORE INSERT ON Inscricao
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Inscricao
        WHERE id_evento = NEW.id_evento AND id_participante = NEW.id_participante
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Participante já inscrito neste evento.';
    END IF;
END;
//
DELIMITER ;

-- 5. Procedure: listar inscrições de um evento
DELIMITER //
CREATE PROCEDURE sp_listar_inscricoes(IN p_evento_id INT)
BEGIN
    SELECT i.numero_inscricao, p.nome, p.email
    FROM Inscricao i
    JOIN Participante p ON i.id_participante = p.id_participante
    WHERE i.id_evento = p_evento_id;
END;
//
DELIMITER ;

-- 6. Function: calcular idade
DELIMITER //
CREATE FUNCTION fn_calcula_idade(data_nasc DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, data_nasc, CURDATE());
END;
//
DELIMITER ;

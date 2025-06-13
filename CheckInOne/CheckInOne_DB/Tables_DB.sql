-- 1. Tabela de usuários com perfis
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    perfil ENUM('admin', 'organizador', 'participante') NOT NULL DEFAULT 'participante'
);

-- 2. Tabela de presença
CREATE TABLE Presenca (
    id_presenca INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_participante INT NOT NULL,
    data_checkin DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento),
    FOREIGN KEY (id_participante) REFERENCES Participante(id_participante),
    UNIQUE (id_evento, id_participante) -- garante que não marque presença duplicada
);

-- 3. Tabela de certificados
CREATE TABLE Certificado (
    id_certificado INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_participante INT NOT NULL,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('emitido', 'pendente') DEFAULT 'pendente',
    FOREIGN KEY (id_evento) REFERENCES Evento(id_evento),
    FOREIGN KEY (id_participante) REFERENCES Participante(id_participante),
    UNIQUE (id_evento, id_participante)
);

-- 4. Trigger para impedir presença duplicada (extra segurança)
DELIMITER //
CREATE TRIGGER trg_checkin_unico
BEFORE INSERT ON Presenca
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Presenca
        WHERE id_evento = NEW.id_evento AND id_participante = NEW.id_participante
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Presença já registrada para esse participante.';
    END IF;
END;
//
DELIMITER ;

-- 5. Procedure para registrar presença
DELIMITER //
CREATE PROCEDURE sp_registrar_presenca(IN p_evento INT, IN p_participante INT)
BEGIN
    INSERT INTO Presenca (id_evento, id_participante)
    VALUES (p_evento, p_participante);
END;
//
DELIMITER ;

-- 6. Procedure para emitir certificado (marca como emitido)
DELIMITER //
CREATE PROCEDURE sp_emitir_certificado(IN p_evento INT, IN p_participante INT)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Presenca WHERE id_evento = p_evento AND id_participante = p_participante
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Certificado não pode ser emitido sem presença registrada.';
    ELSE
        INSERT INTO Certificado (id_evento, id_participante, status)
        VALUES (p_evento, p_participante, 'emitido')
        ON DUPLICATE KEY UPDATE status = 'emitido', data_emissao = CURRENT_TIMESTAMP;
    END IF;
END;
//
DELIMITER ;

-- 7. Procedure para listar certificados emitidos
DELIMITER //
CREATE PROCEDURE sp_listar_certificados(IN p_evento INT)
BEGIN
    SELECT p.nome, p.email, c.status, c.data_emissao
    FROM Certificado c
    JOIN Participante p ON c.id_participante = p.id_participante
    WHERE c.id_evento = p_evento;
END;
//
DELIMITER ;

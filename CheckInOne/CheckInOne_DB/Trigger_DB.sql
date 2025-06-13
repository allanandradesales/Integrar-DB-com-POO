DELIMITER //
CREATE TRIGGER trg_prevent_inscricao_duplicada BEFORE INSERT ON Inscricao FOR EACH ROW BEGIN IF EXISTS (SELECT 1 FROM Inscricao WHERE id_evento = NEW.id_evento AND id_participante = NEW.id_participante) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Participante já inscrito neste evento.'; END IF; END;//
CREATE TRIGGER trg_set_data_emissao BEFORE INSERT ON Certificado FOR EACH ROW BEGIN IF NEW.data_emissao IS NULL THEN SET NEW.data_emissao = NOW(); END IF; END;//
DELIMITER ;
DELIMITER //

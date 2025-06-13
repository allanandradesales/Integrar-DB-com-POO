DELIMITER //
CREATE TRIGGER trg_gerar_numero_inscricao
 AFTER INSERT ON Inscricao 
 FOR EACH ROW 
 BEGIN 
 DECLARE novo_codigo VARCHAR(20); 
 SET novo_codigo = CONCAT('EVT', LPAD(NEW.id_evento, 3, '0'), '-', LPAD(NEW.id_inscricao, 4, '0')); 
 UPDATE Inscricao SET numero_inscricao = novo_codigo
 WHERE id_inscricao = NEW.id_inscricao; 
 END;//

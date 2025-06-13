DELIMITER //
CREATE TRIGGER trg_bloqueia_exclusao_palestrante 
BEFORE DELETE ON Palestrante
FOR EACH ROW 
BEGIN 
IF EXISTS (SELECT 1 FROM Palestra_Palestrante 
WHERE id_palestrante = OLD.id_palestrante) THEN 
SIGNAL SQLSTATE '45000' 
SET MESSAGE_TEXT = 'Palestrante vinculado a palestra não pode ser excluído.';
 END IF; 
 END;//

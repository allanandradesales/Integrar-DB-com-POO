DELIMITER //
CREATE PROCEDURE emitir_certificados_evento(IN p_evento_id INT)
 BEGIN 
 DECLARE done INT DEFAULT FALSE;
 DECLARE var_inscricao_id INT;
 DECLARE cur CURSOR FOR 
 SELECT id_inscricao FROM Inscricao 
 WHERE id_evento = p_evento_id; 
 DECLARE CONTINUE HANDLER FOR NOT FOUND 
 SET done = TRUE;
 OPEN cur; read_loop: LOOP FETCH cur INTO var_inscricao_id; 
 IF done THEN 
 LEAVE read_loop; 
 END IF; 
 INSERT INTO Certificado (id_inscricao, codigo_verificacao, data_emissao, url_pdf) VALUES (var_inscricao_id, CONCAT('CERT-', var_inscricao_id), NOW(), CONCAT('https://checkinone.com/cert/', var_inscricao_id));
 END LOOP; 
 CLOSE cur;
 END;//

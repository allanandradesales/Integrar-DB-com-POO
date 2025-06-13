DELIMITER //
CREATE FUNCTION gerar_numero_inscricao(evento_id INT, inscricao_id INT) 
RETURNS VARCHAR(20) DETERMINISTIC 
BEGIN
 RETURN CONCAT('EVT', LPAD(evento_id, 3, '0'), '-', LPAD(inscricao_id, 4, '0')); 
 END;//


DELIMITER //

CREATE PROCEDURE sp_listar_participantes_evento(IN p_evento_id INT) 
BEGIN
 SELECT p.nome AS participante, e.nome AS evento, i.numero_inscricao 
FROM Inscricao i JOIN Participante p ON i.id_participante = p.id_participante JOIN Evento e ON i.id_evento = e.id_evento 
WHERE i.id_evento = p_evento_id;
 END //
DELIMITER ;
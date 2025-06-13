-- Inserir dados Palestrante para demonstração 

INSERT INTO Palestrante (nome, email, mini_curriculo) VALUES ('Prof. João Silva', 'joao@email.com', 'Especialista em IA');
INSERT INTO Palestrante (nome, email, mini_curriculo) VALUES ('Dra. Marina Lima', 'marina@email.com', 'Consultora em Educação');
INSERT INTO Palestrante (nome, email, mini_curriculo) VALUES ('Eng. Rafael Dias', 'rafael@email.com', 'Engenheiro de Software');
INSERT INTO Palestrante (nome, email, mini_curriculo) VALUES ('Profa. Cláudia Mendes', 'claudia@email.com', 'Pesquisadora em Saúde Pública');
INSERT INTO Palestrante (nome, email, mini_curriculo) VALUES ('Dr. Tiago Ramos', 'tiago@email.com', 'Especialista em Cidades Inteligentes');

-- Inserir dados de Palestra para demonstração 

INSERT INTO Palestra (id_evento, titulo, horario, local) VALUES (1, 'IA no Futuro', '10:00:00', 'Auditório A');
INSERT INTO Palestra (id_evento, titulo, horario, local) VALUES (2, 'Educação Digital', '14:00:00', 'Sala 101');
INSERT INTO Palestra (id_evento, titulo, horario, local) VALUES (3, 'Saúde e Dados', '09:00:00', 'Sala 202');
INSERT INTO Palestra (id_evento, titulo, horario, local) VALUES (4, 'Tecnologia Agro', '11:00:00', 'Sala 303');
INSERT INTO Palestra (id_evento, titulo, horario, local) VALUES (5, 'Cidades Inteligentes', '15:00:00', 'Auditório Central');

-- Inserir dados de Certificado para demonstração 

INSERT INTO Certificado (id_inscricao, codigo_verificacao, url_pdf) VALUES (1, 'CERT001', 'https://checkinone.com/cert/1');
INSERT INTO Certificado (id_inscricao, codigo_verificacao, url_pdf) VALUES (2, 'CERT002', 'https://checkinone.com/cert/2');
INSERT INTO Certificado (id_inscricao, codigo_verificacao, url_pdf) VALUES (3, 'CERT003', 'https://checkinone.com/cert/3');
INSERT INTO Certificado (id_inscricao, codigo_verificacao, url_pdf) VALUES (4, 'CERT004', 'https://checkinone.com/cert/4');
INSERT INTO Certificado (id_inscricao, codigo_verificacao, url_pdf) VALUES (5, 'CERT005', 'https://checkinone.com/cert/5');

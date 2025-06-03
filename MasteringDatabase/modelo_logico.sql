/*
			   SAFE-ALERT 
	- PLATAFORMA DE COMUNICACAO PARA EVENTOS EXTREMOS
	
    João Gabriel Boaventura Marques e Silva | RM554874 | 2TDSB-2025
    Léo Motta Lima | RM557851 | 2TDSB-2025
    Lucas Leal das Chagas | RM551124 | 2TDSB-2025
*/

DROP TABLE usuarios CASCADE CONSTRAINTS;
DROP TABLE localidades CASCADE CONSTRAINTS;
DROP TABLE eventos CASCADE CONSTRAINTS;
DROP TABLE postagens CASCADE CONSTRAINTS;
DROP TABLE ocorrencias CASCADE CONSTRAINTS;

CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    senha VARCHAR2(255) NOT NULL,
    endereco VARCHAR2(300) NOT NULL,
    tipo_usuario VARCHAR2(10) DEFAULT 'user' CHECK (tipo_usuario IN ('admin', 'user')),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE localidades (
    id INT PRIMARY KEY,
    bairro VARCHAR2(100) NOT NULL,
    zona VARCHAR2(50)
);


CREATE TABLE eventos (
    id INT PRIMARY KEY,
    tipo VARCHAR2(50) NOT NULL,
    descricao VARCHAR2(100)
);

CREATE TABLE postagens (
    id INT PRIMARY KEY,
    usuario_id INT NOT NULL,
    evento_id INT NOT NULL,
    localidade_id INT NOT NULL,
    titulo VARCHAR2(100),
    descricao VARCHAR2(280),
    imagem_url VARCHAR2(255),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (evento_id) REFERENCES eventos(id),
    FOREIGN KEY (localidade_id) REFERENCES localidades(id)
);

CREATE TABLE ocorrencias (
    id INT PRIMARY KEY,
    postagem_id INT NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('Antiga', 'Recente', 'Atual')),
    data_ocorrencia TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (postagem_id) REFERENCES postagens(id)
);

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (1, 'Alice Souza', 'alice.souza@example.com', 'senha123', 'Rua das Flores, 123 - Jardim das Flores, Zona Sul', 'user', TO_TIMESTAMP('2025-05-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (2, 'Bruno Lima', 'bruno.lima@example.com', 'bruno456', 'Av. Paulista, 456 - Bela Vista, Centro', 'user', TO_TIMESTAMP('2025-05-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (3, 'Carla Mendes', 'carla.mendes@example.com', 'carla789', 'Rua das Acácias, 789 - Vila Mariana, Zona Sul', 'user', TO_TIMESTAMP('2025-05-03 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (4, 'Diego Ferreira', 'diego.ferreira@example.com', 'diego321', 'Rua Central, 321 - Sé, Centro', 'user', TO_TIMESTAMP('2025-05-04 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (5, 'Eduarda Silva', 'eduarda.silva@example.com', 'eduarda654', 'Av. Brasil, 654 - Campos Elíseos, Centro', 'user', TO_TIMESTAMP('2025-05-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (6, 'Felipe Rocha', 'felipe.rocha@example.com', 'felipe987', 'Rua Nova, 987 - Liberdade, Centro', 'user', TO_TIMESTAMP('2025-05-06 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (7, 'Gabriela Costa', 'gabriela.costa@example.com', 'gabi123', 'Av. Rio Branco, 123 - Santa Cecília, Centro', 'user', TO_TIMESTAMP('2025-05-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (8, 'Henrique Souza', 'henrique.souza@example.com', 'henrique456', 'Rua São João, 456 - Campos Elíseos, Centro', 'user', TO_TIMESTAMP('2025-05-08 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (9, 'Isabela Martins', 'isabela.martins@example.com', 'isabela789', 'Av. Independência, 789 - Ipiranga, Zona Sul', 'user', TO_TIMESTAMP('2025-05-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO usuarios (id, nome, email, senha, endereco, tipo_usuario, data_cadastro) 
VALUES (10, 'João Pedro', 'joao.pedro@example.com', 'joao321', 'Rua do Comércio, 321 - Centro Histórico, Centro', 'user', TO_TIMESTAMP('2025-05-10 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO localidades (id, bairro, zona) VALUES (1, 'Centro', 'Centro');
INSERT INTO localidades (id, bairro, zona) VALUES (2, 'República', 'Centro');
INSERT INTO localidades (id, bairro, zona) VALUES (3, 'Vila Maria', 'Zona Norte');
INSERT INTO localidades (id, bairro, zona) VALUES (4, 'Parelheiros', 'Zona Sul');
INSERT INTO localidades (id, bairro, zona) VALUES (5, 'Casa Verde', 'Zona Norte');
INSERT INTO localidades (id, bairro, zona) VALUES (6, 'Tatuapé', 'Zona Leste');
INSERT INTO localidades (id, bairro, zona) VALUES (7, 'Butantã', 'Zona Oeste');
INSERT INTO localidades (id, bairro, zona) VALUES (8, 'Ipiranga', 'Zona Leste');
INSERT INTO localidades (id, bairro, zona) VALUES (9, 'Mooca', 'Zona Leste');
INSERT INTO localidades (id, bairro, zona) VALUES (10, 'Lapa', 'Zona Oeste');



INSERT INTO eventos (id, tipo, descricao) VALUES (1, 'Enchente', 'Enchente causou alagamento em diversas ruas do centro.');
INSERT INTO eventos (id, tipo, descricao) VALUES (2, 'Enchente', 'Transbordamento de rio provocou evacuação de moradores.');
INSERT INTO eventos (id, tipo, descricao) VALUES (3, 'Calor Intenso', 'Onda de calor com temperaturas acima de 40°C.');
INSERT INTO eventos (id, tipo, descricao) VALUES (4, 'Calor Intenso', 'Alerta de saúde pública devido ao calor extremo.');
INSERT INTO eventos (id, tipo, descricao) VALUES (5, 'Deslizamento', 'Deslizamento de terra interditou a estrada principal.');
INSERT INTO eventos (id, tipo, descricao) VALUES (6, 'Deslizamento', 'Deslizamento atingiu algumas residências na encosta.');
INSERT INTO eventos (id, tipo, descricao) VALUES (7, 'Fiscalização', 'Fiscalização de áreas de risco após fortes chuvas.');
INSERT INTO eventos (id, tipo, descricao) VALUES (8, 'Resgate', 'Resgate de famílias ilhadas por enchente.');
INSERT INTO eventos (id, tipo, descricao) VALUES (9, 'Manutenção', 'Manutenção de barreiras de contenção em área de risco.');
INSERT INTO eventos (id, tipo, descricao) VALUES (10, 'Patrulhamento', 'Patrulhamento preventivo em áreas suscetíveis a enchentes.');


INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (1, 1, 1, 1, 'Alagamento no Centro', 'As ruas estão completamente alagadas após a enchente.', 'https://imagensite.com/alagamento1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (2, 2, 2, 2, 'Onda de Calor', 'Temperaturas estão muito altas, recomendação de hidratação.', 'https://imagensite.com/calor1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (3, 3, 3, 3, 'Deslizamento na encosta', 'Deslizamento bloqueou estrada e atingiu casas.', 'https://imagensite.com/deslizamento1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (4, 4, 4, 4, 'Fiscalização nas áreas de risco', 'Equipes monitoram áreas afetadas pela chuva.', 'https://imagensite.com/fiscalizacao1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (5, 5, 5, 5, 'Resgate em enchente', 'Bombeiros resgataram moradores ilhados.', 'https://imagensite.com/resgate1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (6, 6, 6, 6, 'Atropelamento na faixa', 'Pedestre foi atropelado na faixa de pedestres.', 'https://imagensite.com/atropelamento1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (7, 7, 7, 7, 'Colisão múltipla', 'Engavetamento com três veículos.', 'https://imagensite.com/colisao1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (8, 8, 8, 8, 'Manutenção preventiva', 'Viatura passou por manutenção preventiva.', 'https://imagensite.com/manutencao1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (9, 9, 9, 9, 'Patrulhamento em bairro', 'Equipe realiza patrulhamento em área residencial.', 'https://imagensite.com/patrulhamento1.jpg');

INSERT INTO postagens (id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url) 
VALUES (10, 10, 10, 10, 'Blitz na entrada da cidade', 'Operação de fiscalização com abordagem a veículos.', 'https://imagensite.com/blitz1.jpg');

INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (1, 1, 'Antiga', TO_DATE('2025-05-29', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (2, 2, 'Recente', TO_DATE('2025-05-28', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (3, 3, 'Atual', TO_DATE('2025-05-27', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (4, 4, 'Antiga', TO_DATE('2025-05-26', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (5, 5, 'Recente', TO_DATE('2025-05-25', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (6, 6, 'Atual', TO_DATE('2025-05-24', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (7, 7, 'Antiga', TO_DATE('2025-05-23', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (8, 8, 'Recente', TO_DATE('2025-05-22', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (9, 9, 'Atual', TO_DATE('2025-05-21', 'YYYY-MM-DD'));
INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia) VALUES (10, 10, 'Antiga', TO_DATE('2025-05-20', 'YYYY-MM-DD'));

CREATE OR REPLACE FUNCTION media_ocorrencias_por_zona (p_zona IN localidades.zona%TYPE) 
RETURN NUMBER IS
    v_total_ocorrencias NUMBER := 0;
    v_total_postagens   NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_total_ocorrencias FROM ocorrencias o JOIN postagens p ON o.postagem_id = p.id
    JOIN localidades l ON p.localidade_id = l.id WHERE  l.zona = p_zona;

    SELECT COUNT(*) INTO v_total_postagens FROM postagens p JOIN   localidades l ON p.localidade_id = l.id
    WHERE  l.zona = p_zona;

    IF v_total_postagens = 0 THEN
        RETURN 0;
    ELSE
        RETURN v_total_ocorrencias / v_total_postagens;
    END IF;
END;
/
SELECT media_ocorrencias_por_zona('Zona Norte') AS risco_medio FROM dual;

CREATE OR REPLACE FUNCTION retornar_total_ocorrencias_por_bairro (
    p_bairro IN localidades.bairro%TYPE
) RETURN NUMBER IS
    v_total NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO   v_total
    FROM   ocorrencias o
    JOIN   postagens p   ON o.postagem_id = p.id
    JOIN   localidades l ON p.localidade_id = l.id
    WHERE  l.bairro = p_bairro;

    RETURN v_total;
END;
/
SELECT retornar_total_ocorrencias_por_bairro('Centro') AS total_ocorrencias FROM dual;


set serveroutput on;
set verify off;

DECLARE
    v_msg VARCHAR2(100);

    CURSOR cur_ocorrencias IS SELECT l.zona, COUNT(o.id) AS total_ocorrencias FROM localidades l
        JOIN postagens p ON p.localidade_id = l.id JOIN ocorrencias o ON o.postagem_id = p.id
        GROUP BY l.zona HAVING COUNT(o.id) > 0 ORDER BY total_ocorrencias DESC;
BEGIN
    FOR rec IN cur_ocorrencias LOOP
        IF rec.total_ocorrencias > 5 THEN
            v_msg := rec.zona || ' tem ALTO número de ocorrências: ' || rec.total_ocorrencias;
        ELSE
            v_msg := rec.zona || ' tem número MODERADO de ocorrências: ' || rec.total_ocorrencias;
        END IF;

        DBMS_OUTPUT.PUT_LINE(v_msg);
    END LOOP;
END;
/

DECLARE
    TYPE t_zonas IS TABLE OF localidades.zona%TYPE;
    v_zonas t_zonas := t_zonas('Centro', 'Zona Norte', 'Zona Sul', 'Zona Leste', 'Zona Oeste');
    v_total NUMBER;
BEGIN
    FOR i IN 1 .. v_zonas.COUNT LOOP
        SELECT COUNT(*) INTO v_total FROM ocorrencias o JOIN postagens p ON o.postagem_id = p.id 
        JOIN localidades l ON p.localidade_id = l.id WHERE l.zona = v_zonas(i);

        IF v_total = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Zona "' || v_zonas(i) || '" não possui ocorrências.');
        ELSIF v_total < 3 THEN
            DBMS_OUTPUT.PUT_LINE('Zona "' || v_zonas(i) || '" tem poucas ocorrências: ' || v_total);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Zona "' || v_zonas(i) || '" tem várias ocorrências: ' || v_total);
        END IF;
    END LOOP;
END;
/

DECLARE
    v_nome   usuarios.nome%TYPE;
    v_email  usuarios.email%TYPE;

    CURSOR c_usuarios IS SELECT nome, email FROM usuarios;
BEGIN
    OPEN c_usuarios;

    LOOP
        FETCH c_usuarios INTO v_nome, v_email;
        EXIT WHEN c_usuarios%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || ' | Email: ' || v_email);
    END LOOP;

    CLOSE c_usuarios;
END;
/

DECLARE
    v_nome   usuarios.nome%TYPE;
    v_email  usuarios.email%TYPE;
    v_count  NUMBER := 0;
    CURSOR c_usuarios IS SELECT nome, email FROM   usuarios;
BEGIN
    OPEN c_usuarios;
    LOOP
        FETCH c_usuarios INTO v_nome, v_email;
        EXIT WHEN c_usuarios%NOTFOUND;
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Usuário ' || v_count || ': ' || v_nome || ' | Email: ' || v_email);
    END LOOP;
    CLOSE c_usuarios;
    DBMS_OUTPUT.PUT_LINE('Total de usuários processados: ' || v_count);
END;
/


SELECT u.id, u.nome, COUNT(p.id) AS total_postagens FROM usuarios u
LEFT JOIN postagens p ON u.id = p.usuario_id GROUP BY u.id, u.nome 
ORDER BY total_postagens DESC;

SELECT l.bairro, l.zona, COUNT(p.id) AS total_postagens FROM localidades l
JOIN postagens p ON l.id = p.localidade_id GROUP BY l.bairro, l.zona
HAVING COUNT(p.id) > 0 ORDER BY total_postagens DESC;

SELECT e.tipo, o.status, COUNT(o.id) AS total_ocorrencias FROM eventos e
JOIN postagens p ON e.id = p.evento_id JOIN ocorrencias o ON p.id = o.postagem_id
GROUP BY e.tipo, o.status ORDER BY e.tipo, o.status;

SELECT AVG(qtd_postagens) AS media_postagens_por_usuario FROM ( SELECT u.id, COUNT(p.id) AS qtd_postagens
FROM usuarios u LEFT JOIN postagens p ON u.id = p.usuario_id WHERE u.tipo_usuario = 'user' GROUP BY u.id) sub;

SELECT DISTINCT u.nome, p.titulo, l.bairro FROM usuarios u JOIN postagens p ON u.id = p.usuario_id
    JOIN localidades l ON p.localidade_id = l.id
WHERE l.bairro IN ( SELECT DISTINCT l2.bairro FROM localidades l2 JOIN postagens p2 ON l2.id = p2.localidade_id
    JOIN ocorrencias o ON p2.id = o.postagem_id WHERE o.status = 'Recente')
ORDER BY u.nome;



/*
						SAFE-ALERT 
	- PLATAFORMA DE MONITORAMENTO E COMUNICACAO PARA EVENTOS EXTREMOS
						
    Jo�o Gabriel Boaventura Marques e Silva | RM554874 | 2TDSB-2025
    L�o Motta Lima | RM557851 | 2TDSB-2025
    Lucas Leal das Chagas | RM551124 | 2TDSB-2025
*/

DROP TABLE usuarios CASCADE CONSTRAINTS;
DROP TABLE localidades CASCADE CONSTRAINTS;
DROP TABLE eventos CASCADE CONSTRAINTS;
DROP TABLE postagens CASCADE CONSTRAINTS;
DROP TABLE ocorrencias CASCADE CONSTRAINTS;

---------------------------------------------
--2 Cria��o das Tabelas com Restri��es
-- Usuarios
CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    senha VARCHAR2(255) NOT NULL,
    endereco VARCHAR2(300) NOT NULL,
    tipo_usuario VARCHAR2(10) DEFAULT 'user' CHECK (tipo_usuario IN ('admin', 'user')),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Localidades (ex: bairros ou zonas de SP)
CREATE TABLE localidades (
    id INT PRIMARY KEY,
    bairro VARCHAR2(100) NOT NULL,
    zona VARCHAR2(50)
);
 
-- Tipos de eventos
CREATE TABLE eventos (
    id INT PRIMARY KEY,
    tipo VARCHAR2(50) NOT NULL,
    descricao VARCHAR2(100)
);
 
-- Postagens de usuarios sobre eventos
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
 
-- Ocorrencias geradas a partir de postagens
CREATE TABLE ocorrencias (
    id INT PRIMARY KEY,
    postagem_id INT NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('Antiga', 'Recente', 'Atual')),
    data_ocorrencia TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (postagem_id) REFERENCES postagens(id)
);

--3. Procedures DML por tabela
-- Procedure: Inserir Usu�rio
CREATE OR REPLACE PROCEDURE inserir_usuario (
    p_id            IN usuarios.id%TYPE,
    p_nome          IN usuarios.nome%TYPE,
    p_email         IN usuarios.email%TYPE,
    p_senha         IN usuarios.senha%TYPE,
    p_endereco      IN usuarios.endereco%TYPE,
    p_tipo_usuario  IN usuarios.tipo_usuario%TYPE DEFAULT 'user',
    p_data_cadastro IN usuarios.data_cadastro%TYPE DEFAULT SYSTIMESTAMP
)
AS

BEGIN
    INSERT INTO usuarios (
        id, nome, email, senha, endereco, tipo_usuario, data_cadastro
    ) VALUES (
        p_id, p_nome, p_email, p_senha, p_endereco, p_tipo_usuario, p_data_cadastro
    );
    DBMS_OUTPUT.PUT_LINE('Usu�rio inserido com sucesso: ID = ' || p_id);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ID ou e-mail de usu�rio j� existe. ID = ' || p_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir usu�rio.');
END;
/

-- Procedure: Inserir Localidade
CREATE OR REPLACE PROCEDURE inserir_localidade (
    p_id        IN localidades.id%TYPE,
    p_bairro    IN localidades.bairro%TYPE,
    p_zona      IN localidades.zona%TYPE
)
AS

BEGIN
    INSERT INTO localidades (id, bairro, zona)
    VALUES (p_id, p_bairro, p_zona);
    DBMS_OUTPUT.PUT_LINE('Localidade inserida com sucesso: ID = ' || p_id);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ID de localidade j� existe. ID = ' || p_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir localidade.');
END;
/

-- Procedure: Inserir Evento
CREATE OR REPLACE PROCEDURE inserir_evento (
    p_id          IN eventos.id%TYPE,
    p_tipo        IN eventos.tipo%TYPE,
    p_descricao   IN eventos.descricao%TYPE
)
AS

BEGIN
    INSERT INTO eventos (id, tipo, descricao)
    VALUES (p_id, p_tipo, p_descricao);
    DBMS_OUTPUT.PUT_LINE('Evento inserido com sucesso: ID = ' || p_id);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ID de evento j� existe. ID = ' || p_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir evento.');
END;
/
-- Procedure: Inserir Postagem
CREATE OR REPLACE PROCEDURE inserir_postagem (
    p_id            IN postagens.id%TYPE,
    p_usuario_id    IN postagens.usuario_id%TYPE,
    p_evento_id     IN postagens.evento_id%TYPE,
    p_localidade_id IN postagens.localidade_id%TYPE,
    p_titulo        IN postagens.titulo%TYPE,
    p_descricao     IN postagens.descricao%TYPE,
    p_imagem_url    IN postagens.imagem_url%TYPE
) AS

BEGIN
    INSERT INTO postagens (
        id, usuario_id, evento_id, localidade_id, titulo, descricao, imagem_url
    ) VALUES (
        p_id, p_usuario_id, p_evento_id, p_localidade_id, p_titulo, p_descricao, p_imagem_url
    );
    DBMS_OUTPUT.PUT_LINE('Postagem inserida com sucesso: ID = ' || p_id);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ID de postagem j� existe. ID = ' || p_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir postagem.');
END;
/

-- Procedure: Inserir Ocorr�ncia
CREATE OR REPLACE PROCEDURE inserir_ocorrencia (
    p_id             IN ocorrencias.id%TYPE,
    p_postagem_id    IN ocorrencias.postagem_id%TYPE,
    p_status         IN ocorrencias.status%TYPE,
    p_data_ocorrencia IN ocorrencias.data_ocorrencia%TYPE
) AS

BEGIN
    INSERT INTO ocorrencias (id, postagem_id, status, data_ocorrencia)
    VALUES (p_id, p_postagem_id, p_status, p_data_ocorrencia);
 
    DBMS_OUTPUT.PUT_LINE('Ocorr�ncia inserida com sucesso: ID = ' || p_id);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ID de ocorr�ncia j� existe. ID = ' || p_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao inserir ocorr�ncia.');
END;
/

-- Procedure: Atualizar Usu�rio
CREATE OR REPLACE PROCEDURE atualizar_usuario (
    p_id            IN usuarios.id%TYPE,
    p_nome          IN usuarios.nome%TYPE,
    p_email         IN usuarios.email%TYPE,
    p_senha         IN usuarios.senha%TYPE,
    p_endereco      IN usuarios.endereco%TYPE,
    p_tipo_usuario  IN usuarios.tipo_usuario%TYPE,
    p_data_cadastro IN usuarios.data_cadastro%TYPE
) AS
    v_count INTEGER;

BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM usuarios
    WHERE id = p_id;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum usu�rio encontrado com ID = ' || p_id);
    ELSE
       
        UPDATE usuarios
        SET    nome           = p_nome,
               email          = p_email,
               senha          = p_senha,
               endereco       = p_endereco,
               tipo_usuario   = p_tipo_usuario,
               data_cadastro  = p_data_cadastro
        WHERE  id             = p_id;

        DBMS_OUTPUT.PUT_LINE('Usu�rio atualizado com sucesso: ID = ' || p_id);
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: E-mail de usu�rio j� existe. E-mail = ' || p_email);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar usu�rio.');
END;
/
-- Procedure: Atualizar Localidade
CREATE OR REPLACE PROCEDURE atualizar_localidade (
    p_id     IN localidades.id%TYPE,
    p_bairro IN localidades.bairro%TYPE,
    p_zona   IN localidades.zona%TYPE
) AS
    v_exists NUMBER;

BEGIN
     SELECT COUNT(*)
     INTO v_exists
     FROM localidades
     WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma localidade encontrada com ID = ' || p_id);
    ELSE
        UPDATE localidades
        SET   bairro = p_bairro,
              zona   = p_zona
        WHERE id     = p_id;

        DBMS_OUTPUT.PUT_LINE('Localidade atualizada com sucesso: ID = ' || p_id);
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado detectado. Bairro = ' || p_bairro);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar localidade.');
END;
/

-- Procedure: Atualizar Evento
CREATE OR REPLACE PROCEDURE atualizar_evento (
    p_id         IN eventos.id%TYPE,
    p_tipo       IN eventos.tipo%TYPE,
    p_descricao  IN eventos.descricao%TYPE
) AS
    v_exists NUMBER;

BEGIN
    SELECT COUNT(*) 
    INTO v_exists
    FROM eventos
    WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum evento encontrado com ID = ' || p_id);
    ELSE
        UPDATE eventos
        SET    tipo      = p_tipo,
               descricao = p_descricao
        WHERE  id        = p_id;

        DBMS_OUTPUT.PUT_LINE('Evento atualizado com sucesso: ID = ' || p_id);
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado detectado. Tipo = ' || p_tipo);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar evento.');
END;
/

-- Procedure: Atualizar Postagem
CREATE OR REPLACE PROCEDURE atualizar_postagem (
    p_id            IN postagens.id%TYPE,
    p_usuario_id    IN postagens.usuario_id%TYPE,
    p_evento_id     IN postagens.evento_id%TYPE,
    p_localidade_id IN postagens.localidade_id%TYPE,
    p_titulo        IN postagens.titulo%TYPE,
    p_descricao     IN postagens.descricao%TYPE,
    p_imagem_url    IN postagens.imagem_url%TYPE
) AS

BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM postagens
    WHERE id = p_id;
    
    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma postagem encontrada com ID = ' || p_id);

    UPDATE postagens
    SET    usuario_id    = p_usuario_id,
           evento_id     = p_evento_id,
           localidade_id = p_localidade_id,
           titulo        = p_titulo,
           descricao     = p_descricao,
           imagem_url    = p_imagem_url
    WHERE  id            = p_id;

    DBMS_OUTPUT.PUT_LINE('Postagem atualizada com sucesso: ID = ' || p_id);
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em �ndice.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar postagem. C�dgio: ');

END;
/

-- Procedure: Atualizar Ocorr�ncia
CREATE OR REPLACE PROCEDURE atualizar_ocorrencia (
    p_id             IN ocorrencias.id%TYPE,
    p_postagem_id    IN ocorrencias.postagem_id%TYPE,
    p_status         IN ocorrencias.status%TYPE
) AS
    v_exists NUMBER;

BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM ocorrencias
    WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma ocorr�ncia encontrada com ID = ' || p_id);
    ELSE
        UPDATE ocorrencias
        SET    postagem_id = p_postagem_id,
               status      = p_status
        WHERE  id          = p_id;

        DBMS_OUTPUT.PUT_LINE('Ocorr�ncia atualizada com sucesso: ID = ' || p_id);
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Valor duplicado em �ndice.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao atualizar ocorr�ncia.');
END;
/

-- Procedure: Deletar Usu�rio
CREATE OR REPLACE PROCEDURE deletar_usuario (
    p_id IN usuarios.id%TYPE  
) AS
    v_exists NUMBER;

BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM usuarios
    WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Usu�rio com ID ' || p_id || ' n�o encontrado.');
    ELSE
        DELETE FROM usuarios WHERE id = p_id;
        DBMS_OUTPUT.PUT_LINE('Usu�rio com ID ' || p_id || ' deletado com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar o usu�rio.');
END;
/

-- Procedure: Deletar Localidade
CREATE OR REPLACE PROCEDURE deletar_localidade (
    p_id IN localidades.id%TYPE
) AS
    v_exists NUMBER;

BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM localidades
    WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma localidade encontrada com ID = ' || p_id);
    ELSE
        DELETE FROM localidades WHERE id = p_id;
        DBMS_OUTPUT.PUT_LINE('Localidade com ID = ' || p_id || ' deletada com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao deletar localidade.');
END;
/

-- Procedure: Deletar Evento
CREATE OR REPLACE PROCEDURE deletar_evento (
    p_id IN eventos.id%TYPE
) AS
    v_exists NUMBER;

BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM eventos
    WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum evento encontrado com ID = ' || p_id);
    ELSE
        DELETE FROM eventos WHERE id = p_id;
        DBMS_OUTPUT.PUT_LINE('Evento com ID = ' || p_id || ' deletado com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao deletar evento.');
END;
/

-- Procedure: Deletar Postagem
CREATE OR REPLACE PROCEDURE deletar_postagem (
    p_id IN postagens.id%TYPE
) AS
    v_exists NUMBER;

BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM postagens 
    WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma postagem encontrada com ID = ' || p_id);
    ELSE
        DELETE FROM postagens WHERE id = p_id;
        DBMS_OUTPUT.PUT_LINE('Postagem com ID = ' || p_id || ' deletada com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao deletar postagem.');
END;
/

-- Procedure: Deletar Ocorr�ncia
CREATE OR REPLACE PROCEDURE deletar_ocorrencia (
    p_id IN ocorrencias.id%TYPE
) AS
    v_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_exists
    FROM ocorrencias
    WHERE id = p_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhuma ocorr�ncia encontrada com ID = ' || p_id);
    ELSE
        DELETE FROM ocorrencias WHERE id = p_id;
        DBMS_OUTPUT.PUT_LINE('Ocorr�ncia com ID = ' || p_id || ' deletada com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao deletar ocorr�ncia.');
END;
/

SET SERVEROUTPUT ON
BEGIN
    inserir_usuario(1, 'Alice Souza', 'alice.souza@example.com', 'senha123', 'Rua das Flores, 123', 'user', TO_TIMESTAMP('2025-05-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(2, 'Bruno Lima', 'bruno.lima@example.com', 'bruno456', 'Av. Paulista, 456', 'user', TO_TIMESTAMP('2025-05-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(3, 'Carla Mendes', 'carla.mendes@example.com', 'carla789', 'Rua das Ac�cias, 789', 'user', TO_TIMESTAMP('2025-05-03 12:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(4, 'Diego Ferreira', 'diego.ferreira@example.com', 'diego321', 'Rua Central, 321', 'user', TO_TIMESTAMP('2025-05-04 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(5, 'Eduarda Silva', 'eduarda.silva@example.com', 'eduarda654', 'Av. Brasil, 654', 'user', TO_TIMESTAMP('2025-05-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(6, 'Felipe Rocha', 'felipe.rocha@example.com', 'felipe987', 'Rua Nova, 987', 'user', TO_TIMESTAMP('2025-05-06 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(7, 'Gabriela Costa', 'gabriela.costa@example.com', 'gabi123', 'Av. Rio Branco, 123', 'user', TO_TIMESTAMP('2025-05-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(8, 'Henrique Souza', 'henrique.souza@example.com', 'henrique456', 'Rua S�o Jo�o, 456', 'user', TO_TIMESTAMP('2025-05-08 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(9, 'Isabela Martins', 'isabela.martins@example.com', 'isabela789', 'Av. Independ�ncia, 789', 'user', TO_TIMESTAMP('2025-05-09 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));
    inserir_usuario(10, 'Jo�o Pedro', 'joao.pedro@example.com', 'joao321', 'Rua do Com�rcio, 321', 'user', TO_TIMESTAMP('2025-05-10 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));
END;
/

SET SERVEROUTPUT ON
BEGIN
    inserir_localidade(1, 'Centro', 'Urbana');
    inserir_localidade(2, 'Jardim Am�rica', 'Urbana');
    inserir_localidade(3, 'Vila Nova', 'Urbana');
    inserir_localidade(4, 'Zona Rural', 'Rural');
    inserir_localidade(5, 'Parque Industrial', 'Industrial');
    inserir_localidade(6, 'Jardim das Flores', 'Urbana');
    inserir_localidade(7, 'Bairro Alto', 'Urbana');
    inserir_localidade(8, 'Col�nia Agr�cola', 'Rural');
    inserir_localidade(9, 'Setor Comercial', 'Industrial');
    inserir_localidade(10, 'Vila Esperan�a', 'Urbana');
END;
/

SET SERVEROUTPUT ON
BEGIN
    inserir_evento(1, 'Enchente', 'Enchente causou alagamento em diversas ruas do centro.');
    inserir_evento(2, 'Enchente', 'Transbordamento de rio provocou evacua��o de moradores.');
    inserir_evento(3, 'Calor Intenso', 'Onda de calor com temperaturas acima de 40�C.');
    inserir_evento(4, 'Calor Intenso', 'Alerta de sa�de p�blica devido ao calor extremo.');
    inserir_evento(5, 'Deslizamento', 'Deslizamento de terra interditou a estrada principal.');
    inserir_evento(6, 'Deslizamento', 'Deslizamento atingiu algumas resid�ncias na encosta.');
    inserir_evento(7, 'Fiscaliza��o', 'Fiscaliza��o de �reas de risco ap�s fortes chuvas.');
    inserir_evento(8, 'Resgate', 'Resgate de fam�lias ilhadas por enchente.');
    inserir_evento(9, 'Manuten��o', 'Manuten��o de barreiras de conten��o em �rea de risco.');
    inserir_evento(10, 'Patrulhamento', 'Patrulhamento preventivo em �reas suscet�veis a enchentes.');
END;
/

SET SERVEROUTPUT ON
BEGIN
    inserir_postagem(1, 1, 1, 1, 'Alagamento no Centro', 'As ruas est�o completamente alagadas ap�s a enchente.', 'https://imagensite.com/alagamento1.jpg');
    inserir_postagem(2, 2, 2, 2, 'Onda de Calor', 'Temperaturas est�o muito altas, recomenda��o de hidrata��o.', 'https://imagensite.com/calor1.jpg');
    inserir_postagem(3, 3, 3, 3, 'Deslizamento na encosta', 'Deslizamento bloqueou estrada e atingiu casas.', 'https://imagensite.com/deslizamento1.jpg');
    inserir_postagem(4, 4, 4, 4, 'Fiscaliza��o nas �reas de risco', 'Equipes monitoram �reas afetadas pela chuva.', 'https://imagensite.com/fiscalizacao1.jpg');
    inserir_postagem(5, 5, 5, 5, 'Resgate em enchente', 'Bombeiros resgataram moradores ilhados.', 'https://imagensite.com/resgate1.jpg');
    inserir_postagem(6, 6, 6, 6, 'Atropelamento na faixa', 'Pedestre foi atropelado na faixa de pedestres.', 'https://imagensite.com/atropelamento1.jpg');
    inserir_postagem(7, 7, 7, 7, 'Colis�o m�ltipla', 'Engavetamento com tr�s ve�culos.', 'https://imagensite.com/colisao1.jpg');
    inserir_postagem(8, 8, 8, 8, 'Manuten��o preventiva', 'Viatura passou por manuten��o preventiva.', 'https://imagensite.com/manutencao1.jpg');
    inserir_postagem(9, 9, 9, 9, 'Patrulhamento em bairro', 'Equipe realiza patrulhamento em �rea residencial.', 'https://imagensite.com/patrulhamento1.jpg');
    inserir_postagem(10, 10, 10, 10, 'Blitz na entrada da cidade', 'Opera��o de fiscaliza��o com abordagem a ve�culos.', 'https://imagensite.com/blitz1.jpg');
END;
/

SET SERVEROUTPUT ON
BEGIN
    inserir_ocorrencia(1, 1, 'Antiga', TO_DATE('2025-05-29', 'YYYY-MM-DD'));
    inserir_ocorrencia(2, 2, 'Recente', TO_DATE('2025-05-28', 'YYYY-MM-DD'));
    inserir_ocorrencia(3, 3, 'Atual', TO_DATE('2025-05-27', 'YYYY-MM-DD'));
    inserir_ocorrencia(4, 4, 'Antiga', TO_DATE('2025-05-26', 'YYYY-MM-DD'));
    inserir_ocorrencia(5, 5, 'Recente', TO_DATE('2025-05-25', 'YYYY-MM-DD'));
    inserir_ocorrencia(6, 6, 'Atual', TO_DATE('2025-05-24', 'YYYY-MM-DD'));
    inserir_ocorrencia(7, 7, 'Antiga', TO_DATE('2025-05-23', 'YYYY-MM-DD'));
    inserir_ocorrencia(8, 8, 'Recente', TO_DATE('2025-05-22', 'YYYY-MM-DD'));
    inserir_ocorrencia(9, 9, 'Atual', TO_DATE('2025-05-21', 'YYYY-MM-DD'));
    inserir_ocorrencia(10, 10, 'Antiga', TO_DATE('2025-05-20', 'YYYY-MM-DD'));
END;


--4. Fun��es para Retorno de Dados Processados
CREATE OR REPLACE FUNCTION calcular_risco_medio (
    p_zona IN localidades.zona%TYPE
) RETURN NUMBER IS
    v_total_ocorrencias NUMBER := 0;
    v_total_postagens   NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO   v_total_ocorrencias
    FROM   ocorrencias o
    JOIN   postagens p     ON o.postagem_id = p.id
    JOIN   localidades l   ON p.localidade_id = l.id
    WHERE  l.zona = p_zona;

    SELECT COUNT(*)
    INTO   v_total_postagens
    FROM   postagens p
    JOIN   localidades l ON p.localidade_id = l.id
    WHERE  l.zona = p_zona;

    IF v_total_postagens = 0 THEN
        RETURN 0;
    ELSE
        RETURN v_total_ocorrencias / v_total_postagens;
    END IF;
END;

-- Chamada da fun��o 1
SELECT calcular_risco_medio('Urbana') AS risco_medio FROM dual;


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
-- Chamada da fun��o 2
SELECT total_ocorrencias_por_zona('Urbana') AS total_ocorrencias FROM dual;

--5. Blocos An�nimos com Consultas Complexas
-- Bloco An�nimo: Relat�rio de Ocorr�ncias Recentes por Zona com Filtro de M�nimo
SET SERVEROUTPUT ON

DECLARE

    v_msg VARCHAR2(100);

    CURSOR cur_ocorrencias IS
        SELECT l.zona, COUNT(o.id) AS total_ocorrencias
        FROM localidades l
        JOIN postagens p ON p.localidade_id = l.id
        JOIN ocorrencias o ON o.postagem_id = p.id
        GROUP BY l.zona
        HAVING COUNT(o.id) > 0
        ORDER BY total_ocorrencias DESC;

    
BEGIN
    FOR rec IN cur_ocorrencias LOOP
        IF rec.total_ocorrencias > 5 THEN
            v_msg := 'Zona ' || rec.zona || ' tem ALTO n�mero de ocorr�ncias: ' || rec.total_ocorrencias;
        ELSE
            v_msg := 'Zona ' || rec.zona || ' tem n�mero MODERADO de ocorr�ncias: ' || rec.total_ocorrencias;
        END IF;

        DBMS_OUTPUT.PUT_LINE(v_msg);
    END LOOP;
END;
/

-- Bloco An�nimo: Valida��o e Classifica��o de Risco M�dio por Bairro
SET SERVEROUTPUT ON;

DECLARE
    TYPE t_zonas IS TABLE OF localidades.zona%TYPE;
    v_zonas t_zonas := t_zonas('Urbana', 'Rural', 'Industrial');

    v_total NUMBER;
BEGIN
    FOR i IN 1 .. v_zonas.COUNT LOOP
        SELECT COUNT(*)
        INTO v_total
        FROM ocorrencias o
        WHERE o.postagem_id IN (
            SELECT p.id
            FROM postagens p
            JOIN localidades l ON p.localidade_id = l.id
            WHERE l.zona = v_zonas(i)
        );

        IF v_total = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Zona ' || v_zonas(i) || ' n�o tem ocorr�ncias.');
        ELSIF v_total < 3 THEN
            DBMS_OUTPUT.PUT_LINE('Zona ' || v_zonas(i) || ' tem poucas ocorr�ncias: ' || v_total);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Zona ' || v_zonas(i) || ' tem v�rias ocorr�ncias: ' || v_total);
        END IF;
    END LOOP;
END;
/

--6. Cursores Expl�citos
--Utiliza��o de cursores para leitura de dados com OPEN, FETCH, CLOSE
DECLARE
    v_nome   usuarios.nome%TYPE;
    v_email  usuarios.email%TYPE;

    CURSOR c_usuarios IS
        SELECT nome, email
        FROM   usuarios;
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

--Uso dentro de um LOOP emum dos blocos an�nimos ou procedures
CREATE OR REPLACE PROCEDURE listar_usuarios IS
    v_nome   usuarios.nome%TYPE;
    v_email  usuarios.email%TYPE;

    CURSOR c_usuarios IS
        SELECT nome, email
        FROM   usuarios;
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

--7. ConsultasSQL Complexas(relat�rios)
--1. Listar usu�rios com a quantidade de postagens
SELECT u.id, u.nome, COUNT(p.id) AS total_postagens
FROM usuarios u
LEFT JOIN postagens p ON u.id = p.usuario_id
GROUP BY u.id, u.nome
ORDER BY total_postagens DESC;

--2. Mostrar as localidades e a quantidade de postagens
SELECT l.bairro, l.zona, COUNT(p.id) AS total_postagens
FROM localidades l
JOIN postagens p ON l.id = p.localidade_id
GROUP BY l.bairro, l.zona
HAVING COUNT(p.id) > 0
ORDER BY total_postagens DESC;

--3. Contar a quantidade de ocorr�ncias por status 
SELECT e.tipo, o.status, COUNT(o.id) AS total_ocorrencias
FROM eventos e
JOIN postagens p ON e.id = p.evento_id
JOIN ocorrencias o ON p.id = o.postagem_id
GROUP BY e.tipo, o.status
ORDER BY e.tipo, o.status;

--4. Calcular a m�dia de postagens por usu�rio
SELECT AVG(qtd_postagens) AS media_postagens_por_usuario
FROM (
    SELECT u.id, COUNT(p.id) AS qtd_postagens
    FROM usuarios u
    LEFT JOIN postagens p ON u.id = p.usuario_id
    WHERE u.tipo_usuario = 'user'
    GROUP BY u.id
) sub;

--5. Listar os usu�rios que fizeram postagens em bairros espec�ficos
SELECT DISTINCT u.nome, p.titulo, l.bairro
FROM usuarios u
JOIN postagens p ON u.id = p.usuario_id
JOIN localidades l ON p.localidade_id = l.id
WHERE l.bairro IN (
    SELECT DISTINCT l2.bairro
    FROM localidades l2
    JOIN postagens p2 ON l2.id = p2.localidade_id
    JOIN ocorrencias o ON p2.id = o.postagem_id
    WHERE o.status = 'Recente'
)
ORDER BY u.nome;

--6. Total de ocorr�ncias por tipo de evento em localidades
SELECT 
  e.tipo, 
  SUM(1) AS total_ocorrencias
FROM eventos e
JOIN postagens p ON e.id = p.evento_id
JOIN ocorrencias o ON p.id = o.postagem_id
WHERE p.localidade_id IN (
    SELECT l.id
    FROM localidades l
    JOIN postagens p2 ON l.id = p2.localidade_id
    JOIN ocorrencias o2 ON p2.id = o2.postagem_id
    WHERE o2.status = 'Recente'
)
GROUP BY e.tipo
HAVING SUM(1) > 1
ORDER BY total_ocorrencias DESC;












create table livros(
    nome_livro VARCHAR(100),
    nome_autor VARCHAR(30),
    sexo_autor ENUM('Masculino', 'Feminino'),
    numero_paginas INT,
    nome_editora VARCHAR(30),
    valor_livro float,
    estado CHAR(2),
    ano_publicacao INT(4)
);

INSERT INTO livros VALUES ('Cavaleiro Real',	'Ana Claudia'	,'Feminino',	465,	'Atlas',	49.9	, 'RJ',	2009);
INSERT INTO livros VALUES ('SQL para leigos',	'João Nunes',	'Masculino',	450,	'Addison',	98,	'SP',	2018);
INSERT INTO livros VALUES ('Receitas Caseiras',	'Celia Tavares',	'Feminino',	210,	'Atlas',	45,	'RJ',	2008);
INSERT INTO livros VALUES ('Pessoas Efetivas',	'Eduardo Santos',	'Masculino',	390,	'Beta',	78.99,	'RJ',	2018);
INSERT INTO livros VALUES ('Habitos Saudáveis',	'Eduardo Santos',	'Masculino',	630,	'Beta',	150.98,	'RJ',	2019);
INSERT INTO livros VALUES ('A Casa Marrom',	'Hermes Macedo',	'Masculino',	250,	'Bubba',	60,	'MG',	2016);
INSERT INTO livros VALUES ('Estacio Querido',	'Geraldo Francisco',	'Masculino',	310,	'Insignia',	100,	'ES',	2015);
INSERT INTO livros VALUES ('Pra sempre amigas',	'Leda Silva',	'Feminino',	510,	'Insignia',	78.98,	'ES',	2011);
INSERT INTO livros VALUES ('Copas Inesqueciveis',	'Marco Alcantara',	'Masculino',	200,	'Larson',	130.98,	'RS',	2018);
INSERT INTO livros VALUES ('O poder da mente',	'Clara Mafra',	'Feminino',	120,	'Continental',	56.58,	'SP',	2017);


create table clientes(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30),
    endereco VARCHAR(100)
);

create table telefones(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero_telefone VARCHAR(30)
);

create table clientes_telefones(
    cliente_id INT NOT NULL,
    telefone_id INT NOT NULL,
    foreign key (cliente_id) references clientes(id),
    foreign key  (telefone_id) references telefones(id)
    );


-- 1- select * from livros;
-- 2- select nome_livro, nome_editora from livros;
-- 3- select nome_livro, estado from livros where sexo_autor = 'Masculino';
-- 4- select nome_livro, numero_paginas from livros where sexo_autor = 'Feminino';
-- 5- select valor_livro from livros where estado = 'SP';
-- 6 select * from livros where sexo_autor = 'Masculino' and (estado = 'SP' or estado = 'RJ');


-- exercício 2

-- select count(*) as n_funcionarios, departamento from funcionarios group by departamento order by 1; order by 1 quer dizer para ordernar de acordo com a coluna 1. 

-- select nome, departamento from funcionarios where departamento = 'Roupas' or departamento = 'Filmes';
-- select nome, departamento from funcionarios where (departamento = 'Lar' or departamento = 'Filmes') and sexo = 'Feminino';
-- select nome, sexo, departamento from funcionarios where sexo = 'Masculino' or departamento = 'Jardim';

UPDATE CLIENTE SET EMAIL = 'JOAO@IG.COM.BR' WHERE NOME = 'JOAO';
DELETE FROM CLIENTE WHERE NOME = 'ANA';


CREATE DATABASE COMERCIO;

USE COMERCIO;

SHOW DATABASES; --> OPCIONAL

DROP TABLE CLIENTE;

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT, 
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT, 
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);


/* ENDERECO - OBRIGATORIO 
CADASTRO DE SOMENTE UM.

TELEFONE - NAO OBRIGATORIO
CADASTRO DE MAIS DE UM (OPCIONAL) /*

/*
CHAVE ESTRANGEIRA É A CHAVE PRIMARIA DE UMA TABELA
QUE VAI ATÉ A OUTRA TABELA PARA FAZER REFERENCIA ENTRE
REGISTROS */

/* EM RELACIONAMENTO 1 X 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA */

/* EM RELACIONAMENTO 1 X N A CHAVE ESTRANGEIRA FICARA SEMPRE NA
CARDINALIDADE N */


SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJECAO */
FROM CLIENTE, ENDERECO /*ORIGEM */
WHERE IDCLIENTE = ID_CLIENTE; /* JUNCAO */

+--------+------+----------+----------------+
| NOME   | SEXO | BAIRRO   | CIDADE         |
+--------+------+----------+----------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO |
| CARLOS | M    | ESTACIO  | RIO DE JANEIRO |
| ANA    | F    | JARDINS  | SAO PAULO      |
| CLARA  | F    | CENTRO   | B. HORIZONTE   |
| JORGE  | M    | CENTRO   | VITORIA        |
| CELIA  | M    | FLAMENGO | RIO DE JANEIRO |
+--------+------+----------+----------------+


/* EVITANDO ERRO POR AMBIGUIDADE NO NOME DE COLUNAS */
SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE, TELEFONE.TIPO, TELEFONE.NUMERO 
FROM CLIENTE 
    INNER JOIN ENDERECO ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE 
    INNER JOIN TELEFONE ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE 
ORDER BY 1;


/* PONTEIRAMENTO, TANTO O EXEMPLO ABAIXO QUANTO O DE CIMA SÃO PONTEIRAMENTOS, ELES AJUDAM TAMBÉM NA
PERFORMANCE DO BANCO, POIS SEM APONTAR PARA QUAL TABELA O BANCO DEVE BUSCAR A INFORMAÇÃO DA COLUNA QUE 
SE DESEJA PROJETA, O BANCO IRÁ FAZER UMA VARREDURA NAS TABELAS PARA VER QUAIS TABELAS DE ORIGEM ENCONTRAM-SE ESSAS COLUNAS */
SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE;

/*
	
	DML - DATA MANIPULATION LANGUAGE
	DDL - DATA DEFINITION LANGUAGE
	DCL - DATA CONTROL LANGUAGE
	TCL - TRANSACTION CONTROL LANGUAGE

*/

/* DML - DATA MANIPULATION LANGUAGE */

/* INSERT */

INSERT INTO CLIENTE VALUES(NULL,'PAULA','M',NULL,'77437493');
INSERT INTO ENDERECO VALUES(NULL,'RUA JOAQUIM SILVA','ALVORADA','NITEROI','RJ',7);

SELECT * FROM CLIENTE;

/* FILTROS */

SELECT * FROM CLIENTE
WHERE SEXO = 'M';

/* UPDATE */

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 7;

UPDATE CLIENTE
SET SEXO = 'F'
WHERE IDCLIENTE = 7;

/* DELETE */ 

INSERT INTO CLIENTE VALUES(NULL,'XXX','M',NULL,'XXX');

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 8;

DELETE FROM CLIENTE WHERE IDCLIENTE = 8;

/* 
  DDL - DATA DEFINITION LANGUAGE
*/

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10,2) NOT NULL
);

/* ALTER TABLE */

/* ALTERANDO O NOME DE UMA COLUNA - CHANGE */

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;

/* MODIFY - ALTERANDO O TIPO */

ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

/* ADICIONANDO COLUNAS */

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

/* APAGANDO UMA COLUNA */

ALTER TABLE PRODUTO
DROP COLUMN PESO;

/* ADICIONANDO UMA COLUNA NA ORDEM ESPECIFICA */

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
AFTER NOME_PRODUTO;

ALTER TABLE PRODUTO
DROP COLUMN PESO;

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
FIRST;

/* RECOMENDAÇÃO, UTILIZAR CHANGE PARA ALTERAR O NOME DA COLUNA E TIPO 
E MODIFY QUANDO É PARA ALTERAR SOMENTE O TIPO DA COLUNA */

-- ATUALIZAÇÃO DE DADOS UTILIZANDO UMA LISTA
UPDATE CLIENTE SET SEXO = 'F' WHERE IDCLIENTE IN (11,12,16,17);

/* RELATORIO GERAL DE TODOS OS CLIENTES */

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF,
       E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO,
       T.TIPO, T.NUMERO
FROM CLIENTE C
    INNER JOIN ENDERECO E ON C.IDCLIENTE = E.ID_CLIENTE
    INNER JOIN TELEFONE T ON C.IDCLIENTE = T.ID_CLIENTE;

-- ESTÁ FALTANDO OS NOMES DE QUEM NÃO TEM TELEFONE

/* RELATORIO DE HOMENS */

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF,
       E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO,
       T.TIPO, T.NUMERO
FROM CLIENTE C
    INNER JOIN ENDERECO E ON C.IDCLIENTE = E.ID_CLIENTE
    INNER JOIN TELEFONE T ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = 'M';

-- RELATORIO DE MULHERES

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF,
       E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO,
       T.TIPO, T.NUMERO
FROM CLIENTE C
    INNER JOIN ENDERECO E ON C.IDCLIENTE = E.ID_CLIENTE
    INNER JOIN TELEFONE T ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = 'F';

-- QUANTIDADE DE HOMENS E MULHERES

SELECT SEXO, COUNT(*) AS QUANTIDADE FROM CLIENTE GROUP BY SEXO ORDER BY 1;

-- IDS E EMAIL DAS MULHERES QUE MOREM NO CENTRO DO RIO DE JANEIRO E NÃO TENHAM CELULAR


-- ESSA QUERY NÃO ESTÁ CORRETA POIS ELA AINDA PEGA QUEM TEM CELULAR, SÓ NÃO PROJETA O CELULAR.
SELECT C.IDCLIENTE, C.EMAIL, C.NOME, C.SEXO, T.TIPO, E.BAIRRO, E.CIDADE
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND BAIRRO = 'CENTRO' AND CIDADE = 'RIO DE JANEIRO'
AND (TIPO = 'RES' OR TIPO = 'COM');



-- AQUI PROJETA TODOS QUE NÃO SÃO ENCONTRADOS NA TABELA TELEFONE
SELECT C.IDCLIENTE, C.EMAIL FROM CLIENTE C 
WHERE 
    NOT EXISTS ( SELECT * FROM TELEFONE T WHERE C.IDCLIENTE = T.ID_CLIENTE) ORDER BY 1;


-- AQUI FILTRA OS QUE NÃO APARECEM NA TABELA TELEFONE E SÃO DO CENTRO DO RIO DE JANEIRO
SELECT C.IDCLIENTE, C.NOME, C.EMAIL, E.BAIRRO, E.CIDADE 
FROM CLIENTE C 
    INNER JOIN ENDERECO E ON C.IDCLIENTE = E.ID_CLIENTE
WHERE 
    NOT EXISTS ( SELECT * FROM TELEFONE T WHERE C.IDCLIENTE = T.ID_CLIENTE) 
    AND E.BAIRRO = 'CENTRO' AND E.CIDADE = 'RIO DE JANEIRO'
ORDER BY 1;

/* PARA UMA CAMPANHA DE MARKETING, O SETOR SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
DOS CLIENTES QUE MORAM NO ESTADO DO RIO DE JANEIRO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

SELECT   C.NOME, C.EMAIL, T.NUMERO AS CELULAR /* PROJECAO */
FROM CLIENTE C /* ORIGEM */
INNER JOIN ENDERECO E /*JUNCAO */
ON C.IDCLIENTE = E.ID_CLIENTE /*JUNCAO CONDICAO */
INNER JOIN TELEFONE T /*JUNCAO */
ON C.IDCLIENTE = T.ID_CLIENTE /*JUNCAO CONDICAO*/
WHERE TIPO = 'CEL' AND ESTADO = 'RJ'; /*SELECAO*/



/* PARA UMA CAMPANHA DE PRODUTOS DE BELEZA, O COMERCIAL SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
 DAS MULHERES QUE MORAM NO ESTADO DE SÃO PAULO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */


SELECT C.NOME, C.EMAIL, T.NUMERO AS CELULAR
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND ESTADO = 'SP';

SHOW TABLES;
SHOW DATABASES;
SHOW VIEW; -- NAO EXISTE

/* APAGANDO UMA VIEW */

DROP VIEW RELATORIO;

/* INSERINDO UM PREFIXO */

CREATE VIEW V_RELATORIO AS
SELECT  C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL", 
		T.TIPO, 
		T.NUMERO, 
		E.BAIRRO, 
		E.CIDADE, 
		E.ESTADO
FROM CLIENTE C 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT NOME, NUMERO, ESTADO
FROM V_RELATORIO;

/* UPDATE, INSERT E DELETE - DML */

INSERT INTO V_RELATORIO VALUES(
'ANDREIA','F','ANDREIA@UOL.COM.BR','CEL','873547864','CENTRO','VITORIA','ES'
);

ERROR 1394 (HY000): Can not insert into join view 'comercio.v_relatorio' without fields list
ERROR 1395 (HY000): Can not delete from join view 'comercio.v_relatorio'

DELETE FROM V_RELATORIO WHERE NOME = 'JORGE';

/* É PERMITIDO FAZER UPDATES EM VIEWS COM JOIN */

UPDATE V_RELATORIO SET NOME = 'JOSE' WHERE NOME = 'JORGE';

CREATE TABLE JOGADORES(
	IDJOGADOR INT,
	NOME VARCHAR(30),
	ESTADO CHAR(2)
);

INSERT INTO JOGADORES VALUES(1,'GUERRERO','RS');
INSERT INTO JOGADORES VALUES(2,'GABIGOL','RJ');
INSERT INTO JOGADORES VALUES(3,'GANSO','RJ');
INSERT INTO JOGADORES VALUES(4,'NENÊ', 'RJ');
INSERT INTO JOGADORES VALUES(5,'LOVE','SP');

CREATE VIEW V_JOGADORES AS
SELECT NOME, ESTADO
FROM JOGADORES;

SELECT * FROM V_JOGADORES;

DELETE FROM V_JOGADORES
WHERE NOME = 'GUERRERO';

INSERT INTO V_JOGADORES VALUES('GUERRERO','RS');

SELECT * FROM JOGADORES;

mysql> SELECT * FROM JOGADORES;
+-----------+----------+--------+
| IDJOGADOR | NOME     | ESTADO |
+-----------+----------+--------+
|         2 | GABIGOL  | RJ     |
|         3 | GANSO    | RJ     |
|         4 | NENÊ     | RJ     |
|         5 | LOVE     | SP     |
|      NULL | GUERRERO | RS     |
+-----------+----------+--------+

/* ORDER BY */

CREATE TABLE ALUNOS(
	NUMERO INT,
	NOME VARCHAR(30)
);

INSERT INTO ALUNOS VALUES(1,'JOAO');
INSERT INTO ALUNOS VALUES(1,'MARIA');
INSERT INTO ALUNOS VALUES(2,'ZOE');
INSERT INTO ALUNOS VALUES(2,'ANDRE');
INSERT INTO ALUNOS VALUES(3,'CLARA');
INSERT INTO ALUNOS VALUES(1,'CLARA');
INSERT INTO ALUNOS VALUES(4,'MAFRA');
INSERT INTO ALUNOS VALUES(5,'JANAINA');
INSERT INTO ALUNOS VALUES(1,'JANAINA');
INSERT INTO ALUNOS VALUES(3,'MARCELO');
INSERT INTO ALUNOS VALUES(4,'GIOVANI');
INSERT INTO ALUNOS VALUES(5,'ANTONIO');
INSERT INTO ALUNOS VALUES(6,'ANA');
INSERT INTO ALUNOS VALUES(6,'VIVIANE'); 

SELECT * FROM ALUNOS
ORDER BY NUMERO;

SELECT * FROM ALUNOS
ORDER BY 1;

SELECT * FROM ALUNOS
ORDER BY 2;

/* ORDENANDO POR MAIS DE UMA COLUNA */

SELECT * FROM ALUNOS
ORDER BY 1;

SELECT * FROM ALUNOS
ORDER BY NUMERO, NOME;

SELECT * FROM ALUNOS
ORDER BY 1, 2;

/* MESCLANDO ORDER BY COM PROJECAO */

SELECT NOME FROM ALUNOS
ORDER BY 1, 2;

SELECT NOME FROM ALUNOS
ORDER BY NUMERO, NOME;


/* ORDER BY DESC / ASC */

SELECT * FROM ALUNOS
ORDER BY 1, 2;

SELECT * FROM ALUNOS
ORDER BY 1 ASC;

SELECT * FROM ALUNOS
ORDER BY 1 DESC;

SELECT * FROM ALUNOS
ORDER BY 1, 2 DESC;

SELECT * FROM ALUNOS
ORDER BY 1 DESC, 2 DESC;

/* ORDENANDO COM JOINS */


SELECT  C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL", 
		T.TIPO, 
		T.NUMERO, 
		E.BAIRRO, 
		E.CIDADE, 
		E.ESTADO
FROM CLIENTE C 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
ORDER BY 1;

SHOW TABLES;

SELECT * FROM V_RELATORIO
ORDER BY 1;

/* Delimitador */

SELECT  C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL", 
		T.TIPO, 
		T.NUMERO, 
		E.BAIRRO, 
		E.CIDADE, 
		E.ESTADO
FROM CLIENTE C 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
ORDER BY 1



/* STORED PROCEDURES */
-- São procedimentos armazenados no banco
-- São como funções de outras linguagens

DELIMITER $ -- É necessário alterar o Delimitador ";" para que seja possível usar o ; dentro da procedure.

CREATE PROCEDURE NOME_EMPRESA()
BEGIN
	
	SELECT 'UNIVERSIDADE DOS DADOS' AS EMPRESA;

END
$

/* CHAMANDO UMA PROCEDURE */


CALL NOME_EMPRESA()$

DELIMITER ;


/* PROCEDURES COM PARAMETROS */

SELECT 10 + 10 AS CONTA;

DELIMITER $

CREATE PROCEDURE CONTA()
BEGIN
	
	SELECT 10 + 10 AS CONTA;

END
$

CALL CONTA();

DROP PROCEDURE CONTA;

DELIMITER $

CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT)
BEGIN
	
	SELECT NUMERO1 + NUMERO2 AS CONTA;

END
$

CALL CONTA(100,50)$
CALL CONTA(345634,4354)$
CALL CONTA(55654,56760)$
CALL CONTA(45646,6766)$


CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT(10,2),
	MARCO FLOAT(10,2)
);

INSERT INTO VENDEDORES VALUES(NULL,'CARLOS','M',76234.78,88346.87,5756.90);
INSERT INTO VENDEDORES VALUES(NULL,'MARIA','F',5865.78,6768.87,4467.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANTONIO','M',78769.78,6685.87,6664.90);
INSERT INTO VENDEDORES VALUES(NULL,'CLARA','F',5779.78,446886.87,8965.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANDERSON','M',676545.78,77544.87,578665.90);
INSERT INTO VENDEDORES VALUES(NULL,'IVONE','F',57789.78,44774.87,68665.90);
INSERT INTO VENDEDORES VALUES(NULL,'JOAO','M',4785.78,66478.87,6887.90);
INSERT INTO VENDEDORES VALUES(NULL,'CELIA','F',89667.78,57654.87,5755.90);

/* MAX - TRAZ O VALOR MAXIMO DE UMA COLUNA */

SELECT MAX(FEVEREIRO) AS MAIOR_FEV
FROM VENDEDORES;


/* MIN - TRAZ O VALOR MINIMO DE UMA COLUNA */

SELECT MIN(FEVEREIRO) AS MENOR_FEV
FROM VENDEDORES;

/* AVG - TRAZ O VALOR MEDIO DE UMA COLUNA */

SELECT AVG(FEVEREIRO) AS MEDIA_FEV
FROM VENDEDORES;

/* VARIAS FUNCOES */

SELECT MAX(JANEIRO) AS MAX_JAN,
       MIN(JANEIRO) AS MIN_JAN,
	   AVG(JANEIRO) AS MEDIA_JAN
	   FROM VENDEDORES;
	 
/*TRUNCATE */
	 
SELECT MAX(JANEIRO) AS MAX_JAN,
       MIN(JANEIRO) AS MIN_JAN,
	   TRUNCATE(AVG(JANEIRO),2) AS MEDIA_JAN
	   FROM VENDEDORES;

/* A30 - AGREGANDO COM SUM() */

SELECT SUM(JANEIRO) AS TOTAL_JAN
FROM VENDEDORES;

SELECT SUM(JANEIRO) AS TOTAL_JAN,
	   SUM(FEVEREIRO) AS TOTAL_FEV,
	   SUM(MARCO) AS TOTAL_MAR
FROM VENDEDORES;

/* VENDAS POR SEXO */

SELECT SEXO, SUM(MARCO) AS TOTAL_MARCO
FROM VENDEDORES
GROUP BY SEXO;


/* A 31 - SUBQUERIES

VENDEDOR QUE VENDEU MENOS EM MARCO
E O SEU NOME 

NOME E O VALOR QUE VENDEU MAIS EM MARCO

QUEM VENDEU MAIS QUE O VALOR MEDIO DE MARCO
*/

SELECT NOME, MARCO FROM VENDEDORES WHERE MARCO = (SELECT MIN(MARCO) FROM VENDEDORES);

SELECT NOME, MARCO FROM VENDEDORES WHERE MARCO = (SELECT MAX(MARCO) FROM VENDEDORES);

SELECT NOME, MARCO FROM VENDEDORES WHERE MARCO >= (SELECT AVG(MARCO) FROM VENDEDORES);


/* A32 - OPERACOES EM LINHA */

SELECT * FROM VENDEDORES;

SELECT NOME,
	   JANEIRO,
	   FEVEREIRO,
	   MARCO,
	   (JANEIRO+FEVEREIRO+MARCO) AS "TOTAL",
	   TRUNCATE((JANEIRO+FEVEREIRO+MARCO)/3,2) AS "MEDIA"
	   FROM VENDEDORES;
	   
/* APLICANDO UM % */

SELECT NOME,
	   JANEIRO,
	   FEVEREIRO,
	   MARCO,
	   (JANEIRO+FEVEREIRO+MARCO) AS "TOTAL",
	   (JANEIRO+FEVEREIRO+MARCO) * .25 AS "DESCONTO",
	   TRUNCATE((JANEIRO+FEVEREIRO+MARCO)/3,2) AS "MEDIA"
	   FROM VENDEDORES;


/* A33 - ALTERANDO TABELAS */

CREATE TABLE TABELA(
	COLUNA1 VARCHAR(30),
	COLUNA2 VARCHAR(30),
	COLUNA3 VARCHAR(30)
);


--ADICIONANDO UMA PK
ALTER TABLE TABELA 
ADD PRIMARY KEY (COLUNA1);
--Dessa forma não tem como adicionar o auto_increment, mas com o modify isso é possível

--ADICIONANDO COLUNA SEM POSICAO. ULTIMA POSICAO
ALTER TABLE TABELA 
ADD COLUNA varchar(30);

ALTER TABLE TABELA 
ADD COLUNA100 INT;

--ADICIONANDO UMA COLUNA COM POSICAO
ALTER TABLE TABELA 
ADD COLUMN COLUNA4 VARCHAR(30) NOT NULL UNIQUE
AFTER COLUNA3;

--MODIFICANDO O TIPO DE UM CAMPO
ALTER TABLE TABELA
 MODIFY COLUNA2 DATE NOT NULL;

--RENOMEANDO O NOME DA TABELA
ALTER TABLE TABELA 
RENAME PESSOA;

CREATE TABLE TIME(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	TIME VARCHAR(30),
	ID_PESSOA VARCHAR(30)
);

--Foreign key
ALTER TABLE TIME 
ADD FOREIGN KEY(ID_PESSOA)
REFERENCES PESSOA(COLUNA1);

/* VERIFICAR AS CHAVES */
SHOW CREATE TABLE TIME;


/* ADICIONANDO AUTO INCREMENT COM O MODIFY */
ALTER TABLE TABELA MODIFY COLUNA1 INT PRIMARY KEY AUTO_INCREMENT;



/* A34 - ORGANIZACAO DE CHAVES - CONSTRAINT (REGRA) */

CREATE TABLE JOGADOR(
	IDJOGADOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30)
);

CREATE TABLE TIMES(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	NOMETIME VARCHAR(30),
	ID_JOGADOR INT,
	FOREIGN KEY(ID_JOGADOR)
	REFERENCES JOGADOR(IDJOGADOR)
);

INSERT INTO JOGADOR VALUES(NULL,'GUERRERO');
INSERT INTO TIMES VALUES(NULL,'FLAMENGO',1);

SHOW CREATE TABLE JOGADOR;
SHOW CREATE TABLE TIMES;

/* A35 - ORGANIZANDO CHAVES
 */

SHOW TABLES;

DROP TABLE ENDERECO;
DROP TABLE TELEFONE;
DROP TABLE CLIENTE;

CREATE TABLE CLIENTE(
	IDCLIENTE INT,
	NOME VARCHAR(30) NOT NULL
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT
);

ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY(IDCLIENTE);

ALTER TABLE TELEFONE ADD CONSTRAINT FK_CLIENTE_TELEFONE
FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE);

SHOW CREATE TABLE TELEFONE;

/* DICIONARIO DE DADOS */

SHOW DATABASES;

USE INFORMATION_SCHEMA;

STATUS

SHOW TABLES;

DESC TABLE_CONSTRAINTS;

SELECT CONSTRAINT_SCHEMA AS "BANCO",
	   TABLE_NAME AS "TABELA",
	   CONSTRAINT_NAME AS "NOME REGRA",
	   CONSTRAINT_TYPE AS "TIPO"
	   FROM TABLE_CONSTRAINTS
	   WHERE CONSTRAINT_SCHEMA = 'COMERCIO';

/* APAGANDO CONSTRAINTS */

USE COMERCIO;

ALTER TABLE TELEFONE
DROP FOREIGN KEY FK_CLIENTE_TELEFONE;

ALTER TABLE TELEFONE ADD CONSTRAINT FK_CLIENTE_TELEFONE
FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE);
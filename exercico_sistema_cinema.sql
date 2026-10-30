CREATE DATABASE cinema
GO

CREATE TABLE filme (
ID INT PRIMARY KEY NOT NULL, titulo VARCHAR (80) NOT NULL, 
ano INT NULL CHECK (ano <= 2021));

CREATE TABLE DVD (
NUM INT PRIMARY KEY NOT NULL, data_fab DATE NOT NULL CHECK (data_fab < GETDATE()), 
ID_filme INT FOREIGN KEY REFERENCES filme (ID) NOT NULL);

CREATE TABLE estrela (
ID INT PRIMARY KEY NOT NULL,Nome VARCHAR (80) NOT NULL ,nome_real VARCHAR (50) NOT NULL);

CREATE TABLE clientee (
NUM_CAD INT PRIMARY KEY NOT NULL, nome VARCHAR (70) NOT NULL, 
logra VARCHAR (150) NOT NULL, num INT NOT NULL CHECK (num >=0), cep CHAR (8) NOT NULL);

CREATE TABLE filme_estrela (
filme_ID INT NOT NULL, estrela_ID INT NOT NULL, 
PRIMARY KEY (filme_ID, estrela_ID),
FOREIGN KEY (filme_ID) REFERENCES filme (ID),
FOREIGN KEY (estrela_ID) REFERENCES estrela (ID)
);

CREATE TABLE locacao (
DVD_NUM INT NOT NULL, cliente_NUM_CAD INT NOT NULL, data_locacao DATE NOT NULL DEFAULT GETDATE(),
data_devo INT NOT NULL CHECK (data_devo > data_locacao), valor DECIMAL (7,2) NOT NULL CHECK (valor >=0), 
PRIMARY KEY (DVD_NUM, cliente_NUM_CAD, data_locacao),
FOREIGN KEY (DVD_NUM) REFERENCES DVD (NUM), 
FOREIGN KEY (cliente_NUM_CAD) REFERENCES clientee (NUM_CAD)
);

INSERT INTO filme (ID, titulo, ano)
VALUES 
('1001', 'Whiplash', '2015'),
('1002', 'Birdman', '2015'),
('1003', 'Interestelar', '2014'),
('1004', 'A Culpa é das Estrelas', '2014'),
('1005', 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', '2014'),
('1006', 'Sing', '2016');

INSERT INTO estrela (ID, Nome, nome_real)
VALUES
('9901', 'Michael Keaton', 'Michael John Douglas'),
('9902', 'Emma Stone', 'Emily Jean Stone'),
('9903', 'Miles Teller', 'NULL'),
('9904', 'Steve Careli', 'Steven John Carell'),
('9905', 'Jennifer Garner', 'Jennifer Anne Garner');

INSERT INTO filme_estrela (filme_ID, estrela_ID)
VALUES
('1002','9901'),
('1002', '9902'),
('1001', '9903'),
('1005', '9904'),
('1005', '9905');

INSERT INTO DVD (NUM, data_fab, ID_filme)
VALUES
('10001', '2020-12-02', '1001'),
('10002', '2019-10-18', '1002'),
('10003', '2020-04-03', '1003'),
('10004', '2020-12-02', '1004'),
('10005', '2019-10-18', '1005'),
('10006', '2020-04-03', '1006'),
('10007', '2020-12-02', '1007'),
('10008', '2019-10-18', '1002'),
('10009', '2020-04-03', '1003');

INSERT INTO clientee (NUM_CAD, nome, logra, num, cep)
VALUES 
('5501', 'Matilde Luz', 'Rua Síria', '150', '03086040'),
('5502', 'Carlos Carreiro', 'Rua Bartolomeu Aires', '1250', '04419110'),
('5503', 'Daniel Ramalho', 'Rua Itajuba', '169', 'NULL'),
('5504', 'Roberta Bento', 'Rua Jayme Von Rosenburg', '36', 'NULL'),
('5505', 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', '235', '02917110');

INSERT INTO locacao (DVD_NUM, cliente_NUM_CAD, data_locacao, data_devo, valor)
VALUES 
('10001', '5502', '2021-02-18', '2021-02-21', '3.50'),
('10009', '5502', '2021-02-18', '2021-02-21', '3.50'),
('10002', '5503', '2021-02-18', '2021-02-19', '3.50'),
('10002', '5505', '2021-02-20', '2021-02-23', '3.00'),
('10004', '5505', '2021-02-20', '2021-02-23', '3.00'),
('10005', '5505', '2021-02-20', '2021-02-23', '3.00'),
('10001', '5501', '2021-02-24', '2021-02-26', '3.50'),
('10008', '5501', '2021-02-24', '2021-02-26', '3.50');

UPDATE DVD
SET data_fab = '2019-07-14'
WHERE NUM = 10005;

DELETE FROM DVD
WHERE NUM = 10006;

DELETE FROM filme
WHERE ID = 1006;

SELECT titulo
FROM filme
WHERE ano = 2014;

SELECT ID, ano
FROM filme
WHERE titulo = 'Birdman';

SELECT ID, ano
FROM filme
WHERE titulo LIKE '%plash';

SELECT estrela.ID, estrela.Nome, estrela.nome_real
FROM estrela
WHERE Nome LIKE 'Steve%';

SELECT ID_filme AS FilmeId,
CONVERT(VARCHAR(10), data_fab, 103) AS fab
FROM DVD
WHERE data_fab >= '2020-01-01';

SELECT 
DVD_NUM AS DVDnum,
data_locacao,
CONVERT(VARCHAR(10), DATEADD(DAY, data_devo, '19000101'), 103) AS data_devolucao,
valor,
valor + 2.00 AS valor_com_multa
FROM locacao
WHERE cliente_NUM_CAD = 5505;

SELECT logra AS Logradouro, num, cep
FROM clientee
WHERE nome = 'Matilde Luz';

SELECT nome_real
FROM estrela
WHERE Nome = 'Michael Keaton';

SELECT 
NUM_CAD AS num_cadastro,
nome,
CONCAT(logra, ', ', num, ', ', cep) AS end_comp
FROM clientee
WHERE NUM_CAD >= 5503;
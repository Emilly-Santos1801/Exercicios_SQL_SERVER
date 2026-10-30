CREATE DATABASE sistema_empresa
GO

CREATE TABLE projects (
ID INT PRIMARY KEY NOT NULL IDENTITY (10001,1), Nome VARCHAR(45) NOT NULL, 
descricao VARCHAR (45) NOT NULL, dataa DATE NOT NULL CHECK (dataa > '2014-09-01') );

CREATE TABLE users (
ID INT PRIMARY KEY NOT NULL IDENTITY (1,1), Nome VARCHAR (45) NOT NULL,
username VARCHAR (10) NOT NULL UNIQUE, senha VARCHAR (8) NOT NULL DEFAULT '123mudar', 
email VARCHAR (45) NOT NULL);

CREATE TABLE users_has_projects (
users_ID INT NOT NULL IDENTITY (1,1),
projects_ID INT NOT NULL,
PRIMARY KEY (users_ID, projects_ID),
FOREIGN KEY (users_ID) REFERENCES users (ID),
FOREIGN KEY (projects_ID) REFERENCES projects (ID)
);

INSERT INTO projects (Nome, descricao, dataa)
VALUES 
( 'Re-folha', 'Refatoração das folhas', '05/09/2014'),
( 'Manutenção PC´s', 'Manutenção PC´s', '06/09/2014'),
( 'Auditoria', 'NULL', '07/09/2014');

INSERT INTO users (Nome, username, senha, email)
VALUES 
( 'Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
( 'Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
( 'Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
( 'Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
( 'Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com');

--DELETE FROM users_has_projects;
INSERT INTO users_has_projects (users_ID, projects_ID)
VALUES 
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002); 

UPDATE projects
SET dataa = '2014-09-12'
WHERE ID = 10002;

UPDATE users
SET username = 'Rh_cido'
WHERE  username= 'Rh_apareci'

UPDATE users
SET senha = '888@*'
WHERE username = 'Rh_maria'

DELETE FROM users_has_projects
WHERE users_ID = 2
AND projects_ID = 10002;

SELECT * FROM users
SELECT * FROM projects
SELECT * FROM users_has_projects
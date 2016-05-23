/*
CREATE DATABASE MinhaCaixa;  
  --Informações opcionais que definem os paramentros do BD
  WITH OWNER = postgres 		-- Usuario do servidor que será o dono do BD.
       ENCODING = 'UTF8' 		-- Tipo de codificação que será utilizado.
       TABLESPACE = pg_default 		-- Aonde o BD será criado físicamente.
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1; 		-- Numero maximo de conexões simultaneas ao BD.
*/
/*
Para criar o BD, é mais simples fazer pelo SGBD, via codigo também funciona
porém é necessario desconectar e reconectar no servidor para aplicar a alteração
sendo que no postgre não existe o comando USE DATABASE
*/


ALTER DATABASE "MinhaCaixa" SET DATESTYLE TO iso, YMD;

CREATE TABLE Grupo
(
GrupoCodigo SERIAL, --Auto incremento habilitado
GrupoNome VARCHAR(50),
GrupoRazaoSocial VARCHAR(50),
GrupoCNPJ BIGINT,
CONSTRAINT PK_Grupo PRIMARY KEY (GrupoCodigo)
);

INSERT INTO Grupo
	(
	GrupoNome,
	GrupoRazaoSocial,
	GrupoCNPJ
)
VALUES (
	'MyBank',
	'MyBanck International SA',
	11222333000144
);

CREATE TABLE Clientes
(
ClienteCodigo SERIAL,
ClienteNome VARCHAR(50),
ClienteRua VARCHAR(50),
ClienteCidade VARCHAR(50),
ClienteNascimento DATE,
CONSTRAINT PK_Cliente PRIMARY KEY (ClienteCodigo)
);
--ON [PRIMARY]
/*
Quando existir campos auto incremento, ao inserir informações deve colocar DEFAULT no valor aonde será auto incremento
ou informar os campos que serão preenchidos deixando o código de fora
*/
INSERT INTO Clientes (ClienteNome, ClienteRua, ClienteCidade, ClienteNascimento) VALUES ('Ana', 'XV de Novembro','Joinville','1980-08-06');
INSERT INTO Clientes VALUES (DEFAULT,'Gertrudes','07 de Setembro','Parauapebas','1920-08-08');
INSERT INTO Clientes VALUES (DEFAULT,'Bucetilde','Maio de 01','Barrancas','2015-08-06');
INSERT INTO Clientes VALUES (DEFAULT,'Franco Bit','Felipe Schmidt','Floriano','1985-08-06');
INSERT INTO Clientes VALUES (DEFAULT,'Eduardo Cunha','Beria Mar Norte', 'Florianópolis','1971-10-10');
INSERT INTO Clientes VALUES (DEFAULT,'Dilma Rousef','24 de maios','Criciúma','1910-07-05');
INSERT INTO Clientes VALUES (DEFAULT,'Lula Lala','06 de agosto','Joinville','1960-08-06');
INSERT INTO Clientes VALUES (DEFAULT,'Bob Esponja','João Colin','Nova York','1980-02-19');
INSERT INTO Clientes VALUES (DEFAULT,'Frajola','Margem esquerda','Haiti do Sul','1920-03-07');
INSERT INTO Clientes VALUES (DEFAULT,'Catarreia','Esquino do vento','Garuva','2000-09-06');
INSERT INTO Clientes VALUES (DEFAULT,'Milclau Rosa','Iranius','Chuiu','1901-01-06');
INSERT INTO Clientes VALUES (DEFAULT,'Pedro Alvares Cabral','Itajai','Joinville','1845-06-08');
INSERT INTO Clientes VALUES (DEFAULT,'Thomas Turbando','Coffe','Pindaiba','2016-03-18');

CREATE TABLE Agencias
(
AgenciaCodigo Serial,
AgenciaNome VARCHAR (50),
AgenciaCidade VARCHAR (50),
AgenciaFundos MONEY,
GrupoCodigo INTEGER,
CONSTRAINT PK_Agencias PRIMARY KEY (AgenciaCodigo)
);

ALTER TABLE Agencias ADD CONSTRAINT FK_GRUPOS_AGENCIAS 
FOREIGN KEY (GrupoCodigo) 
REFERENCES Grupo;

INSERT INTO Agencias VALUES  (DEFAULT,'Verde Vale','Blumenau', 900000,1);
INSERT INTO Agencias VALUES  (DEFAULT,'Cidade das Flores','Joinville', 800000,1);
INSERT INTO Agencias VALUES  (DEFAULT,'Universitária', 'Florianópolis', 750000,1);
INSERT INTO Agencias VALUES  (DEFAULT,'Joinville', 'Joinville', 950000,1);
INSERT INTO Agencias VALUES  (DEFAULT,'Beira Mar', 'Florianópolis', 600000,1);
INSERT INTO Agencias VALUES  (DEFAULT,'Criciúma', 'Criciúma', 500000,1);
INSERT INTO Agencias VALUES  (DEFAULT,'Blumenau', 'Blumenau', 1100000,1);
INSERT INTO Agencias VALUES  (DEFAULT,'Germânia', 'Blumenau', 400000,1);

CREATE TABLE Contas
(
AgenciaCodigo INTEGER,
ContaNumero VARCHAR (10),
ClienteCodigo INTEGER,
ContaSaldo MONEY,
ContaAbertura DATE,
CONSTRAINT PK_CONTA PRIMARY KEY(ContaNumero)
);

ALTER TABLE Contas ADD CONSTRAINT FK_CLIENTES_CONTAS
FOREIGN KEY (ClienteCodigo)
REFERENCES Clientes (ClienteCodigo);

ALTER TABLE Contas ADD CONSTRAINT FK_AGENCIA_CONTAS
FOREIGN KEY  (AgenciaCodigo)
REFERENCES Agencias (AgenciaCodigo);

INSERT INTO Contas VALUES(4,'C-401',1,500,'2014-01-01');
INSERT INTO Contas VALUES(4,'C-402',2,200,'2014-02-27');
INSERT INTO Contas VALUES(4,'C-403',3,350,'2013-07-21');
INSERT INTO Contas VALUES(4,'C-404',7,870,'2013-08-11');
INSERT INTO Contas VALUES(1,'C-101',11,800,'2013-08-03');
INSERT INTO Contas VALUES(2,'C-201',4,800,'2013-04-12');
INSERT INTO Contas VALUES(3,'C-301',5,400,'2014-07-04');
INSERT INTO Contas VALUES(5,'C-501',6,300,'2011-03-23');
INSERT INTO Contas VALUES(6,'C-601',8,900,'2013-10-12');
INSERT INTO Contas VALUES(7,'C-701',9,550,'2011-09-02');
INSERT INTO Contas VALUES(8,'C-801',10,1000,'2007-08-01');

CREATE TABLE Emprestimos
(
AgenciaCodigo INTEGER,
ClienteCodigo INTEGER,
EmprestimoCodigo VARCHAR(10),
EmprestimoTotal MONEY
);

ALTER TABLE Emprestimos ADD CONSTRAINT FK_EMPRESTIMOS_CLIENTES
FOREIGN KEY (ClienteCodigo)
REFERENCES Clientes (ClienteCodigo);

ALTER TABLE Emprestimos ADD CONSTRAINT FK_EMPRESTIMOS_AGENGIA 
FOREIGN KEY (AgenciaCodigo) 
REFERENCES Agencias (AgenciaCodigo);

INSERT INTO Emprestimos VALUES (4,1,'L-10',2000);
INSERT INTO Emprestimos VALUES (2,4,'L-20',1500);
INSERT INTO Emprestimos VALUES (4,2,'L-15',1800);
INSERT INTO Emprestimos VALUES (4,3,'L-30',2500);
INSERT INTO Emprestimos VALUES (6,8,'L-40',3000);
INSERT INTO Emprestimos VALUES (1,11,'L-35',2800);
INSERT INTO Emprestimos VALUES (4,7,'L-50',2300);

CREATE TABLE Depositantes
(
AgenciaCodigo INTEGER,
ContaNumero VARCHAR(10),
ClienteCodigo INTEGER,
DepositoValor MONEY,
DepositoData DATE
);

ALTER TABLE Depositantes ADD CONSTRAINT FK_CONTA_AGENGIA 
FOREIGN KEY  (AgenciaCodigo) 
REFERENCES Agencias (AgenciaCodigo);

ALTER TABLE Depositantes ADD CONSTRAINT FK_DEPOSITANTES_CONTAS 
FOREIGN KEY  (ContaNumero) 
REFERENCES Contas (ContaNumero);

ALTER TABLE Depositantes ADD CONSTRAINT FK_DEPOSITANTES_CLIENTES 
FOREIGN KEY  (ClienteCodigo) 
REFERENCES Clientes (ClienteCodigo);

INSERT INTO Depositantes VALUES (4,'C-401',1,500,'2014-01-01');
INSERT INTO Depositantes VALUES (4,'C-402',2,200,'2014-02-27');
INSERT INTO Depositantes VALUES (4,'C-403',3,350,'2013-07-21');
INSERT INTO Depositantes VALUES (2,'C-201',4,800,'2013-04-12');
INSERT INTO Depositantes VALUES (3,'C-301',5,400,'2014-07-04');
INSERT INTO Depositantes VALUES (4,'C-404',7,870,'2013-08-11');
INSERT INTO Depositantes VALUES (5,'C-501',6,300,'2011-03-23');
INSERT INTO Depositantes VALUES (6,'C-601',8,900,'2013-10-12');
INSERT INTO Depositantes VALUES (7,'C-701',9,550,'2011-09-02');
INSERT INTO Depositantes VALUES (8,'C-801',10,1000,'2007-08-01');
INSERT INTO Depositantes VALUES (1,'C-101',11,800,'2013-08-03');

CREATE TABLE Devedores
(
AgenciaCodigo INTEGER,
ClienteCodigo INTEGER,
EmprestimoCodigo VARCHAR(10),
DevedorSaldo MONEY
);

ALTER TABLE Devedores ADD CONSTRAINT FK_DEVEDORES_AGENGIA 
FOREIGN KEY  (AgenciaCodigo) 
REFERENCES Agencias (AgenciaCodigo);

ALTER TABLE Devedores ADD CONSTRAINT FK_DEVEDORES_CONTAS 
FOREIGN KEY  (ClienteCodigo)
REFERENCES Clientes (ClienteCodigo);

INSERT INTO Devedores VALUES (4,1,'L-10',1000);
INSERT INTO Devedores VALUES (2,4,'L-20',500);
INSERT INTO Devedores VALUES (4,2,'L-15',800);
INSERT INTO Devedores VALUES (4,3,'L-30',2000);
INSERT INTO Devedores VALUES (6,8,'L-40',2000);
INSERT INTO Devedores VALUES (1,11,'L-35',2600);
INSERT INTO Devedores VALUES (4,7,'L-50',2300);

CREATE TABLE CartaoCredito
(
AgenciaCodigo INTEGER,
ClienteCodigo INTEGER,
CartaoCodigo VARCHAR(20),
CartaoLimite MONEY
);

ALTER TABLE CartaoCredito ADD CONSTRAINT FK_CARTAOCREDITO_AGENGIA 
FOREIGN KEY (AgenciaCodigo) 
REFERENCES Agencias (AgenciaCodigo);

ALTER TABLE CartaoCredito ADD CONSTRAINT FK_CARTAOCREDITO_CLIENTES 
FOREIGN KEY (ClienteCodigo) 
REFERENCES Clientes (ClienteCodigo);

INSERT INTO CartaoCredito VALUES (1,12,'1111-2222-3333-4444',1000);
INSERT INTO CartaoCredito VALUES (4,13,'1234-4567-8910-1112',1000);
INSERT INTO CartaoCredito VALUES (4,7,'2222-3333-4444-5555',2000);
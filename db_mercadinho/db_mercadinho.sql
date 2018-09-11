CREATE DATABASE db_mercadinho 

USE db_mercadinho 

-- -----------------------------------------------------
-- Table estoque
-- -----------------------------------------------------
 CREATE TABLE estoque (
  idproduto INT IDENTITY NOT NULL,
  nome VARCHAR(45) NOT NULL,
  quantidade INT NOT NULL,
  precotabela FLOAT NOT NULL,
  precocusto FLOAT NOT NULL,
  PRIMARY KEY (idproduto))
  
  -- -----------------------------------------------------
-- Table fornecedor
-- -----------------------------------------------------0
CREATE TABLE fornecedor (
	idfornecedor INT IDENTITY  NOT NULL,
	razaosocial VARCHAR(45) NOT NULL,
	cnpj VARCHAR(45) NOT NULL,
	endereco VARCHAR(45) NULL,
	telefone VARCHAR(45) NULL,
	inscricaoestadual VARCHAR(12) NULL,
	cep VARCHAR(8) NULL,
    PRIMARY KEY (idfornecedor))
-- -----------------------------------------------------
-- Table compra
-- ----------------------------------------------------- 
CREATE TABLE compra (
  idcompra INT IDENTITY NOT NULL,
  data DATE NOT NULL,
  idfornecedor INT NOT NULL,
  valor FLOAT NOT NULL,
  PRIMARY KEY (idcompra),
  FOREIGN KEY  (idfornecedor) REFERENCES fornecedor(idfornecedor))
		
-- -----------------------------------------------------
-- Table itemcompra
-- ----------------------------------------------------- 	
 CREATE TABLE itemcompra (
  id INT IDENTITY NOT NULL,
  idprodutoestoque INT NOT NULL,
  idcompraitem INT NOT NULL,
  qtn_itemcompra int NOT NULL,
  PRIMARY KEY (id),
    FOREIGN KEY (idprodutoestoque) REFERENCES estoque(idproduto),
    FOREIGN KEY (idcompraitem) REFERENCES compra(idcompra))
    
-- -----------------------------------------------------
-- Table cliente
-- ----------------------------------------------------- 
  CREATE TABLE cliente (
  idcliente INT IDENTITY NOT NULL,
  nome VARCHAR(45) NOT NULL,
  telefone VARCHAR(45) NULL,
  endereco VARCHAR(45) NULL,
  cep VARCHAR(8) NULL,
  cpf VARCHAR(11) NULL,
  situação VARCHAR (20),
  PRIMARY KEY (idcliente))

-- -----------------------------------------------------
-- Table formaspagamento
-- ----------------------------------------------------- 
  CREATE TABLE formaspagamento (
  id INT IDENTITY NOT NULL,
  formaspagamento VARCHAR(45) NOT NULL,
  quantidadeparcelas INT,
  PRIMARY KEY (id))
-- -----------------------------------------------------
-- Table venda
-- ----------------------------------------------------- 
  CREATE TABLE venda (
  idvenda INT IDENTITY NOT NULL,
  valor FLOAT NULL,
  idcliente INT NOT NULL,
  idformaspagamento INT NOT NULL,
  quantidadevendida int NOT NULL,
  data DATE NOT NULL,
  finalizado char NOT NULL,
  idproduto INT NOT NULL,
  PRIMARY KEY (idvenda), 
    FOREIGN KEY (idcliente) REFERENCES cliente (idcliente),	
    FOREIGN KEY (idformaspagamento) REFERENCES formaspagamento (id),
	FOREIGN KEY (idproduto) REFERENCES estoque (idproduto))
   
-- -----------------------------------------------------
-- Table contasreceber
-- ----------------------------------------------------- 
  CREATE TABLE contasreceber (
  id INT IDENTITY  NOT NULL,
  situacao VARCHAR(10)  NOT NULL,
  idvenda INT NOT NULL,
  valor FLOAT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idvenda ) REFERENCES venda (idvenda))
  
-- -----------------------------------------------------
-- Table dívidas
-- ----------------------------------------------------- 
	
	CREATE TABLE divida(
    iddivida int IDENTITY(1,1) NOT NULL,
	datadivida date NOT NULL,
	idcliente int NOT NULL,
	valor money NOT NULL,
	PRIMARY KEY (iddivida), 
    FOREIGN KEY (idcliente) REFERENCES cliente (idcliente)	
	)
 -- -----------------------------------------------------
-- Table nota fiscal
-- ----------------------------------------------------- 
     CREATE TABLE notafiscal (
	 idnota int IDENTITY(1,1) NOT NULL,
	 data DATE	NOT NULL,
	 idcliente int NOT NULL,
	 idvenda int NOT NULL,
	 PRIMARY KEY (idnota), 
     FOREIGN KEY (idcliente) REFERENCES cliente (idcliente)	
	
	)
	-- -----------------------------------------------------
-- Table maismenosvendidos
-- ----------------------------------------------------- 
	create table maismenosvendidos(
	id INT IDENTITY NOT NULL,
	num_ordem int,
	idproduto int NOT NULL,
	descricao VARCHAR(100),
	quantidadevendida float,
	PRIMARY KEY (id), 
	FOREIGN KEY (idproduto) REFERENCES estoque (idproduto))
		
	
-- -----------------------------------------------------
-- Inserts das tabelas
-- ----------------------------------------------------- 
	
insert into cliente (nome,telefone,endereco,cep,cpf, situação) 
VALUES('Matheus','84996702246','Ponta Negra','59090415','03499609096','ativo'),
('Laudeine','8412345678','Extremos','59000000','03499609096', 'ativo'),
('Allythi','8499545474','Zona Norte','59098744','74236985456', 'ativo'),
('Ze','848541474','Zona Norte','59558744','75564545126', 'ativo'),
('Metralha','8499515484','Zona Norte','59056404','74213255516', 'ativo');

insert into fornecedor (razaosocial,cnpj,endereco,telefone,inscricaoestadual,cep)
VALUES('Bonanza','10580643000105','Ponta Negra','84996451236','123456789011','59090000'),
('Joaninha','41065062000169','Ponta Branca','45999871236','123456789123','47095633'),
('SmartBeer','01165663000129','Casca Verde','36997120645','145203674102','78523654'),
('MatadorSA','85411096000133','Não me toque','84996451236','413621856302','92364100'),
('Nordestao','24134168000158','Ponta Negra','84998521463','413085463982','59090000');

insert into estoque (nome,quantidade,precotabela,precocusto)
VALUES('Coca-Cola','45','5.00','4.00'),
('Treloso','80','2.00','1.49'),
('Fanta','65','5.00','4.00'),
('Pitu','120','7.00','4.00'),
('Smirnoff','15','85.00','23.00');

insert into compra (data,idfornecedor,valor)
VALUES ('2017-12-04','2','740.68'),
('2017-08-13','5','897.45'),
('2017-06-08','3','147.36'),
('2017-07-07','4','951.56'),
('2017-03-04','1','153.13');

insert into itemcompra (idprodutoestoque,idcompraitem,qtn_itemcompra)
VALUES ('1','1','20'),
('2','5','35'),
('3','4','45'),
('4','3','67'),
('5','3','12');

insert into formaspagamento(formaspagamento)
VALUES ('Dinheiro'),('Cheque'),('Cartao'),('Parcelado'),('Fiado');

insert into venda (valor,idcliente,idformaspagamento, quantidadevendida, data,  finalizado, idproduto)
VALUES('25.00','2','5',6,'2017-02-14','s', 1),
('50','5','2', 7,'2017-02-14','s',2 ),
('23.45','3','3',8,'2017-02-14','f', 1 ),
('42.36','4','5', 10,'2017-02-14','s', 1 ),
('79.36','1','4', 20,'2017-02-14','s', 2 );

insert into divida (datadivida,idcliente,valor)
VALUES('2017-02-14', '1','2300'),
('2017-02-14','2','2300'),
('2017-02-14','3','2300'),
('2017-02-14','4','2300'),
('2017-02-14','5','2300' );


insert into contasreceber (situacao, idvenda, valor)
VALUES ('finalizada' , '2', '2000'),
       ('finalizada' , '1','3000'),
	   ('finalizada' , '4','4000');

insert into notafiscal (data,  idcliente, idvenda)
VALUES ('2017-02-14' , '2', '3'),
       ('2017-04-10' , '1', '4'),
	   ('2017-05-09' , '4', '1'),
	   ('2017-01-13' , '5', '2');
	   
insert into maismenosvendidos (num_ordem, idproduto, descricao, quantidadevendida)
VALUES ('123' , '2', 'coca-cola', '50'),
       ('124' , '1', 'refrigerante', '60'),
	   ('125' , '4', 'macarrão','10'),
	   ('126' , '5', 'danone', '40');
	   	   
	   
	   	  
	 
	 
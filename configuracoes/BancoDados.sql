CREATE DATABASE rastreamento_carne;
USE rastreamento_carne;

/*=====================================
	TABELA DE USUÁRIOS
=====================================*/

CREATE TABLE usuarios (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(120) NOT NULL UNIQUE,
senha VARCHAR(255) NOT NULL,
cargo ENUM('suporte','funcionario','gerente','admin') NOT NULL
);

/*=====================================
	TABELA DE FORNECEDORES
=====================================*/

CREATE TABLE fornecedores (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cnpj VARCHAR(20) NOT NULL UNIQUE
);

/*=====================================
 TABELA DE PRODUTOS (TIPOS DE CARNE)
=====================================*/

CREATE TABLE produtos (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(120) NOT NULL,
categoria VARCHAR(50) NOT NULL
);

/*=====================================
	TABELA DE LOTES DE CARNE
=====================================*/

CREATE TABLE lotes (
id INT AUTO_INCREMENT PRIMARY KEY,
codigo_lote VARCHAR(60) NOT NULL UNIQUE,
produto_id INT NOT NULL,
fornecedor_id INT NOT NULL,
origem VARCHAR(150) NOT NULL,
destino VARCHAR(150) NOT NULL,
data_fabricacao DATE,
data_validade DATE,
peso DECIMAL(10,2),
status ENUM('preparado','transito','entregue','armazenado') NOT NULL DEFAULT 'preparado',
CONTRAINT FOREIGN KEY (produto_id) REFERENCES produtos(id),
CONSTRAINT FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

/*=====================================
 TABELA DE TEMPERATURAS DO LOTE
=====================================*/

CREATE TABLE temperaturas (
id INT AUTO_INCREMENT PRIMARY KEY,
lote_id INT NOT NULL,
temperatura DECIMAL(5,2) NOT NULL,
data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

/*=====================================
 TABELA DE EVENTOS DO LOTE
=====================================*/

CREATE TABLE eventos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    lote_id INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    descricao TEXT,
    data_evento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (lote_id) REFERENCES lotes(id)
);

/*=====================================
	USUÁRIOS
=====================================*/
INSERT INTO usuarios (nome, email, senha, cargo)
VALUES
('Administrador', 'admin@sistema.com', '123456', 'admin'),
('Funcionário', 'func@sistema.com', '123456', 'funcionario');

/*=====================================
	FORNECEDORES
=====================================*/
INSERT INTO fornecedores (nome, cnpj)
VALUES
('Frigorífico Boi Bom', '11.111.111/0001-11'),
('Frigorífico Carne Forte', '22.222.222/0001-22');

/*=====================================
	PRODUTOS
=====================================*/
INSERT INTO produtos (nome, categoria)
VALUES
('Picanha Bovina', 'Bovino'),
('Alcatra Bovina', 'Bovino'),
('Lombo Suíno', 'Suíno');

/*=====================================
	LOTES
=====================================*/
INSERT INTO lotes (codigo_lote, produto_id, fornecedor_id, origem, destino, data_fabricacao, data_validade, peso, status)
VALUES
('L001', 1, 1, 'Frigorífico Boi Bom', 'Açougue Central', '2025-02-01', '2025-03-01', 150.00, 'preparado'),
('L002', 2, 2, 'Frigorífico Carne Forte', 'Açougue Centro', '2025-02-05', '2025-03-05', 180.00, 'transito');

/*=====================================
	TEMPERATURAS
=====================================*/
INSERT INTO temperaturas (lote_id, temperatura)
VALUES
(1, 3.8),
(1, 4.2),
(2, 3.5);

/*=====================================
	EVENTOS
=====================================*/
INSERT INTO eventos (lote_id, tipo, descricao)
VALUES
(1, 'Carregado', 'Lote carregado no caminhão'),
(1, 'Inspecionado', 'Inspeção realizada. Temperatura ok.'),
(2, 'Carregado', 'Transportadora iniciou deslocamento');

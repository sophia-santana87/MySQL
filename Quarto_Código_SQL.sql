-- =====================================================
-- CONFIGURAÇÕES INICIAIS
-- =====================================================
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE;
SET SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- =====================================================
-- SCHEMA
-- =====================================================
CREATE SCHEMA IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8mb4;
USE mydb;

-- =====================================================
-- ENDEREÇO
-- =====================================================

CREATE TABLE Endereco (
  CEP CHAR(8) NOT NULL COMMENT 'Somente números',
  Logradouro VARCHAR(100),
  Bairro VARCHAR(45) NOT NULL,
  Cidade VARCHAR(45) NOT NULL,
  UF CHAR(2) COMMENT 'Sigla do estado',
  PRIMARY KEY (CEP)
) ENGINE=InnoDB;

-- =====================================================
-- VEÍCULO
-- =====================================================

CREATE TABLE Veiculo (
  Placa CHAR(7) NOT NULL,
  Chassi CHAR(17) NOT NULL,
  Modelo VARCHAR(50) NOT NULL,
  Ano_Fabricacao INT NOT NULL,
  Ano_Modelo INT NOT NULL,
  Cor VARCHAR(45) NOT NULL,
  Tipo VARCHAR(20) NOT NULL,
  PRIMARY KEY (Placa),
  UNIQUE (Chassi)
) ENGINE=InnoDB;

-- =====================================================
-- CLIENTE
-- =====================================================

CREATE TABLE Cliente (
  CPF CHAR(11) NOT NULL COMMENT 'Somente números',
  Nome_Completo VARCHAR(255) NOT NULL,
  Numero_Endereco INT NOT NULL,
  Complemento_Endereco VARCHAR(255),
  Telefone CHAR(11) NOT NULL COMMENT 'DDD + número',
  Email VARCHAR(100) NOT NULL,
  RG VARCHAR(20) NOT NULL,
  Endereco_CEP CHAR(8) NOT NULL,
  Veiculo_Placa CHAR(7) NOT NULL,
  PRIMARY KEY (CPF),
  FOREIGN KEY (Endereco_CEP) REFERENCES Endereco(CEP),
  FOREIGN KEY (Veiculo_Placa) REFERENCES Veiculo(Placa)
) ENGINE=InnoDB;

-- =====================================================
-- EQUIPE MECÂNICA
-- =====================================================

CREATE TABLE Equipe_Mecanica (
  Codigo INT AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(45) NOT NULL,
  Especialidade VARCHAR(45) NOT NULL
) ENGINE=InnoDB;

-- =====================================================
-- STATUS
-- =====================================================

CREATE TABLE Status_ (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Nome ENUM('Pendente','Aprovado','Bloqueado','Concluido') NOT NULL
) ENGINE=InnoDB;

-- =====================================================
-- SERVIÇOS
-- =====================================================


CREATE TABLE Servico (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(45) NOT NULL,
  Descricao VARCHAR(100),
  Valor_Mao_Obra DECIMAL(10,2) NOT NULL,
  Valor_Recursos DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- =====================================================
-- PEÇAS
-- =====================================================
CREATE TABLE Peca (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(45) NOT NULL,
  Valor_Compra DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- =====================================================
-- ORDEM DE SERVIÇO
-- =====================================================

CREATE TABLE Ordem_Servico (
  Codigo INT AUTO_INCREMENT PRIMARY KEY,
  Data_Emissao DATETIME NOT NULL,
  Data_Entrega DATETIME,
  Descricao VARCHAR(100),
  Equipe_Mecanica_Codigo INT NOT NULL,
  Status_Id INT NOT NULL,
  Cliente_CPF CHAR(11) NOT NULL,
  Veiculo_Placa CHAR(7) NOT NULL,
  FOREIGN KEY (Equipe_Mecanica_Codigo) REFERENCES Equipe_Mecanica(Codigo),
  FOREIGN KEY (Status_Id) REFERENCES Status(Id),
  FOREIGN KEY (Cliente_CPF) REFERENCES Cliente(CPF),
  FOREIGN KEY (Veiculo_Placa) REFERENCES Veiculo(Placa)
) ENGINE=InnoDB;

-- =====================================================
-- SERVIÇOS DA ORDEM
-- =====================================================

CREATE TABLE Ordem_Servico_Ser (
  Codigo INT AUTO_INCREMENT PRIMARY KEY,
  Ordem_Servico_Codigo INT NOT NULL,
  Servico_Id INT NOT NULL,
  Horas_Trabalhadas INT NOT NULL,
  Valor_Total DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (Ordem_Servico_Codigo) REFERENCES Ordem_Servico(Codigo),
  FOREIGN KEY (Servico_Id) REFERENCES Servico(Id)
) ENGINE=InnoDB;

-- =====================================================
-- ITENS DE PEÇAS
-- =====================================================
CREATE TABLE Item_Peca (
  Codigo INT AUTO_INCREMENT PRIMARY KEY,
  Ordem_Servico_Codigo INT NOT NULL,
  Peca_Id INT NOT NULL,
  Quantidade INT NOT NULL,
  Preco_Revenda DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (Ordem_Servico_Codigo) REFERENCES Ordem_Servico(Codigo),
  FOREIGN KEY (Peca_Id) REFERENCES Peca(Id)
) ENGINE=InnoDB;

-- =====================================================
-- FINALIZAÇÃO
-- =====================================================
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- ADD DADOS --

INSERT INTO Endereco VALUES
('80010000','Rua XV de Novembro','Centro','Curitiba','PR'),
('01001000','Praça da Sé','Sé','São Paulo','SP');


INSERT INTO Veiculo VALUES
('ABC1D23','9BWZZZ377VT004251','Gol',2020,2021,'Prata','Carro'),
('XYZ9A88','9BFZZZ377VT009999','Onix',2019,2020,'Preto','Carro');

INSERT INTO Equipe_Mecanica (Nome, Especialidade) VALUES
('Equipe Alfa','Motor'),
('Equipe Beta','Suspensão');


INSERT INTO Status_ (Nome) VALUES
('Pendente'),
('Aprovado'),
('Concluido');

INSERT INTO Servico (Nome, Descricao, Valor_Mao_Obra, Valor_Recursos) VALUES
('Troca de óleo','Manutenção básica',80.00,30.00),
('Alinhamento','Alinhamento e balanceamento',120.00,20.00);

INSERT INTO Peca (Nome, Valor_Compra) VALUES
('Filtro de óleo',25.00),
('Óleo 5W30',40.00);


INSERT INTO Cliente 
(CPF, Nome_Completo, Numero_Endereco, Complemento_Endereco, Telefone, Email, RG, Endereco_CEP, Veiculo_Placa)
VALUES
('12345678901','João da Silva',120,'Apto 302','41999999999','joao@email.com','1234567','80010000','ABC1D23'),
('98765432100','Maria Oliveira',45,NULL,'11988887777','maria@email.com','7654321','01001000','XYZ9A88');

INSERT INTO Ordem_Servico
(Data_Emissao, Data_Entrega, Descricao, Equipe_Mecanica_Codigo, Status_Id, Cliente_CPF, Veiculo_Placa)
VALUES
('2026-02-01 09:00:00','2026-02-01 17:00:00','Revisão preventiva',1,1,'12345678901','ABC1D23'),
('2026-02-02 10:00:00',NULL,'Alinhamento',2,2,'98765432100','XYZ9A88');


INSERT INTO Ordem_Servico_Ser
(Ordem_Servico_Codigo, Servico_Id, Horas_Trabalhadas, Valor_Total)
VALUES
(1,1,1,110.00),
(2,2,2,260.00);


INSERT INTO Item_Peca
(Ordem_Servico_Codigo, Peca_Id, Quantidade, Preco_Revenda)
VALUES
(1,1,1,45.00),
(1,2,4,65.00);


SELECT 
    CPF,
    Nome_Completo,
    Email
FROM Cliente
ORDER BY Nome_Completo ASC;


SELECT 
    Codigo,
    Data_Emissao,
    Descricao,
    Cliente_CPF
FROM Ordem_Servico
ORDER BY Data_Emissao DESC;


SELECT 
    Codigo,
    Data_Emissao,
    Descricao
FROM Ordem_Servico
WHERE Status_Id = 1;


SELECT 
    oss.Ordem_Servico_Codigo,
    oss.Horas_Trabalhadas,
    s.Valor,
    (oss.Horas_Trabalhadas * s.Valor) AS Valor_Calculado
FROM Ordem_Servico_Ser oss
JOIN Servico s ON s.Id = oss.Servico_Id;


SELECT 
    Nome,
    Preco
FROM Peca
ORDER BY Preco DESC;


SELECT 
    ip.Ordem_Servico_Codigo,
    SUM(ip.Quantidade) AS Total_Pecas
FROM Item_Peca ip
GROUP BY ip.Ordem_Servico_Codigo
HAVING SUM(ip.Quantidade) > 1;



SELECT 
    os.Codigo AS Ordem_Servico,
    c.Nome_Completo AS Cliente,
    v.Placa,
    os.Data_Emissao,
    os.Descricao
FROM Ordem_Servico os
JOIN Cliente c ON c.CPF = os.Cliente_CPF
JOIN Veiculo v ON v.Placa = os.Veiculo_Placa
ORDER BY os.Data_Emissao DESC;






CREATE TABLE dim_cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(50)
);

CREATE TABLE dim_produto (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    preco NUMERIC(10,2)
);

CREATE TABLE dim_tempo (
    id_data INT PRIMARY KEY,
    data DATE,
    mes INT,
    ano INT
);

CREATE TABLE dim_vendedor (
    id_vendedor INT PRIMARY KEY,
    nome VARCHAR(100),
    regiao VARCHAR(50)
);

CREATE TABLE fato_vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT REFERENCES dim_cliente(id_cliente),
    id_produto INT REFERENCES dim_produto(id_produto),
    id_tempo INT REFERENCES dim_tempo(id_data),
    id_vendedor INT REFERENCES dim_vendedor(id_vendedor),
    quantidade INT,
    valor_total NUMERIC(10,2)
);

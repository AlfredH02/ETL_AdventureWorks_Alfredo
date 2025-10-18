import pandas as pd
import psycopg2

# Conexão com o PostgreSQL
conn = psycopg2.connect(
    host='localhost',
    dbname='dw_adventureworks',
    user='postgres',
    password='1234'
)
cur = conn.cursor()

# Carregar CSVs simulando dados do AdventureWorks
clientes = pd.read_csv('clientes.csv')
produtos = pd.read_csv('produtos.csv')
vendas = pd.read_csv('vendas.csv')
vendedores = pd.read_csv('vendedores.csv')
datas = pd.read_csv('datas.csv')

# Inserir dados nas tabelas do Data Warehouse
for _, row in clientes.iterrows():
    cur.execute(
        "INSERT INTO dim_cliente (id_cliente, nome, cidade, estado) VALUES (%s, %s, %s, %s)",
        (row['id_cliente'], row['nome'], row['cidade'], row['estado'])
    )

for _, row in produtos.iterrows():
    cur.execute(
        "INSERT INTO dim_produto (id_produto, nome, categoria, preco) VALUES (%s, %s, %s, %s)",
        (row['id_produto'], row['nome'], row['categoria'], row['preco'])
    )

for _, row in datas.iterrows():
    cur.execute(
        "INSERT INTO dim_tempo (id_data, data, mes, ano) VALUES (%s, %s, %s, %s)",
        (row['id_data'], row['data'], row['mes'], row['ano'])
    )

for _, row in vendedores.iterrows():
    cur.execute(
        "INSERT INTO dim_vendedor (id_vendedor, nome, regiao) VALUES (%s, %s, %s)",
        (row['id_vendedor'], row['nome'], row['regiao'])
    )

for _, row in vendas.iterrows():
    cur.execute(
        "INSERT INTO fato_vendas (id_venda, id_cliente, id_produto, id_tempo, id_vendedor, quantidade, valor_total) VALUES (%s, %s, %s, %s, %s, %s, %s)",
        (row['id_venda'], row['id_cliente'], row['id_produto'], row['id_tempo'], row['id_vendedor'], row['quantidade'], row['valor_total'])
    )

conn.commit()
cur.close()
conn.close()
print('ETL concluída com sucesso!')

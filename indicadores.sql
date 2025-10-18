-- 1. Total de vendas mensais
SELECT t.mes, SUM(f.valor_total) AS total_vendas FROM fato_vendas f
JOIN dim_tempo t ON f.id_tempo = t.id_data
GROUP BY t.mes ORDER BY t.mes;

-- 2. Faturamento anual
SELECT t.ano, SUM(f.valor_total) AS faturamento FROM fato_vendas f
JOIN dim_tempo t ON f.id_tempo = t.id_data
GROUP BY t.ano;

-- 3. Ticket médio por cliente
SELECT c.nome, AVG(f.valor_total) AS ticket_medio FROM fato_vendas f
JOIN dim_cliente c ON f.id_cliente = c.id_cliente
GROUP BY c.nome;

-- 4. Pedidos por região
SELECT v.regiao, COUNT(f.id_venda) AS total_pedidos FROM fato_vendas f
JOIN dim_vendedor v ON f.id_vendedor = v.id_vendedor
GROUP BY v.regiao;

-- 5. Produtos mais vendidos
SELECT p.nome, SUM(f.quantidade) AS total_vendido FROM fato_vendas f
JOIN dim_produto p ON f.id_produto = p.id_produto
GROUP BY p.nome ORDER BY total_vendido DESC LIMIT 10;

-- 6. Margem de lucro média (exemplo com preço fixo)
SELECT p.categoria, AVG(p.preco*0.2) AS margem_media FROM dim_produto p GROUP BY p.categoria;

-- 7. Crescimento percentual anual
SELECT t.ano, (SUM(f.valor_total) - LAG(SUM(f.valor_total)) OVER (ORDER BY t.ano)) / LAG(SUM(f.valor_total)) OVER (ORDER BY t.ano)*100 AS crescimento
FROM fato_vendas f JOIN dim_tempo t ON f.id_tempo = t.id_data GROUP BY t.ano;

-- 8. Vendas por categoria
SELECT p.categoria, SUM(f.valor_total) AS total FROM fato_vendas f JOIN dim_produto p ON f.id_produto = p.id_produto GROUP BY p.categoria;

-- 9. Clientes novos por ano
SELECT t.ano, COUNT(DISTINCT f.id_cliente) AS clientes_novos FROM fato_vendas f JOIN dim_tempo t ON f.id_tempo = t.id_data GROUP BY t.ano;

-- 10. Vendas médias por vendedor
SELECT v.nome, AVG(f.valor_total) AS media_vendas FROM fato_vendas f JOIN dim_vendedor v ON f.id_vendedor = v.id_vendedor GROUP BY v.nome;

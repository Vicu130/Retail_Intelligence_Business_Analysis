Use retail_db;

SELECT p.product, p.category, 
       ROUND(SUM(s.revenue),2) as total_revenue, 
       ROUND(SUM(s.profit),2) as total_profit,
       ROUND((SUM(s.profit) / SUM(s.revenue))*100, 2) as profit_margin_pct,
       Round(Avg(s.discount), 2) as avg_discount
From sales s 
Join products p on s.product_id = p.product_id
Group by p.product, p.category
Order by profit_margin_pct DESC;

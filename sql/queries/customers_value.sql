USE retail_db;

SELECT s.customer_id,
       Count(*) as total_orders,
       ROUND(Sum(s.revenue), 2) as total_revenue,
       ROUND(Sum(s.profit), 2) as total_profit,
       ROUND(Avg(s.revenue), 2) as average_order_value,
       ROUND((SUM(s.profit) / SUM(s.revenue))*100, 2) as profit_margin_pct
From sales s 
Join customers c on s.customer_id = c.customer_id
Group by s.customer_id
ORDER BY total_revenue DESC
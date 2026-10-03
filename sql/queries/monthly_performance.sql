Use retail_db;

SELECT DATE_FORMAT(date, '%Y-%m') AS month, 
       COUNT(sale_id) as total_orders, 
       SUM(quantity) as total_units_sold,
       ROUND(SUM(revenue), 2) as total_revenue, 
       ROUND(SUM(cost_total), 2) as total_cost, 
       ROUND(SUM(profit), 2) as total_profit,
       ROUND((SUM(profit) / SUM(revenue))*100, 2) as profit_margin_pct
From sales
Group by DATE_FORMAT(date, '%Y-%m')
Order by month asc;
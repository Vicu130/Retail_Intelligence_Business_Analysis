Use retail_db;


WITH monthly_sales as (Select store_id,
                              product_id,
                              DATE_FORMAT(date, '%Y-%m') as month,
                              SUM(quantity) as units_sold
                       From sales
                       Group by Date_Format(date, '%Y-%m'),
                                store_id,
                                product_id),
    avg_units_sold as (Select store_id, product_id, AVG(units_sold) as avg_monthly_units_sold
                       From monthly_sales
                       Group by store_id, product_id),
    months_of_stock as (Select i.date, i.store_id, i.product_id, i.stock_units, i.reorder_level,
                               ROUND(a.avg_monthly_units_sold, 2) as avg_monthly_units_sold,
                               ROUND(i.stock_units / NULLIF(a.avg_monthly_units_sold, 0), 2)  as months_of_stock
                        From inventory i
                        Join avg_units_sold a on i.store_id = a.store_id
                        and i.product_id = a.product_id
                        )

SELECT m.date, m.store_id, m.product_id, m.stock_units, m.reorder_level, m.avg_monthly_units_sold, m.months_of_stock,
       CASE WHEN m.stock_units <= m.reorder_level THEN 'Stock Risk'
            WHEN m.months_of_stock >= 6 THEN 'Excess Stock'
            ELSE "Normal" End as Status
From months_of_stock m;


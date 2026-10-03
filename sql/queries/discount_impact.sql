USE retail_db;

SELECT Case WHEN discount = 0 THEN "0%"
            WHEN discount > 0 AND discount <= 0.10 THEN "1% - 10%"
            WHEN discount > 0.10 AND discount <= 0.20 THEN "10% - 20%"
            WHEN discount > 0.20 AND discount <= 0.30 THEN "20% - 30%"
            WHEN discount > 0.30 AND discount <= 0.40 THEN "30% - 40%"
            WHEN discount > 0.40 AND discount <= 0.50 THEN "40% - 50%" END as discount_tier,
            ROUND(Sum(revenue)) as total_revenue,
            ROUND(Sum(profit)) as total_profit, 
            ROUND((SUM(profit) / SUM(revenue))*100,2) as profit_margin_pct
From sales
Group by discount_tier
ORDER BY profit_margin_pct DESC
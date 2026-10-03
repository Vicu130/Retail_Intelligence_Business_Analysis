USE retail_db;

WITH monthly as (Select DATE_FORMAT(date, '%Y-%m') as month,
                        Round(SUM(revenue), 2) as total_revenue,
                        Round(SUM(profit), 2) as total_profit
                 From sales
                 Group By DATE_FORMAT(date, '%Y-%m')),
     
     with_prev_month as (SELECT month, 
                                total_revenue, 
                                total_profit,
                                LAG(total_revenue) OVER (ORDER BY month) AS prev_revenue,
                                LAG(total_profit)  OVER (ORDER BY month) AS prev_profit
                         From monthly)

SELECT month, total_revenue, total_profit
FROM with_prev_month
WHERE total_revenue > prev_revenue
  AND total_profit  < prev_profit
ORDER BY month; 
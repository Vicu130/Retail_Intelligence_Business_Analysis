USE retail_db;

SELECT st.store_id,
       st.city,
       st.region,
       ROUND(Sum(s.revenue),2) as total_revenue,
       ROUND(Sum(s.profit),2) as total_profit,
       ROUND((Sum(s.profit) / Sum(s.revenue))*100,2) as profit_margin_pct,
       Round(Avg(s.discount), 2) as avg_discount
From sales s
Join stores st on s.store_id = st.store_id
Group by st.store_id, st.city, st.region
ORDER BY profit_margin_pct ASC;
-- Order volume by hour of day (for operational planning)
SELECT EXTRACT(HOUR FROM created_at) AS hour_of_day,
       COUNT(DISTINCT order_id) AS orders
FROM fact_sales GROUP BY 1 ORDER BY 1;

-- Weekly flash
SELECT DATE_TRUNC('week', order_date) AS week, SUM(revenue) AS revenue
FROM fact_sales WHERE order_date >= CURRENT_DATE - 90 GROUP BY 1 ORDER BY 1;

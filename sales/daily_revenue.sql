-- Daily revenue and order count
SELECT order_date::date AS day, SUM(revenue) AS revenue, COUNT(DISTINCT order_id) AS orders
FROM fact_sales GROUP BY 1 ORDER BY 1;

CREATE OR REPLACE VIEW vw_daily_flash AS
SELECT order_date::date AS day, region,
       SUM(revenue) AS revenue, COUNT(DISTINCT order_id) AS orders
FROM fact_sales GROUP BY 1, 2;

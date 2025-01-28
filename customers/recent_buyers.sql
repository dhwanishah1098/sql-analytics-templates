-- Customers who purchased in last 30 days
SELECT DISTINCT customer_id FROM fact_sales
WHERE order_date >= CURRENT_DATE - 30;

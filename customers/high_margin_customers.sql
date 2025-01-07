-- Customers who consistently buy high-margin products
SELECT customer_id, AVG(margin_pct) AS avg_margin
FROM fact_sales GROUP BY 1 HAVING AVG(margin_pct) >= 0.4 ORDER BY 2 DESC;

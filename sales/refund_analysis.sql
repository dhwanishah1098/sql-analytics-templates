-- Refund amount and rate by product category
SELECT p.category,
       COUNT(r.refund_id) AS refunds,
       SUM(r.refund_amount) AS total_refunded,
       ROUND(100.0 * SUM(r.refund_amount) / NULLIF(SUM(s.revenue), 0), 2) AS refund_rate_pct
FROM fact_sales s LEFT JOIN refunds r USING (order_id)
JOIN dim_products p USING (product_id)
GROUP BY 1 ORDER BY 4 DESC;

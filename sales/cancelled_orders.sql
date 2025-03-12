-- Cancelled order rate by month and region
SELECT DATE_TRUNC('month', order_date)::date AS month, region,
       COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled,
       COUNT(*) AS total,
       ROUND(100.0 * COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) / COUNT(*), 2) AS cancel_rate
FROM fact_sales GROUP BY 1, 2 ORDER BY 1, cancel_rate DESC;

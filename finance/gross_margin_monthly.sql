-- Monthly gross margin percentage
SELECT DATE_TRUNC('month', order_date)::date AS month,
       ROUND(100.0 * SUM(revenue - cost) / NULLIF(SUM(revenue), 0), 2) AS gm_pct
FROM fact_sales GROUP BY 1 ORDER BY 1;

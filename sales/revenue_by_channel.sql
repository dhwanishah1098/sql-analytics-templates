-- Revenue by sales channel
SELECT channel, SUM(revenue) AS total
FROM fact_sales GROUP BY 1 ORDER BY 2 DESC;

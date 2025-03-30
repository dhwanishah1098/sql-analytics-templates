-- Customers who purchased across more than one channel
SELECT customer_id, COUNT(DISTINCT channel) AS channel_count,
       ARRAY_AGG(DISTINCT channel) AS channels
FROM fact_sales GROUP BY 1 HAVING COUNT(DISTINCT channel) > 1;

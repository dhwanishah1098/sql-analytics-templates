-- Monthly revenue trend by customer segment
SELECT DATE_TRUNC('month', order_date)::date AS month, c.segment,
       SUM(revenue) AS revenue
FROM fact_sales s JOIN dim_customers c USING (customer_id)
GROUP BY 1, 2 ORDER BY 1, 3 DESC;

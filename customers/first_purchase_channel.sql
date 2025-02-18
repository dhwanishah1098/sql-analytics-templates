-- First purchase channel by customer
SELECT customer_id, acquisition_channel,
       MIN(order_date) AS first_order
FROM fact_sales JOIN dim_customers USING (customer_id)
GROUP BY 1, 2 ORDER BY 3;

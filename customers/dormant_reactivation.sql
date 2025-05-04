-- Dormant customers (no purchase 60-120 days) worth reactivating
SELECT s.customer_id, c.email, SUM(s.revenue) AS lifetime_revenue,
       MAX(s.order_date) AS last_order
FROM fact_sales s JOIN dim_customers c USING (customer_id)
GROUP BY 1, 2
HAVING MAX(s.order_date) BETWEEN CURRENT_DATE - 120 AND CURRENT_DATE - 60
   AND SUM(s.revenue) >= 500;

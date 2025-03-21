-- New vs Returning Customer Revenue Split by Month
WITH first_orders AS (
    SELECT customer_id, MIN(DATE_TRUNC('month', order_date)) AS first_month
    FROM fact_sales GROUP BY 1
)
SELECT
    DATE_TRUNC('month', s.order_date)::date AS month,
    SUM(CASE WHEN DATE_TRUNC('month', s.order_date) = f.first_month THEN s.revenue ELSE 0 END) AS new_revenue,
    SUM(CASE WHEN DATE_TRUNC('month', s.order_date) > f.first_month  THEN s.revenue ELSE 0 END) AS returning_revenue,
    COUNT(DISTINCT CASE WHEN DATE_TRUNC('month', s.order_date) = f.first_month THEN s.customer_id END) AS new_customers,
    COUNT(DISTINCT CASE WHEN DATE_TRUNC('month', s.order_date) > f.first_month  THEN s.customer_id END) AS returning_customers
FROM fact_sales s JOIN first_orders f USING (customer_id)
GROUP BY 1 ORDER BY 1;

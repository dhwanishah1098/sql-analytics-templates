-- Revenue by customer segment and region
SELECT c.segment, c.region, SUM(o.revenue) AS revenue,
    COUNT(DISTINCT o.customer_id) AS customers,
    AVG(o.revenue) AS avg_order_value
FROM fact_orders o JOIN dim_customers c USING(customer_id)
WHERE o.order_date >= DATE_TRUNC('year', CURRENT_DATE)
GROUP BY 1,2 ORDER BY 3 DESC;

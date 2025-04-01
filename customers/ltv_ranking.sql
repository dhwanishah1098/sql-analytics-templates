-- Customer Lifetime Value Ranking
SELECT
    customer_id,
    customer_name,
    segment,
    MIN(order_date)                             AS first_order,
    MAX(order_date)                             AS last_order,
    COUNT(DISTINCT order_id)                    AS total_orders,
    SUM(revenue)                                AS lifetime_revenue,
    AVG(revenue)                                AS avg_order_value,
    SUM(revenue) / NULLIF(COUNT(DISTINCT
        DATE_TRUNC('month', order_date)), 0)    AS monthly_revenue_rate,
    NTILE(10) OVER (ORDER BY SUM(revenue) DESC) AS decile
FROM fact_sales s
JOIN dim_customers c USING (customer_id)
GROUP BY 1, 2, 3
ORDER BY lifetime_revenue DESC;

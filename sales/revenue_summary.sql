-- Monthly Revenue Summary with MoM and YoY Growth
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(revenue)                           AS revenue,
        COUNT(DISTINCT order_id)               AS orders,
        COUNT(DISTINCT customer_id)            AS customers
    FROM fact_sales
    WHERE order_date >= DATE_TRUNC('year', CURRENT_DATE - INTERVAL '2 years')
    GROUP BY 1
)
SELECT
    month,
    revenue,
    orders,
    customers,
    revenue / NULLIF(orders, 0)                                           AS avg_order_value,
    revenue - LAG(revenue, 1) OVER (ORDER BY month)                       AS mom_delta,
    ROUND(100.0 * (revenue - LAG(revenue, 1) OVER (ORDER BY month))
        / NULLIF(LAG(revenue, 1) OVER (ORDER BY month), 0), 2)            AS mom_growth_pct,
    ROUND(100.0 * (revenue - LAG(revenue, 12) OVER (ORDER BY month))
        / NULLIF(LAG(revenue, 12) OVER (ORDER BY month), 0), 2)           AS yoy_growth_pct
FROM monthly_revenue
ORDER BY month;

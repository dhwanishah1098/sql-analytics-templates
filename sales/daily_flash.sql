-- Daily flash revenue report
SELECT
    order_date,
    COUNT(DISTINCT order_id)   AS orders,
    SUM(revenue)               AS daily_revenue,
    AVG(revenue)               AS avg_order_value,
    SUM(units_sold)            AS units
FROM fact_sales
WHERE order_date = CURRENT_DATE - INTERVAL '1 day'
GROUP BY 1;

-- Daily Flash Report: Today vs Yesterday vs Same Day Last Week
SELECT
    'Today'                                     AS period,
    SUM(revenue)                                AS revenue,
    COUNT(DISTINCT order_id)                    AS orders,
    COUNT(DISTINCT customer_id)                 AS customers
FROM fact_sales WHERE order_date = CURRENT_DATE
UNION ALL
SELECT 'Yesterday', SUM(revenue), COUNT(DISTINCT order_id), COUNT(DISTINCT customer_id)
FROM fact_sales WHERE order_date = CURRENT_DATE - 1
UNION ALL
SELECT 'Same Day Last Week', SUM(revenue), COUNT(DISTINCT order_id), COUNT(DISTINCT customer_id)
FROM fact_sales WHERE order_date = CURRENT_DATE - 7;

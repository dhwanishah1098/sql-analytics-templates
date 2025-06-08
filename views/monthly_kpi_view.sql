-- Reusable Monthly KPI View
CREATE OR REPLACE VIEW vw_monthly_kpi AS
SELECT
    DATE_TRUNC('month', order_date)::date  AS month,
    region,
    product_category,
    COUNT(DISTINCT order_id)               AS orders,
    COUNT(DISTINCT customer_id)            AS customers,
    SUM(units_sold)                        AS units,
    SUM(revenue)                           AS revenue,
    SUM(revenue - cost)                    AS gross_profit,
    ROUND(AVG(margin_pct) * 100, 2)        AS avg_margin_pct,
    SUM(revenue) / NULLIF(COUNT(DISTINCT order_id), 0) AS aov
FROM fact_sales
JOIN dim_products USING (product_id)
GROUP BY 1, 2, 3;

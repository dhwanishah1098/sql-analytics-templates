-- Product Performance Summary View
CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    SUM(s.units_sold)                           AS total_units,
    SUM(s.revenue)                              AS total_revenue,
    SUM(s.revenue - s.units_sold * s.unit_cost) AS total_gross_profit,
    ROUND(100.0 * SUM(s.revenue - s.units_sold * s.unit_cost) / NULLIF(SUM(s.revenue), 0), 2) AS gp_pct,
    COUNT(DISTINCT s.order_id)                  AS order_count,
    COUNT(DISTINCT s.customer_id)               AS unique_customers,
    MAX(s.order_date)                           AS last_sale_date
FROM dim_products p
LEFT JOIN fact_sales s USING (product_id)
GROUP BY 1, 2, 3, 4;

-- Sell-Through Rate by Product and Month
SELECT
    p.product_name,
    p.category,
    DATE_TRUNC('month', s.order_date)::date AS month,
    SUM(s.units_sold)                        AS units_sold,
    i.beginning_inventory,
    ROUND(100.0 * SUM(s.units_sold) / NULLIF(i.beginning_inventory, 0), 2) AS sell_through_pct,
    i.beginning_inventory - SUM(s.units_sold) AS ending_inventory
FROM fact_sales s
JOIN dim_products p USING (product_id)
JOIN monthly_inventory i USING (product_id)
WHERE i.month = DATE_TRUNC('month', s.order_date)::date
GROUP BY 1, 2, 3, i.beginning_inventory
ORDER BY sell_through_pct DESC;

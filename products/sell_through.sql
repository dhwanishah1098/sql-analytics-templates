-- Sell-through rate by product category
SELECT
    p.category,
    SUM(f.units_sold)                                     AS units_sold,
    SUM(i.opening_stock)                                  AS opening_stock,
    ROUND(SUM(f.units_sold)::numeric
          / NULLIF(SUM(i.opening_stock), 0) * 100, 2)   AS sell_through_pct,
    SUM(i.closing_stock)                                  AS remaining_stock
FROM fact_sales f
JOIN dim_products p   ON f.product_id  = p.product_id
JOIN fact_inventory i ON f.product_id  = i.product_id
    AND f.sale_date = i.inventory_date
WHERE f.sale_date >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY 1
ORDER BY sell_through_pct DESC;

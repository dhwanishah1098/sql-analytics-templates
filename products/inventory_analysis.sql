-- Inventory Health & Turnover Analysis
SELECT
    p.product_id,
    p.product_name,
    p.category,
    i.stock_quantity,
    i.reorder_point,
    i.unit_cost,
    i.stock_quantity * i.unit_cost                          AS inventory_value,
    COALESCE(s.avg_daily_units, 0)                          AS avg_daily_units_sold,
    CASE
        WHEN COALESCE(s.avg_daily_units, 0) = 0 THEN NULL
        ELSE ROUND(i.stock_quantity / s.avg_daily_units, 1)
    END                                                     AS days_of_stock,
    CASE
        WHEN i.stock_quantity <= i.reorder_point THEN 'Reorder Now'
        WHEN i.stock_quantity <= i.reorder_point * 1.2 THEN 'Low Stock'
        WHEN COALESCE(s.avg_daily_units, 0) = 0 THEN 'No Movement'
        ELSE 'Healthy'
    END                                                     AS stock_status
FROM dim_products p
JOIN inventory i USING (product_id)
LEFT JOIN (
    SELECT product_id, SUM(units_sold) / 30.0 AS avg_daily_units
    FROM fact_sales
    WHERE order_date >= CURRENT_DATE - INTERVAL '30 days'
    GROUP BY 1
) s USING (product_id)
ORDER BY inventory_value DESC;

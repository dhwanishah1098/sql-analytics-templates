-- Inventory health dashboard query
SELECT product_id, product_name, category,
    closing_stock, avg_daily_sales,
    ROUND(closing_stock / NULLIF(avg_daily_sales,0), 0) AS days_cover,
    CASE WHEN closing_stock / NULLIF(avg_daily_sales,0) < 7   THEN 'Critical'
         WHEN closing_stock / NULLIF(avg_daily_sales,0) < 14  THEN 'Low'
         WHEN closing_stock / NULLIF(avg_daily_sales,0) > 60  THEN 'Excess'
         ELSE 'Healthy' END AS health_status
FROM fact_inventory JOIN dim_products USING(product_id)
WHERE snapshot_date = CURRENT_DATE;

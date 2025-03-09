-- Products at stockout risk (< 7 days stock)
SELECT product_id, product_name, closing_stock,
    ROUND(closing_stock / NULLIF(avg_daily_sales, 0), 1) AS days_of_stock
FROM fact_inventory fi JOIN dim_products p USING(product_id)
HAVING days_of_stock < 7
ORDER BY days_of_stock;

-- Products in catalogue with zero sales in last 90 days
SELECT p.product_id, p.product_name, p.category
FROM dim_products p
LEFT JOIN (SELECT DISTINCT product_id FROM fact_sales
           WHERE order_date >= CURRENT_DATE - 90) s USING (product_id)
WHERE s.product_id IS NULL;

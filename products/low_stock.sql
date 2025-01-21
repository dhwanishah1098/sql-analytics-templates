-- Products with less than 7 days of stock remaining
SELECT product_id, product_name, quantity_on_hand, avg_daily_sales,
       ROUND(quantity_on_hand / NULLIF(avg_daily_sales, 0), 1) AS days_remaining
FROM vw_inventory_health WHERE days_remaining < 7;

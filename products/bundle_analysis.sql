-- Products frequently ordered together (simplified)
SELECT a.product_id AS prod_a, b.product_id AS prod_b,
       COUNT(*) AS co_orders
FROM fact_sales a JOIN fact_sales b
  ON a.order_id = b.order_id AND a.product_id < b.product_id
GROUP BY 1, 2 HAVING COUNT(*) >= 5
ORDER BY 3 DESC;

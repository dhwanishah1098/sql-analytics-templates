-- Revenue mix by product category
SELECT category,
       SUM(revenue) AS revenue,
       ROUND(100.0 * SUM(revenue) / SUM(SUM(revenue)) OVER (), 2) AS pct_of_total
FROM fact_sales JOIN dim_products USING (product_id)
GROUP BY 1 ORDER BY 2 DESC;

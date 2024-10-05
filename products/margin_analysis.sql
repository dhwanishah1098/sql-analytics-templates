-- Product margin waterfall
SELECT product_id, product_name,
    revenue, cogs, revenue - cogs AS gross_profit,
    ROUND((revenue - cogs) / NULLIF(revenue,0) * 100, 2) AS margin_pct
FROM fact_sales f JOIN dim_products p USING(product_id)
WHERE sale_date >= DATE_TRUNC('year', CURRENT_DATE)
GROUP BY 1,2,3,4;

-- Top and Bottom Product Movers: Units and Revenue Delta (WoW)
WITH current_week AS (
    SELECT product_id, SUM(units_sold) AS units, SUM(revenue) AS revenue
    FROM fact_sales WHERE order_date >= CURRENT_DATE - 7 GROUP BY 1
),
prior_week AS (
    SELECT product_id, SUM(units_sold) AS units, SUM(revenue) AS revenue
    FROM fact_sales WHERE order_date BETWEEN CURRENT_DATE - 14 AND CURRENT_DATE - 8 GROUP BY 1
)
SELECT
    p.product_name,
    c.units AS units_this_week, w.units AS units_prior_week,
    c.units - w.units AS unit_delta,
    ROUND(100.0 * (c.revenue - w.revenue) / NULLIF(w.revenue, 0), 2) AS revenue_wow_pct
FROM current_week c
JOIN prior_week w USING (product_id)
JOIN dim_products p USING (product_id)
ORDER BY ABS(revenue_wow_pct) DESC
LIMIT 20;

-- Product Margin Waterfall: Revenue → COGS → Gross Profit → Net Margin
SELECT
    p.product_name,
    p.category,
    SUM(s.units_sold)                                       AS units,
    SUM(s.revenue)                                          AS gross_revenue,
    SUM(s.units_sold * s.unit_cost)                         AS total_cogs,
    SUM(s.revenue) - SUM(s.units_sold * s.unit_cost)        AS gross_profit,
    ROUND(100.0 * (SUM(s.revenue) - SUM(s.units_sold * s.unit_cost))
          / NULLIF(SUM(s.revenue), 0), 2)                   AS gross_margin_pct,
    SUM(s.revenue) / NULLIF(SUM(s.units_sold), 0)           AS avg_selling_price,
    SUM(s.units_sold * s.unit_cost) / NULLIF(SUM(s.units_sold), 0) AS avg_unit_cost
FROM fact_sales s
JOIN dim_products p USING (product_id)
GROUP BY 1, 2
ORDER BY gross_profit DESC;

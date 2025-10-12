-- Product performance summary view
CREATE OR REPLACE VIEW v_product_performance AS
SELECT p.product_id, p.product_name, p.category,
    SUM(f.revenue) AS ytd_revenue,
    SUM(f.units_sold) AS ytd_units,
    AVG(f.revenue / NULLIF(f.units_sold,0)) AS avg_unit_price,
    SUM(f.revenue) - SUM(f.cogs) AS gross_profit
FROM fact_sales f JOIN dim_products p USING(product_id)
WHERE f.sale_date >= DATE_TRUNC('year', CURRENT_DATE)
GROUP BY 1,2,3;

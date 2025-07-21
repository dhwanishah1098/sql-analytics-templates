-- ABC-XYZ matrix classification
WITH variability AS (
    SELECT product_id,
        STDDEV(monthly_revenue) / NULLIF(AVG(monthly_revenue), 0) AS cv
    FROM fact_monthly_product_revenue GROUP BY 1
)
SELECT p.product_id, p.abc_class,
    CASE WHEN v.cv < 0.5 THEN 'X' WHEN v.cv < 1.0 THEN 'Y' ELSE 'Z' END AS xyz_class
FROM dim_products p JOIN variability v USING(product_id);

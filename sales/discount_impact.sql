-- Discount Impact Analysis: Revenue vs Margin Trade-off
SELECT
    discount_band,
    COUNT(DISTINCT order_id)                    AS orders,
    SUM(units_sold)                             AS units,
    SUM(list_price * units_sold)                AS list_revenue,
    SUM(revenue)                                AS actual_revenue,
    SUM(list_price * units_sold) - SUM(revenue) AS discount_amount,
    ROUND(AVG(discount_pct), 2)                 AS avg_discount_pct,
    ROUND(AVG(margin_pct), 2)                   AS avg_margin_pct,
    ROUND(AVG(margin_pct) - AVG(list_margin_pct), 2) AS margin_impact_pct
FROM (
    SELECT *,
        CASE WHEN discount_pct = 0 THEN 'No Discount'
             WHEN discount_pct <= 10 THEN '1-10%'
             WHEN discount_pct <= 20 THEN '11-20%'
             ELSE '21%+' END AS discount_band
    FROM fact_sales
) t
GROUP BY 1
ORDER BY avg_discount_pct;

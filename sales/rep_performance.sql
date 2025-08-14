-- Sales rep performance dashboard
SELECT rep_id, rep_name,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(revenue) / NULLIF(SUM(target), 0) * 100 AS attainment_pct
FROM fact_sales f JOIN dim_sales_reps r USING(rep_id)
WHERE order_date >= DATE_TRUNC('quarter', CURRENT_DATE)
GROUP BY 1,2 ORDER BY attainment_pct DESC;

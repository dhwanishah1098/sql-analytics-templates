-- Sales quota attainment summary
SELECT rep_id, rep_name, quota, actual_revenue,
    ROUND(actual_revenue / NULLIF(quota,0) * 100, 1) AS attainment_pct,
    CASE WHEN actual_revenue >= quota THEN 'On Track' ELSE 'Behind' END AS status
FROM fact_quota q JOIN fact_sales_summary s USING(rep_id)
WHERE q.quarter = DATE_TRUNC('quarter', CURRENT_DATE)
ORDER BY attainment_pct DESC;

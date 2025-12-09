-- Sales Rep Target Attainment
SELECT
    r.rep_id,
    r.rep_name,
    r.team,
    t.monthly_target,
    COALESCE(s.actual_revenue, 0)                           AS actual_revenue,
    ROUND(100.0 * COALESCE(s.actual_revenue, 0) / NULLIF(t.monthly_target, 0), 2) AS attainment_pct,
    COALESCE(s.actual_revenue, 0) - t.monthly_target        AS gap,
    RANK() OVER (PARTITION BY r.team ORDER BY COALESCE(s.actual_revenue, 0) DESC) AS rank_in_team
FROM dim_reps r
JOIN rep_targets t USING (rep_id)
LEFT JOIN (
    SELECT rep_id, SUM(revenue) AS actual_revenue
    FROM fact_sales
    WHERE DATE_TRUNC('month', order_date) = DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY 1
) s USING (rep_id)
ORDER BY attainment_pct DESC;

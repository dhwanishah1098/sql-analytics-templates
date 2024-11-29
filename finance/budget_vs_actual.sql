-- Budget vs Actuals variance report
SELECT
    d.department_name,
    b.budget_amount,
    COALESCE(SUM(a.actual_amount), 0)             AS actual_amount,
    b.budget_amount - COALESCE(SUM(a.actual_amount), 0) AS variance,
    ROUND(
        (b.budget_amount - COALESCE(SUM(a.actual_amount), 0))
        / NULLIF(b.budget_amount, 0) * 100, 2
    )                                             AS variance_pct
FROM dim_departments d
LEFT JOIN fact_budget b   ON d.department_id = b.department_id
LEFT JOIN fact_actuals a  ON d.department_id = a.department_id
    AND DATE_TRUNC('month', a.expense_date) = b.budget_month
GROUP BY 1, 2, b.budget_month
ORDER BY variance_pct;

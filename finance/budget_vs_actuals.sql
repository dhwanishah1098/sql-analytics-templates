-- Budget vs Actuals by Department and Month
SELECT
    b.department,
    b.month,
    b.budget_amount,
    COALESCE(a.actual_amount, 0)                            AS actual_amount,
    COALESCE(a.actual_amount, 0) - b.budget_amount          AS variance,
    ROUND(100.0 * (COALESCE(a.actual_amount, 0) - b.budget_amount)
        / NULLIF(b.budget_amount, 0), 2)                    AS variance_pct,
    CASE
        WHEN COALESCE(a.actual_amount, 0) > b.budget_amount * 1.1 THEN 'Over Budget'
        WHEN COALESCE(a.actual_amount, 0) < b.budget_amount * 0.9 THEN 'Under Budget'
        ELSE 'On Track'
    END                                                     AS status
FROM budget b
LEFT JOIN actuals a USING (department, month)
WHERE b.month >= DATE_TRUNC('year', CURRENT_DATE)
ORDER BY b.month, b.department;

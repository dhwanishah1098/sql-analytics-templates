-- Operating Expense by Category with Budget Comparison
SELECT
    gl.category,
    gl.sub_category,
    b.annual_budget,
    SUM(gl.amount)                                              AS ytd_actual,
    b.annual_budget - SUM(gl.amount)                           AS remaining_budget,
    ROUND(100.0 * SUM(gl.amount) / NULLIF(b.annual_budget, 0), 2) AS budget_utilisation_pct,
    ROUND(SUM(gl.amount) / DATE_PART('month', CURRENT_DATE) * 12, 2) AS annualised_run_rate
FROM general_ledger gl
JOIN annual_budget b USING (category, sub_category)
WHERE gl.transaction_date >= DATE_TRUNC('year', CURRENT_DATE)
GROUP BY 1, 2, b.annual_budget
ORDER BY budget_utilisation_pct DESC;

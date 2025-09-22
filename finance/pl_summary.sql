-- P&L summary by department
SELECT department, account_type,
    SUM(CASE WHEN period = 'current' THEN amount END) AS current_period,
    SUM(CASE WHEN period = 'prior'   THEN amount END) AS prior_period,
    SUM(CASE WHEN period = 'current' THEN amount END) -
    SUM(CASE WHEN period = 'prior'   THEN amount END) AS variance
FROM fact_pl GROUP BY 1,2 ORDER BY 1,2;

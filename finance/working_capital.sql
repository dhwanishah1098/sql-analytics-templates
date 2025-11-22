-- Working Capital Components by Month
SELECT
    DATE_TRUNC('month', date)::date AS month,
    SUM(CASE WHEN account_type = 'Current Asset'     THEN balance ELSE 0 END) AS current_assets,
    SUM(CASE WHEN account_type = 'Current Liability'  THEN balance ELSE 0 END) AS current_liabilities,
    SUM(CASE WHEN account_type = 'Current Asset'     THEN balance ELSE 0 END) -
    SUM(CASE WHEN account_type = 'Current Liability'  THEN balance ELSE 0 END) AS working_capital,
    SUM(CASE WHEN account_type = 'Current Asset'     THEN balance ELSE 0 END) /
    NULLIF(SUM(CASE WHEN account_type = 'Current Liability' THEN balance ELSE 0 END), 0) AS current_ratio
FROM balance_sheet
GROUP BY 1
ORDER BY 1;

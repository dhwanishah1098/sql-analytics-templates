-- Revenue by GL account and cost centre
SELECT account_code, account_name, cost_centre, SUM(amount) AS total
FROM general_ledger WHERE line_type = 'Revenue'
GROUP BY 1, 2, 3 ORDER BY 4 DESC;

-- Operating expense trend by category (last 6 months)
SELECT DATE_TRUNC('month', date)::date AS month, category,
       SUM(amount) AS total_opex
FROM general_ledger WHERE line_type = 'OpEx'
  AND date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY 1, 2 ORDER BY 1, 3 DESC;

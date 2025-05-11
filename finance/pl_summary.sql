-- Simplified P&L Summary by Month
SELECT
    DATE_TRUNC('month', date)::date AS month,
    SUM(CASE WHEN line_type = 'Revenue' THEN amount ELSE 0 END)         AS revenue,
    SUM(CASE WHEN line_type = 'COGS' THEN amount ELSE 0 END)            AS cogs,
    SUM(CASE WHEN line_type = 'Revenue' THEN amount ELSE 0 END)
        - SUM(CASE WHEN line_type = 'COGS' THEN amount ELSE 0 END)      AS gross_profit,
    SUM(CASE WHEN line_type = 'OpEx' THEN amount ELSE 0 END)            AS opex,
    SUM(CASE WHEN line_type = 'Revenue' THEN amount ELSE 0 END)
        - SUM(CASE WHEN line_type IN ('COGS', 'OpEx') THEN amount ELSE 0 END) AS ebitda,
    ROUND(100.0 * (
        SUM(CASE WHEN line_type = 'Revenue' THEN amount ELSE 0 END)
        - SUM(CASE WHEN line_type = 'COGS' THEN amount ELSE 0 END)
    ) / NULLIF(SUM(CASE WHEN line_type = 'Revenue' THEN amount ELSE 0 END), 0), 2) AS gross_margin_pct
FROM general_ledger
GROUP BY 1
ORDER BY 1;

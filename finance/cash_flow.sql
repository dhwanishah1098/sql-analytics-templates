-- Simplified Cash Flow Statement
SELECT
    DATE_TRUNC('month', transaction_date)::date AS month,
    SUM(CASE WHEN flow_type = 'Operating Inflow'  THEN amount ELSE 0 END) AS operating_inflows,
    SUM(CASE WHEN flow_type = 'Operating Outflow' THEN amount ELSE 0 END) AS operating_outflows,
    SUM(CASE WHEN flow_type LIKE 'Operating%'
             THEN CASE WHEN flow_type = 'Operating Inflow' THEN amount ELSE -amount END END) AS operating_cf,
    SUM(CASE WHEN flow_type LIKE 'Investing%'
             THEN CASE WHEN flow_type = 'Investing Inflow' THEN amount ELSE -amount END END) AS investing_cf,
    SUM(CASE WHEN flow_type LIKE 'Financing%'
             THEN CASE WHEN flow_type = 'Financing Inflow' THEN amount ELSE -amount END END) AS financing_cf
FROM cash_transactions
GROUP BY 1
ORDER BY 1;

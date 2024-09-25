-- Monthly cash flow summary
SELECT DATE_TRUNC('month', txn_date) AS month,
    SUM(CASE WHEN txn_type='inflow'  THEN amount ELSE 0 END) AS inflows,
    SUM(CASE WHEN txn_type='outflow' THEN amount ELSE 0 END) AS outflows
FROM fact_transactions GROUP BY 1 ORDER BY 1;

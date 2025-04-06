-- Working capital components
SELECT
    SUM(CASE WHEN account_type='receivable' THEN balance END) AS ar,
    SUM(CASE WHEN account_type='inventory'  THEN balance END) AS inventory,
    SUM(CASE WHEN account_type='payable'    THEN balance END) AS ap,
    SUM(CASE WHEN account_type IN('receivable','inventory') THEN balance
             WHEN account_type='payable' THEN -balance END)  AS net_working_capital
FROM fact_balance_sheet WHERE snapshot_date = CURRENT_DATE;

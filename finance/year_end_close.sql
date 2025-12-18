-- Year-end close checklist queries
SELECT 'Unreconciled transactions' AS check_name,
    COUNT(*) AS count FROM fact_transactions WHERE reconciled = FALSE AND EXTRACT(YEAR FROM txn_date) = EXTRACT(YEAR FROM CURRENT_DATE)
UNION ALL
SELECT 'Open POs past year-end', COUNT(*) FROM fact_purchase_orders
    WHERE status = 'open' AND expected_delivery < DATE_TRUNC('year', CURRENT_DATE + INTERVAL '1 year');

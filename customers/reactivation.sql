-- Customers inactive 60-120 days with high LTV
SELECT customer_id, lifetime_value, days_since_last_order
FROM v_customer_360
WHERE days_since_last_order BETWEEN 60 AND 120
AND lifetime_value > 500
ORDER BY lifetime_value DESC;

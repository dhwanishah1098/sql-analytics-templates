-- Customer LTV decile ranking
SELECT customer_id, lifetime_value,
    NTILE(10) OVER (ORDER BY lifetime_value DESC) AS ltv_decile
FROM v_customer_360;

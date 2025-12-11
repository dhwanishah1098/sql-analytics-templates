-- High-Value Customer Early Warning: Revenue Drop Detection
WITH last_2q AS (
    SELECT
        customer_id,
        SUM(CASE WHEN order_date >= CURRENT_DATE - 90 THEN revenue ELSE 0 END) AS rev_last_90d,
        SUM(CASE WHEN order_date BETWEEN CURRENT_DATE - 180 AND CURRENT_DATE - 91 THEN revenue ELSE 0 END) AS rev_prior_90d
    FROM fact_sales
    GROUP BY 1
)
SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    rev_last_90d,
    rev_prior_90d,
    rev_last_90d - rev_prior_90d AS delta,
    ROUND(100.0 * (rev_last_90d - rev_prior_90d) / NULLIF(rev_prior_90d, 0), 2) AS change_pct
FROM last_2q
JOIN dim_customers c USING (customer_id)
WHERE rev_prior_90d >= 5000
  AND rev_last_90d < rev_prior_90d * 0.7
ORDER BY delta;

-- Average Days Between Purchases by Segment
WITH purchase_gaps AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_date,
        order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS days_gap
    FROM (SELECT DISTINCT customer_id, order_date::date FROM fact_sales) t
)
SELECT
    c.segment,
    COUNT(DISTINCT p.customer_id)                   AS customers,
    ROUND(AVG(p.days_gap), 1)                       AS avg_days_between_purchases,
    ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY p.days_gap::numeric), 1) AS median_days,
    ROUND(MIN(p.days_gap)::numeric, 0)              AS min_days,
    ROUND(MAX(p.days_gap)::numeric, 0)              AS max_days
FROM purchase_gaps p
JOIN dim_customers c USING (customer_id)
WHERE p.days_gap IS NOT NULL
GROUP BY 1
ORDER BY avg_days_between_purchases;

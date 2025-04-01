-- Monthly Cohort Retention Analysis
WITH cohorts AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_date))::date AS cohort_month
    FROM fact_sales
    GROUP BY 1
),
customer_months AS (
    SELECT
        s.customer_id,
        c.cohort_month,
        DATE_TRUNC('month', s.order_date)::date AS activity_month,
        EXTRACT(EPOCH FROM (DATE_TRUNC('month', s.order_date) - c.cohort_month::timestamp))
            / (30.44 * 86400)                   AS period_number
    FROM fact_sales s
    JOIN cohorts c USING (customer_id)
)
SELECT
    cohort_month,
    period_number::int                          AS period,
    COUNT(DISTINCT customer_id)                 AS active_customers,
    FIRST_VALUE(COUNT(DISTINCT customer_id)) OVER (
        PARTITION BY cohort_month ORDER BY period_number
    )                                           AS cohort_size,
    ROUND(100.0 * COUNT(DISTINCT customer_id)
        / FIRST_VALUE(COUNT(DISTINCT customer_id)) OVER (
            PARTITION BY cohort_month ORDER BY period_number
        ), 2)                                   AS retention_rate
FROM customer_months
GROUP BY 1, 2
ORDER BY 1, 2;

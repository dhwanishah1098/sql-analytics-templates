-- Feature Engineering for Churn Prediction Model
SELECT
    customer_id,
    CURRENT_DATE - MAX(order_date)::date                    AS recency_days,
    COUNT(DISTINCT order_id)                                AS frequency,
    SUM(revenue)                                            AS monetary,
    AVG(revenue)                                            AS avg_order_value,
    STDDEV(revenue)                                         AS revenue_stddev,
    COUNT(DISTINCT DATE_TRUNC('month', order_date))         AS active_months,
    MAX(order_date) - MIN(order_date)                       AS customer_tenure_days,
    COUNT(DISTINCT product_id)                              AS product_diversity,
    SUM(CASE WHEN order_date >= CURRENT_DATE - INTERVAL '90 days' THEN revenue ELSE 0 END)
        / NULLIF(SUM(revenue), 0)                           AS revenue_last90d_share,
    CASE WHEN MAX(order_date) < CURRENT_DATE - INTERVAL '90 days' THEN 1 ELSE 0 END AS churned
FROM fact_sales
GROUP BY 1;

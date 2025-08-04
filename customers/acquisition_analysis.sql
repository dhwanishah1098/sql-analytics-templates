-- Customer Acquisition Analysis by Channel and Month
SELECT
    DATE_TRUNC('month', acquisition_date)::date AS month,
    acquisition_channel,
    COUNT(*)                                     AS new_customers,
    AVG(first_order_value)                       AS avg_first_order,
    SUM(first_order_value)                       AS channel_revenue,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY DATE_TRUNC('month', acquisition_date)), 2) AS channel_share_pct
FROM (
    SELECT
        c.customer_id,
        c.acquisition_channel,
        c.acquisition_date,
        MIN(s.revenue) AS first_order_value
    FROM dim_customers c
    JOIN fact_sales s USING (customer_id)
    GROUP BY 1,2,3
) acq
GROUP BY 1, 2
ORDER BY 1, new_customers DESC;

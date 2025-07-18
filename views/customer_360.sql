-- Customer 360 View: Profile + Transactions + Segment
CREATE OR REPLACE VIEW vw_customer_360 AS
SELECT
    c.customer_id,
    c.customer_name,
    c.email,
    c.segment,
    c.acquisition_channel,
    c.acquisition_date,
    COUNT(DISTINCT s.order_id)              AS lifetime_orders,
    SUM(s.revenue)                          AS lifetime_revenue,
    AVG(s.revenue)                          AS avg_order_value,
    MIN(s.order_date)                       AS first_order,
    MAX(s.order_date)                       AS last_order,
    CURRENT_DATE - MAX(s.order_date)::date  AS days_since_last_order,
    SUM(r.return_id IS NOT NULL)            AS total_returns
FROM dim_customers c
LEFT JOIN fact_sales s USING (customer_id)
LEFT JOIN returns r USING (order_id)
GROUP BY 1,2,3,4,5,6;

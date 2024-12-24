-- Customer 360 view
CREATE OR REPLACE VIEW v_customer_360 AS
SELECT
    c.customer_id,
    c.customer_name,
    c.region,
    c.segment,
    COUNT(DISTINCT o.order_id)           AS total_orders,
    SUM(o.revenue)                       AS lifetime_value,
    AVG(o.revenue)                       AS avg_order_value,
    MIN(o.order_date)                    AS first_order_date,
    MAX(o.order_date)                    AS last_order_date,
    CURRENT_DATE - MAX(o.order_date)     AS days_since_last_order,
    SUM(o.units_sold)                    AS total_units
FROM dim_customers c
LEFT JOIN fact_orders o ON c.customer_id = o.customer_id
GROUP BY 1, 2, 3, 4;

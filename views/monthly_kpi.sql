-- Monthly KPI summary view
CREATE OR REPLACE VIEW v_monthly_kpi AS
SELECT DATE_TRUNC('month', order_date) AS month,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(revenue) AS revenue,
    AVG(revenue) AS aov
FROM fact_orders GROUP BY 1;

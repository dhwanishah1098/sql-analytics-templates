-- Identify churn risk customers
WITH last_activity AS (
    SELECT customer_id, MAX(order_date) AS last_order
    FROM fact_orders GROUP BY 1
),
scored AS (
    SELECT
        customer_id,
        last_order,
        CURRENT_DATE - last_order AS days_inactive,
        CASE
            WHEN CURRENT_DATE - last_order BETWEEN 61 AND 90  THEN 'Medium'
            WHEN CURRENT_DATE - last_order > 90               THEN 'High'
        END AS churn_risk
    FROM last_activity
)
SELECT * FROM scored WHERE churn_risk IS NOT NULL
ORDER BY days_inactive DESC;

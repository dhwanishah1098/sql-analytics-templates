-- AR aging buckets
SELECT customer_id,
    SUM(CASE WHEN days_outstanding <= 30  THEN amount END) AS current_0_30,
    SUM(CASE WHEN days_outstanding BETWEEN 31 AND 60  THEN amount END) AS days_31_60,
    SUM(CASE WHEN days_outstanding BETWEEN 61 AND 90  THEN amount END) AS days_61_90,
    SUM(CASE WHEN days_outstanding > 90 THEN amount END) AS overdue_90plus
FROM fact_receivables
GROUP BY 1 ORDER BY overdue_90plus DESC NULLS LAST;

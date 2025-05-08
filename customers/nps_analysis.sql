-- NPS Breakdown by Segment and Product Category
SELECT
    c.segment,
    p.category,
    COUNT(*)                                                AS responses,
    SUM(CASE WHEN nps_score >= 9 THEN 1 ELSE 0 END)         AS promoters,
    SUM(CASE WHEN nps_score BETWEEN 7 AND 8 THEN 1 ELSE 0 END) AS passives,
    SUM(CASE WHEN nps_score <= 6 THEN 1 ELSE 0 END)         AS detractors,
    ROUND(100.0 * (SUM(CASE WHEN nps_score >= 9 THEN 1 ELSE 0 END) -
                   SUM(CASE WHEN nps_score <= 6 THEN 1 ELSE 0 END))
          / COUNT(*), 1)                                    AS nps
FROM nps_responses n
JOIN dim_customers c USING (customer_id)
JOIN dim_products p ON n.product_id = p.product_id
GROUP BY 1, 2
HAVING COUNT(*) >= 10
ORDER BY nps DESC;

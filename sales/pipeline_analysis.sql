-- Sales Pipeline Conversion Analysis
SELECT
    stage,
    COUNT(*)                                            AS deals,
    SUM(deal_value)                                     AS total_value,
    AVG(deal_value)                                     AS avg_deal_value,
    AVG(days_in_stage)                                  AS avg_days_in_stage,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS stage_pct,
    ROUND(100.0 * SUM(deal_value) / SUM(SUM(deal_value)) OVER (), 2) AS value_pct
FROM pipeline
WHERE created_at >= CURRENT_DATE - INTERVAL '90 days'
GROUP BY stage
ORDER BY CASE stage
    WHEN 'Prospecting' THEN 1
    WHEN 'Qualification' THEN 2
    WHEN 'Proposal' THEN 3
    WHEN 'Negotiation' THEN 4
    WHEN 'Closed Won' THEN 5
    WHEN 'Closed Lost' THEN 6
END;

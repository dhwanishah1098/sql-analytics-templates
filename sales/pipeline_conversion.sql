-- Sales pipeline stage conversion
SELECT stage,
    COUNT(*) AS opportunities,
    SUM(deal_value) AS pipeline_value,
    ROUND(COUNT(*)::numeric / LAG(COUNT(*)) OVER (ORDER BY stage_order) * 100, 1) AS stage_conversion_pct
FROM fact_pipeline
GROUP BY stage, stage_order ORDER BY stage_order;

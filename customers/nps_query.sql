-- NPS score calculation
SELECT
    SUM(CASE WHEN score >= 9 THEN 1 END)::float / COUNT(*) * 100 AS promoters_pct,
    SUM(CASE WHEN score <= 6 THEN 1 END)::float / COUNT(*) * 100 AS detractors_pct,
    (SUM(CASE WHEN score >= 9 THEN 1 END) - SUM(CASE WHEN score <= 6 THEN 1 END))::float / COUNT(*) * 100 AS nps
FROM fact_surveys WHERE survey_date >= CURRENT_DATE - 90;

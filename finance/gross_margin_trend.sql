-- Gross margin trend by quarter
SELECT DATE_TRUNC('quarter', sale_date) AS quarter,
    SUM(revenue) AS revenue,
    SUM(cogs) AS cogs,
    SUM(revenue - cogs) AS gross_profit,
    ROUND(SUM(revenue - cogs) / NULLIF(SUM(revenue),0) * 100, 2) AS gross_margin_pct
FROM fact_sales GROUP BY 1 ORDER BY 1;

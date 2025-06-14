-- Week-over-Week Comparison with Day-Level Breakdown
WITH this_week AS (
    SELECT DATE_PART('dow', order_date)::int AS dow, SUM(revenue) AS revenue, COUNT(DISTINCT order_id) AS orders
    FROM fact_sales WHERE order_date >= DATE_TRUNC('week', CURRENT_DATE) GROUP BY 1
),
last_week AS (
    SELECT DATE_PART('dow', order_date)::int AS dow, SUM(revenue) AS revenue, COUNT(DISTINCT order_id) AS orders
    FROM fact_sales WHERE order_date >= DATE_TRUNC('week', CURRENT_DATE) - 7
      AND order_date < DATE_TRUNC('week', CURRENT_DATE) GROUP BY 1
)
SELECT
    CASE t.dow WHEN 0 THEN 'Sun' WHEN 1 THEN 'Mon' WHEN 2 THEN 'Tue'
               WHEN 3 THEN 'Wed' WHEN 4 THEN 'Thu' WHEN 5 THEN 'Fri' ELSE 'Sat' END AS day,
    t.revenue AS this_week_rev, l.revenue AS last_week_rev,
    ROUND(100.0 * (t.revenue - l.revenue) / NULLIF(l.revenue, 0), 2) AS wow_pct
FROM this_week t
FULL OUTER JOIN last_week l USING (dow)
ORDER BY COALESCE(t.dow, l.dow);

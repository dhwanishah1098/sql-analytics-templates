-- Sales rep leaderboard for current month
SELECT rep_name, SUM(revenue) AS revenue,
       COUNT(DISTINCT order_id) AS deals,
       RANK() OVER (ORDER BY SUM(revenue) DESC) AS rank
FROM fact_sales JOIN dim_reps USING (rep_id)
WHERE DATE_TRUNC('month', order_date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY 1 ORDER BY rank;

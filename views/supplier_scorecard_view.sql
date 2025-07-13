CREATE OR REPLACE VIEW vw_supplier_scorecard AS
SELECT supplier_id, AVG(lead_time_days) AS avg_lead,
       AVG(fill_rate) AS avg_fill_rate, COUNT(*) AS orders
FROM purchase_orders GROUP BY 1;

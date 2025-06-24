SELECT Education_Level, avg(churned) AS churn_rate
FROM creditcard_customers
GROUP BY Education_level
;

SELECT
	churned,
    avg(total_trans_amt) AS avg_trans_amt,
    avg(total_trans_ct) AS avg_trans_ct
FROM creditcard_customers
GROUP BY churned;
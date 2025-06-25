SELECT 
	Education_Level, 
    avg(churned) AS churn_rate
FROM creditcard_customers
GROUP BY Education_level;

SELECT
	churned,
    avg(total_trans_amt) AS avg_trans_amt,
    avg(total_trans_ct) AS avg_trans_ct
FROM creditcard_customers
GROUP BY churned;

-- shows which income groups have the highest churn
SELECT
	income_category,
    round(avg(churned)*100, 2) as churn_rate_percent,
    count(*) as customer_count
FROM creditcard_customers
GROUP BY income_category
ORDER BY churn_rate_percent DESC;

-- compares usage and contact frequency for churned vs retained customers
SELECT 
  Churned,
  ROUND(AVG(Months_Inactive_12_mon), 2) AS avg_inactivity,
  ROUND(AVG(Contacts_Count_12_mon), 2) AS avg_contacts,
  ROUND(AVG(Total_Trans_Ct), 2) AS avg_transactions
FROM creditcard_customers
GROUP BY Churned;

-- low credit limits or high utilization may contribute to churn
SELECT 
  ROUND(AVG(Credit_Limit), 2) AS avg_credit_limit,
  ROUND(AVG(Avg_Utilization_Ratio), 2) AS avg_util_ratio
FROM creditcard_customers
WHERE Churned = 1;

-- Pinpoints the top 5 demographic combinations with highest churn
SELECT 
  Gender,
  Education_Level,
  Marital_Status,
  COUNT(*) AS churned_customers
FROM creditcard_customers
WHERE Churned = 1
GROUP BY Gender, Education_Level, Marital_Status
ORDER BY churned_customers DESC
LIMIT 5;

-- Drop in transaction count or amount can predict churn
SELECT 
  Churned,
  ROUND(AVG(Total_Trans_Amt), 2) AS avg_transaction_amount,
  ROUND(AVG(Total_Amt_Chng_Q4_Q1), 2) AS avg_spend_change,
  ROUND(AVG(Total_Ct_Chng_Q4_Q1), 2) AS avg_count_change
FROM creditcard_customers
GROUP BY Churned;

-- Identifies exact customer records fitting known churn behavior.
SELECT *
FROM creditcard_customers
WHERE 
  Months_Inactive_12_mon > 3 AND 
  Total_Trans_Ct < 40 AND 
  Churned = 1;

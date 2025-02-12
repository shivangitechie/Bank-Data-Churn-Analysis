SELECT * FROM churn_analysis.bank LIMIT 5;

# Total number fo customers
SELECT 
	COUNT(DISTINCT customer_id) 
FROM churn_analysis.bank AS customer_count;

# Total number of customers churned and retained
SELECT churn, 	
	COUNT(DISTINCT customer_id) 
FROM churn_analysis.bank
GROUP BY churn;

# Churn Rate Calculation
SELECT 
	(SUM(churn) / COUNT(*)) * 100 AS Churn_Rate
FROM churn_analysis.bank;

# Total customers churned based on country
SELECT 
	country,
	COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY country
ORDER BY churn_rate DESC;

# Total customers churned based on gender
SELECT 
	gender,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY gender
ORDER BY churn_rate DESC;

# Total churned based on age groups
# Let us check the minimum and maximum age
SELECT
	MIN(age) AS age_lb,
    MAX(age) AS age_ub
FROM churn_analysis.bank;

SELECT 
	CASE
		WHEN age < 25 THEN "Under 25"
        WHEN age BETWEEN 25 AND 40 THEN "25-40"
        WHEN age BETWEEN 40 AND 60 THEN "40-60"
        ELSE "Above 60"
	END AS age_group,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY age_group
ORDER BY churn_rate DESC;

# Average balance, credit score, and salary of churned vs retained customers
SELECT
	churn,
    ROUND(AVG(credit_score), 2) AS avg_credit_score,
    ROUND(AVG(balance),2) AS avg_balance,
    ROUND(AVG(estimated_salary),2) AS avg_estimated_salary
FROM churn_analysis.bank
GROUP BY churn;

# Relation between balance and churn
SELECT
	CASE 
		WHEN balance < (SELECT AVG(balance) FROM churn_analysis.bank) THEN "Low Balance Value"
        ELSE "High Balance Value"
	END AS balance_group,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY balance_group
ORDER BY churn_rate DESC;

# Relation between credit score and churn
SELECT
	CASE 
		WHEN credit_score < (SELECT AVG(credit_score) FROM churn_analysis.bank) THEN "Low Credit Score Value"
        ELSE "High Credit Score Value"
	END AS credit_score_group,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY credit_score_group
ORDER BY churn_rate DESC;

# Relation between estimated salary and churn
SELECT
	CASE 
		WHEN estimated_salary < (SELECT AVG(estimated_salary) FROM churn_analysis.bank) THEN "Low Salary Value"
        ELSE "High Salary Value"
	END AS estimated_salary_group,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY estimated_salary_group
ORDER BY churn_rate DESC;

# Loyal customers based on tenure
SELECT 
	MIN(tenure) AS tenure_lb,
    MAX(tenure) AS tenure_ub
FROM churn_analysis.bank;

SELECT
	CASE 
		WHEN tenure < 1 THEN "Less than 1 Year"
        WHEN tenure <= 3 THEN "1-3 Years"
        WHEN tenure <= 7 THEN "4-7 Years"
        ELSE "More than 7 Years"
	END AS tenure_groups,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY tenure_groups
ORDER BY churn_rate DESC;

# Relation between active members and churned members
SELECT 
	active_member,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY active_member
ORDER BY churn_rate DESC;

# Relation between number of products and churn
SELECT 
	products_number,
    COUNT(customer_id) AS customer_count,
    SUM(churn) AS total_churn,
    (SUM(churn)/COUNT(*))*100 AS churn_rate
FROM churn_analysis.bank
GROUP BY products_number
ORDER BY churn_rate DESC;
-- ==================================================================
-- TELCO CUSTOMER CHURN ANALYSIS - BUSINESS QUERIES
-- Author: Jonathan Ilardi
-- Database: SQLite (customers table)
-- ==================================================================

-- 1. Overall Churn Rate & Revenue Impact
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_revenue_lost
FROM customers;

-- 2. Churn Rate by Contract Type
SELECT
    Contract AS contract_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY Contract
ORDER BY tasa_churn_pct DESC;

-- 3. Churn Rate by Customer Tenure Group
SELECT 
    TenureGroup AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY TenureGroup
ORDER BY churn_rate_pct DESC;

-- 4. Churn Rate & Average Monthly Bill by Internet Service Type
SELECT 
    InternetService AS internet_service,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

-- 5. Impact of Tech Suppport on Fiber Optic Customers (High-risk Segment)
SELECT 
    TechSupport AS has_tech_support,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM customers
WHERE InternetService = 'Fiber optic'
GROUP BY TechSupport
ORDER BY churn_rate_pct DESC;
/*
========================================================
Customer Churn Analysis Project
Author : Vebryo Najmi
Tools  : MySQL
Dataset: IBM Telco Customer Churn
========================================================
*/

USE churn_analysis;

-- =====================================================
-- 1. Overall Churn Overview
-- Objective:
-- Measure total customers, churn customers,
-- and overall churn rate
-- =====================================================

SELECT
    COUNT(*) AS total_customer,

    SUM(
        CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churn_customer,

    ROUND(
        SUM(
            CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn;

-- =====================================================
-- 2. Churn Analysis by Contract Type
-- Objective:
-- Identify which contract type has the highest churn rate
-- =====================================================

SELECT
    Contract,

    COUNT(*) AS total_customer,

    SUM(
        CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churn_customer,

    ROUND(
        SUM(
            CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn

GROUP BY Contract

ORDER BY churn_rate DESC;

-- =====================================================
-- 3. Churn Analysis by Customer Tenure
-- Objective:
-- Analyze churn behavior based on customer duration
-- =====================================================

SELECT
    CASE
        WHEN tenure < 12 THEN 'New Customer'
        WHEN tenure < 24 THEN 'Mid Customer'
        ELSE 'Loyal Customer'
    END AS customer_group,

    COUNT(*) AS total_customer,

    SUM(
        CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churn_customer,

    ROUND(
        SUM(
            CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn

GROUP BY customer_group

ORDER BY churn_rate DESC;

-- =====================================================
-- 4. Churn Analysis by Internet Service
-- Objective:
-- Compare churn rate across internet service types
-- =====================================================

SELECT
    InternetService,

    COUNT(*) AS total_customer,

    SUM(
        CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churn_customer,

    ROUND(
        SUM(
            CASE
                WHEN Churn = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customer_churn

GROUP BY InternetService

ORDER BY churn_rate DESC;

-- =====================================================
-- 5. Monthly Charges Analysis
-- Objective:
-- Compare average monthly charges between churned
-- and retained customers
-- =====================================================

SELECT
    Churn,

    AVG(MonthlyCharges) AS avg_monthly_charge,

    MIN(MonthlyCharges) AS min_charge,

    MAX(MonthlyCharges) AS max_charge

FROM customer_churn

GROUP BY Churn;
USE retail_analytics;

-- Objective: Calculate RFM metrics and categorize customers into value tiers.
WITH BaseMetrics AS (
    -- 1. Calculate the raw Recency, Frequency, and Monetary values
    SELECT 
        CustomerID,
        DATEDIFF((SELECT MAX(InvoiceDate) + INTERVAL 1 DAY FROM cleaned_transactions), MAX(InvoiceDate)) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(Revenue) AS Monetary
    FROM cleaned_transactions
    GROUP BY CustomerID
),
ScoredMetrics AS (
    -- 2. Use NTILE(5) to divide customers into 5 equal buckets for each metric
    -- Note: For Recency, fewer days is better, so we order DESC to give smallest days a 5.
    SELECT 
        CustomerID,
        Recency,
        Frequency,
        Monetary,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM BaseMetrics
)
-- 3. Combine scores and apply the tier logic
SELECT 
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    (R_Score + F_Score + M_Score) AS Total_RFM_Score,
    CASE 
        WHEN (R_Score + F_Score + M_Score) >= 13 THEN 'Champions'
        WHEN (R_Score + F_Score + M_Score) >= 10 THEN 'Loyal'
        WHEN (R_Score + F_Score + M_Score) >= 6 THEN 'At Risk'
        ELSE 'Lost'
    END AS Customer_Tier
FROM ScoredMetrics
ORDER BY Total_RFM_Score DESC;
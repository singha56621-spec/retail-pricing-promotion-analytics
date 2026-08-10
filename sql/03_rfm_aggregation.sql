USE retail_analytics;

-- Objective: Compute Recency, Frequency, and Monetary metrics per CustomerID.
WITH ReferenceDate AS (
    -- Find the maximum date in the dataset to act as 'today' for the calculation
    SELECT MAX(InvoiceDate) AS MaxDate
    FROM cleaned_transactions
),
CustomerRFM AS (
    SELECT 
        c.CustomerID,
        DATEDIFF((SELECT MaxDate FROM ReferenceDate), MAX(c.InvoiceDate)) AS Recency,
        COUNT(DISTINCT c.InvoiceNo) AS Frequency,
        SUM(c.Revenue) AS Monetary
    FROM cleaned_transactions c
    GROUP BY c.CustomerID
)
SELECT * 
FROM CustomerRFM
ORDER BY Monetary DESC;
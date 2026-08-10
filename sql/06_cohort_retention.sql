USE retail_analytics;



-- Objective: Track monthly customer retention by acquisition cohort.
WITH FirstPurchase AS (
    -- 1. Find the first ever purchase month for each customer
    SELECT 
        CustomerID,
        DATE_FORMAT(MIN(InvoiceDate), '%Y-%m-01') AS CohortMonth
    FROM cleaned_transactions
    GROUP BY CustomerID
),
TransactionMonths AS (
    -- 2. Map every transaction to the customer's original cohort month
    SELECT 
        t.CustomerID,
        f.CohortMonth,
        DATE_FORMAT(t.InvoiceDate, '%Y-%m-01') AS InvoiceMonth,
        -- Calculate the number of months since the first purchase
        TIMESTAMPDIFF(MONTH, f.CohortMonth, DATE_FORMAT(t.InvoiceDate, '%Y-%m-01')) AS CohortIndex
    FROM cleaned_transactions t
    JOIN FirstPurchase f ON t.CustomerID = f.CustomerID
)
-- 3. Count distinct customers retained in each month after acquisition
SELECT 
    CohortMonth,
    CohortIndex,
    COUNT(DISTINCT CustomerID) AS RetainedCustomers
FROM TransactionMonths
GROUP BY CohortMonth, CohortIndex
ORDER BY CohortMonth, CohortIndex;
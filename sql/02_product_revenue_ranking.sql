USE retail_analytics;

-- Objective: Rank top 5 products by revenue per month to identify volatility.
WITH ProductMonthlyRevenue AS (
    SELECT 
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
        Description AS Product,
        SUM(Revenue) AS TotalRevenue
    FROM cleaned_transactions
    GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m'), Description
),
RankedProducts AS (
    SELECT 
        Month,
        Product,
        TotalRevenue,
        DENSE_RANK() OVER(PARTITION BY Month ORDER BY TotalRevenue DESC) AS RevenueRank
    FROM ProductMonthlyRevenue
)
SELECT * 
FROM RankedProducts
WHERE RevenueRank <= 5
ORDER BY Month, RevenueRank;
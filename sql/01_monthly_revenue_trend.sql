USE retail_analytics;
-- Objective: Calculate monthly revenue and MoM growth rate using window functions.
WITH MonthlyStats AS (
    SELECT 
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
        SUM(Revenue) AS MonthlyRevenue
    FROM cleaned_transactions
    GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
)
SELECT 
    Month,
    MonthlyRevenue,
    LAG(MonthlyRevenue) OVER(ORDER BY Month) AS PrevMonthRevenue,
    ROUND(
        ((MonthlyRevenue - LAG(MonthlyRevenue) OVER(ORDER BY Month)) 
        / LAG(MonthlyRevenue) OVER(ORDER BY Month)) * 100, 
    2) AS MoM_Growth_Pct
FROM MonthlyStats
ORDER BY Month;
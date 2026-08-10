USE retail_analytics;


-- Objective: Detect promotional periods where UnitPrice dropped > 15% below the product's historical average.
WITH ProductHistoricalStats AS (
    -- Calculate the all-time average price for each product
    SELECT 
        StockCode,
        Description,
        AVG(UnitPrice) AS AllTimeAvgPrice
    FROM cleaned_transactions
    GROUP BY StockCode, Description
),
ProductMonthlyStats AS (
    -- Calculate the average price for each product per month
    SELECT 
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS PromoMonth,
        StockCode,
        AVG(UnitPrice) AS MonthlyAvgPrice,
        SUM(Quantity) AS MonthlyQuantity,
        SUM(Revenue) AS MonthlyRevenue
    FROM cleaned_transactions
    GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m'), StockCode
)
SELECT 
    m.PromoMonth,
    m.StockCode,
    h.Description,
    h.AllTimeAvgPrice,
    m.MonthlyAvgPrice,
    ROUND(((h.AllTimeAvgPrice - m.MonthlyAvgPrice) / h.AllTimeAvgPrice) * 100, 2) AS DiscountDepthPct,
    -- Create the Promo Flag
    CASE 
        WHEN m.MonthlyAvgPrice < (h.AllTimeAvgPrice * 0.85) THEN 1 
        ELSE 0 
    END AS IsPromoPeriod,
    m.MonthlyQuantity,
    m.MonthlyRevenue
FROM ProductMonthlyStats m
JOIN ProductHistoricalStats h ON m.StockCode = h.StockCode
-- Filter to only show the promotional periods
WHERE m.MonthlyAvgPrice < (h.AllTimeAvgPrice * 0.85)
ORDER BY m.PromoMonth, DiscountDepthPct DESC;
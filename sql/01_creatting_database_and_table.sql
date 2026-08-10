CREATE DATABASE IF NOT EXISTS retail_analytics;
USE retail_analytics;

DROP TABLE IF EXISTS cleaned_transactions;

CREATE TABLE cleaned_transactions (
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 4),
    CustomerID VARCHAR(50),
    Country VARCHAR(100),
    Revenue DECIMAL(15, 4)
);

SELECT * FROM cleaned_transactions LIMIT 10;
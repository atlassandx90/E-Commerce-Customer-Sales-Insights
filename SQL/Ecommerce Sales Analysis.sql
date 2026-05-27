CREATE DATABASE ecommerce_project;
USE ecommerce_project;

CREATE TABLE ecommerce_data (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice FLOAT,
    CustomerID FLOAT,
    Country VARCHAR(100),
    TotalPrice FLOAT,
    InvoiceMonth INT,
    InvoiceYear INT,
    InvoiceDay VARCHAR(20)
);

-- ============================================
-- Data Preview
-- Displays first 10 rows
-- ============================================

SELECT *
FROM ecommerce_data
LIMIT 10;

-- ============================================
-- Total Rows Check
-- Verifies imported dataset size
-- ============================================

SELECT COUNT(*) AS Total_Rows
FROM ecommerce_data;

-- ============================================
-- Total Revenue Analysis
-- Calculates overall revenue generated
-- ============================================

SELECT 
    ROUND(SUM(TotalPrice), 2) AS Total_Revenue
FROM ecommerce_data;

-- ============================================
-- Total Orders Analysis
-- Counts total unique orders
-- ============================================

SELECT 
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM ecommerce_data;

-- ============================================
-- Total Customers Analysis
-- Counts unique customers
-- ============================================

SELECT 
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM ecommerce_data;

-- ============================================
-- Top 10 Countries by Revenue
-- Identifies highest revenue generating countries
-- ============================================

SELECT 
    Country,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 10;

-- ============================================
-- Monthly Revenue Trend
-- Analyzes monthly sales performance
-- ============================================

SELECT 
    InvoiceMonth,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data
GROUP BY InvoiceMonth
ORDER BY InvoiceMonth;

-- ============================================
-- Top Products by Revenue
-- Finds best-selling products
-- ============================================

SELECT 
    Description,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 10;

-- ============================================
-- Top Customers Analysis
-- Identifies highest spending customers
-- ============================================

SELECT 
    CustomerID,
    ROUND(SUM(TotalPrice),2) AS Total_Spent
FROM ecommerce_data
GROUP BY CustomerID
ORDER BY Total_Spent DESC
LIMIT 10;

-- ============================================
-- Average Order Value
-- Calculates average revenue per order
-- ============================================

SELECT 
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo), 2) AS Avg_Order_Value
FROM ecommerce_data;

-- ============================================
-- Most Sold Products
-- Finds products with highest quantity sold
-- ============================================

SELECT 
    Description,
    SUM(Quantity) AS Total_Quantity_Sold
FROM ecommerce_data
GROUP BY Description
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

-- ============================================
-- Revenue by Year
-- Analyzes yearly revenue trend
-- ============================================

SELECT 
    InvoiceYear,
    ROUND(SUM(TotalPrice),2) AS Revenue
FROM ecommerce_data
GROUP BY InvoiceYear
ORDER BY InvoiceYear;

-- ============================================
-- Product Revenue Ranking
-- Uses Window Function for ranking
-- ============================================

SELECT
    Description,
    ROUND(SUM(TotalPrice),2) AS Revenue,
    RANK() OVER (ORDER BY SUM(TotalPrice) DESC) AS Product_Rank
FROM ecommerce_data
GROUP BY Description;

-- ============================================
-- Customer Segmentation
-- Groups customers based on spending
-- ============================================

SELECT
    CustomerID,
    ROUND(SUM(TotalPrice),2) AS Total_Spent,

    CASE
        WHEN SUM(TotalPrice) > 5000 THEN 'VIP Customer'
        WHEN SUM(TotalPrice) > 2000 THEN 'Loyal Customer'
        ELSE 'Regular Customer'
    END AS Customer_Segment

FROM ecommerce_data
GROUP BY CustomerID;

-- =========================================================
-- End of E-Commerce Sales Analysis Project
-- =========================================================
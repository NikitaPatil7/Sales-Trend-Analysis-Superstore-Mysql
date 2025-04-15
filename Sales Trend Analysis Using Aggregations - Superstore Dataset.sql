create database superstore;

use superstore;

CREATE TABLE Superstore (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Order_Date date,
    Ship_Date date,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code INT,
    Region VARCHAR(50),
    Product_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT
);

select * from superstore;

-- 1. What is the total revenue generated each month?
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS Year,
    EXTRACT(MONTH FROM Order_Date) AS Month,
    SUM(Sales) AS Total_Revenue
FROM Superstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- 2. How many distinct orders were placed each month?
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS Year,
    EXTRACT(MONTH FROM Order_Date) AS Month,
    COUNT(DISTINCT Order_ID) AS Order_Volume
FROM Superstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- 3. What were the top 5 highest revenue-generating months?
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS Year,
    EXTRACT(MONTH FROM Order_Date) AS Month,
    SUM(Sales) AS Revenue
FROM Superstore
GROUP BY Year, Month
ORDER BY Revenue DESC
LIMIT 5;


-- 4. Which month had the highest number of orders?
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS Year,
    EXTRACT(MONTH FROM Order_Date) AS Month,
    COUNT(DISTINCT Order_ID) AS Order_Count
FROM Superstore
GROUP BY Year, Month
ORDER BY Order_Count DESC
LIMIT 1;


-- 5. Which month and year had the highest profit?
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS Year,
    EXTRACT(MONTH FROM Order_Date) AS Month,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Year, Month
ORDER BY Total_Profit DESC
LIMIT 1;

-- 6. Which year had the highest total sales?
SELECT 
    EXTRACT(YEAR FROM Order_Date) AS Year,
    SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY Year
ORDER BY Total_Sales DESC
LIMIT 1;


-- 7. How does revenue trend across months in a single year (e.g., 2014)?
SELECT 
    EXTRACT(MONTH FROM Order_Date) AS Month,
    SUM(Sales) AS Revenue
FROM Superstore
WHERE EXTRACT(YEAR FROM Order_Date) = 2014
GROUP BY Month
ORDER BY Month;


-- 8. Which month consistently generates low sales across years?
SELECT 
    Month,
    AVG(Monthly_Revenue) AS Avg_Revenue
FROM (
    SELECT 
        EXTRACT(MONTH FROM Order_Date) AS Month,
        EXTRACT(YEAR FROM Order_Date) AS Year,
        SUM(Sales) AS Monthly_Revenue
    FROM Superstore
    GROUP BY Year, Month
) AS Monthly
GROUP BY Month
ORDER BY Avg_Revenue ASC;


-- 9. What’s the correlation between order volume and revenue per month?
SELECT 
    Year, Month, Revenue, Order_Count, (Revenue / Order_Count) AS Revenue_Per_Order
FROM (
    SELECT 
        EXTRACT(YEAR FROM Order_Date) AS Year,
        EXTRACT(MONTH FROM Order_Date) AS Month,
        SUM(Sales) AS Revenue,
        COUNT(DISTINCT Order_ID) AS Order_Count
    FROM Superstore
    GROUP BY Year, Month
) AS Monthly;


-- 10. Which months should we focus marketing on (based on low order volume)?
SELECT 
    Month,
    AVG(Order_Count) AS Avg_Orders
FROM (
    SELECT 
        EXTRACT(YEAR FROM Order_Date) AS Year,
        EXTRACT(MONTH FROM Order_Date) AS Month,
        COUNT(DISTINCT Order_ID) AS Order_Count
    FROM Superstore
    GROUP BY Year, Month
) AS Monthly
GROUP BY Month
ORDER BY Avg_Orders ASC;



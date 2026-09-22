select top 10 * from superstore

-- 1. Total Sales
SELECT SUM(Sales) AS Total_Sales
FROM Superstore;

-- 2. Total Profit
SELECT SUM(Profit) AS Total_Profit
FROM Superstore;

-- 3. Total unique orders
SELECT COUNT(DISTINCT [Order_ID]) AS Total_Orders
FROM Superstore;

-- 4. Total quantity sold
SELECT SUM(Quantity) AS Total_Quantity
FROM Superstore;

-- 5. Average Order Value
SELECT 
    SUM(Sales) / COUNT(DISTINCT [Order_ID]) AS Average_Order_Value
FROM Superstore;

-- 6. Sales by region
SELECT 
    Region,
    SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 7. Sales by category
SELECT 
    Category,
    SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 9. Monthly sales trend
SELECT 
    YEAR([Order_Date]) AS Order_Year,
    MONTH([Order_Date]) AS Order_Month,
    SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY 
    YEAR([Order_Date]),
    MONTH([Order_Date])
ORDER BY 
    Order_Year,
    Order_Month;

-- 10. Top 10 customers by sales
SELECT TOP 10
    [Customer_ID],
    [Customer_Name],
    SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY 
    [Customer_ID],
    [Customer_Name]
ORDER BY Total_Sales DESC;

-- 11. Top 10 products by sales
SELECT TOP 10
    [Product_Name],
    SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY [Product_Name]
ORDER BY Total_Sales DESC;

-- 12. Products with negative profit
SELECT 
    [Product_Name],
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY [Product_Name]
HAVING SUM(Profit) < 0
ORDER BY Total_Profit;

-- 13. Classify products by profit
SELECT 
    [Product_Name],
    SUM(Profit) AS Total_Profit,
    CASE
        WHEN SUM(Profit) > 0 THEN 'Profitable'
        WHEN SUM(Profit) < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS Profit_Status
FROM Superstore
GROUP BY [Product_Name];

-- 14. CTE for category ranking
WITH CategorySales AS
(
    SELECT
        Category,
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY Category
)
SELECT
    Category,
    Total_Sales
FROM CategorySales
ORDER BY Total_Sales DESC;

-- 15. Rank customers by sales
SELECT
    [Customer_ID],
    [Customer_Name],
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM Superstore
GROUP BY
    [Customer_ID],
    [Customer_Name];

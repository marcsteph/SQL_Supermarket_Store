#1. Which region has the highest sales?
#2. What is our user repeat rate?
#4. What’s our average daily sales?
#5. Find out how many customers have single vs repeat purchases. Define new vs returning customers flag?
#6. Which city has the highest sales?
#7. How are the sales quantity and sales performance throughout the years?
#8. Which segment and product have generated the most sales?
#9. How long is from order to shipping lead time for each shipping option?

SELECT * FROM market;
SHOW COLUMNS FROM market;


ALTER TABLE market
MODIFY COLUMN Country VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN Customer_Name VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN Segment VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN City VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN State VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN Region VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN Product_Name VARCHAR(255);

ALTER TABLE market
MODIFY COLUMN Sub_Category VARCHAR(255);

ALTER TABLE market
MODIFY COLUMN Category VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN Ship_Mode VARCHAR(20);

ALTER TABLE market
MODIFY COLUMN Ship_Date date;

#1. Which region has the highest sales?
SELECT * FROM market;

SELECT Country, Region, FORMAT(SUM(Sales), 2) AS TotalSales, COUNT(Order_ID) AS OrderQuantity, Order_Date
FROM salesdb.market
GROUP BY Country, Region, Order_Date
ORDER BY TotalSales DESC
LIMIT 5;

SELECT Country, Region, SUM(Sales) AS TotalSales, COUNT(Order_ID) AS OrderQuantity, Order_Date
FROM salesdb.market
GROUP BY Country, Region, Order_Date
ORDER BY TotalSales DESC
LIMIT 5;

#2. What is our user repeat rate?
SELECT
    COUNT(*) AS TotalCustomers,
    COUNT(DISTINCT Customer_ID) AS RepeatCustomers,
    ROUND((COUNT(DISTINCT Customer_ID) / COUNT(*)) * 100, 2) AS RepeatRate
FROM
    salesdb.market;
    
    
#4. What’s our average daily sales?
SELECT
    AVG(Sales) AS AvgDailySales
FROM
    salesdb.market;

#6. Which city has the highest sales?
SELECT City, SUM(Sales) AS Profit FROM salesdb.market
GROUP BY City
ORDER BY Profit DESC
LIMIT 5;

#7. How are the sales quantity and sales performance throughout the years?
SELECT IFNULL(YEAR(Order_Date), 0) AS Year,
       COUNT(Order_ID) AS SalesQuantity,
       SUM(Sales) AS TotalSales
FROM salesdb.market
GROUP BY YEAR(Order_Date)
ORDER BY Year;

#8. Which segment and product have generated the most sales?
SELECT Category, Product_Name, SUM(Sales) AS TotalSales
FROM salesdb.market
GROUP BY Category, Product_Name
ORDER BY TotalSales DESC
LIMIT 5;

#9. How long is from order to shipping lead time for each shipping option?
SELECT Ship_Mode, AVG(DATEDIFF(Ship_Date, Order_Date)) AS LeadTime
FROM salesdb.market
GROUP BY Ship_Mode;


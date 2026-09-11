create database Project;
use Project;

select * from cleaned_dataset;
alter table
cleaned_dataset
RENAME COLUMN `Order ID` TO Order_ID;

select sum(Amount) Total_Revenue
from cleaned_dataset;

select count(distinct Order_ID) Total_Order
from cleaned_dataset;

SELECT 
    SUM(Amount) AS Total_Sales,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Qty) AS Total_Quantity,
    ROUND(SUM(Amount) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM cleaned_dataset;


select sum(Qty) as Total_Quantity
from cleaned_dataset;

-- sales by Category --
SELECT 
    Category,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Category
ORDER BY Total_Sales DESC;

-- sales by channel --
SELECT 
    Channel,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Channel
ORDER BY Total_Sales DESC;

-- sales by Age-Group --
SELECT 
    `Age-Group`,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY `Age-Group`
ORDER BY Total_Sales DESC;

-- sales by gender --
SELECT 
    Gender,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Gender
ORDER BY Total_Sales DESC;


-- sales by state --
SELECT 
    `ship-state` as State,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY `ship-state`
ORDER BY Total_Sales DESC
LIMIT 5;

-- monthly sales --
SELECT 
    Month_Number,
    Month,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Month_Number, Month
ORDER BY Month_Number;


SELECT 
    Month,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Month
ORDER BY Total_Sales DESC;

-- Top Category --
SELECT 
    Category,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Category
ORDER BY Total_Sales DESC
LIMIT 5;

-- Top Channel --
SELECT 
    Channel,
    SUM(Amount) AS Total_Sales
FROM cleaned_dataset
GROUP BY Channel
ORDER BY Total_Sales DESC
LIMIT 5;

-- Overall KPIs --
SELECT 
    SUM(Amount) AS Total_Sales,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Qty) AS Total_Quantity,
    ROUND(SUM(Amount) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM cleaned_dataset;

-- sales contribution by category --
SELECT 
    Category,
    SUM(Amount) AS Total_Sales,
    ROUND(
        SUM(Amount) * 100.0 / (SELECT SUM(Amount) FROM cleaned_dataset),
        2
    ) AS Sales_Percentage
FROM cleaned_dataset
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Rank States by sales --
SELECT 
    `ship-state`,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM (
    SELECT 
        `ship-state`,
        SUM(Amount) AS Total_Sales
    FROM cleaned_dataset
    GROUP BY `ship-state`
) AS State_Sales;

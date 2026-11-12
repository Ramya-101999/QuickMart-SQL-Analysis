CREATE DATABASE QUICKMART;
USE QUICKMART;

SHOW DATABASES;

CREATE TABLE QuickMart(
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp DECIMAL(8,2),
    discountPercent DECIMAL(5,2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(8,2),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

desc QuickMart;

SELECT * FROM QuickMart;

SELECT COUNT(*) FROM QuickMart;

-- DATA EXPLORATION (EDA)-----

-- 1. Total Number of Products

SELECT COUNT(*) AS Total_Products FROM QuickMart;

-------------------------------------------------------------------------------

-- 2. Total Number of Categories

SELECT COUNT(DISTINCT category) AS Total_Categories FROM QuickMart;

-------------------------------------------------------------------------------

-- 3. Display All Categories

SELECT DISTINCT category FROM QuickMart ORDER BY category;

-------------------------------------------------------------------------------

-- 4. Highest MRP (Original Price)

SELECT MAX(mrp) AS Highest_MRP FROM QuickMart;

-------------------------------------------------------------------------------

-- 5. Lowest MRP (Original Price)

SELECT MIN(mrp) AS Lowest_MRP FROM QuickMart;

-------------------------------------------------------------------------------

-- 6. Average MRP

SELECT ROUND(AVG(mrp),2) AS Average_MRP FROM QuickMart;

-------------------------------------------------------------------------------

-- 7. Highest Selling Price

SELECT MAX(discountedSellingPrice) AS Highest_Selling_Price FROM QuickMart;

-------------------------------------------------------------------------------

-- 8. Lowest Selling Price

SELECT MIN(discountedSellingPrice) AS Lowest_Selling_Price FROM QuickMart;

-------------------------------------------------------------------------------

-- 9. Average Selling Price

SELECT ROUND(AVG(discountedSellingPrice),2) AS Average_Selling_Price FROM QuickMart;

-------------------------------------------------------------------------------

-- 10. Total Inventory Available

SELECT SUM(availableQuantity) AS Total_Inventory FROM QuickMart;

-------------------------------------------------------------------------------

-- 11. Products In Stock vs Out Of Stock

SELECT outOfStock, COUNT(*) AS Total_Products
FROM QuickMart
GROUP BY outOfStock;

-------------------------------------------------------------------------------

-- 12. Product Names Appearing Multiple Times

SELECT name, COUNT(*) AS Number_of_SKUs
FROM QuickMart
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;
-------------------------------------------------------------------------------
-- 13. Total Number of Out-of-Stock Products

SELECT COUNT(*) AS Out_Of_Stock_Products
FROM QuickMart
WHERE outOfStock = 1;

-------------------------------------------------------------------------------

-- 14. Total Number of Available Products

SELECT COUNT(*) AS Available_Products
FROM QuickMart
WHERE outOfStock = 0;

-------------------------------------------------------------------------------

-- 15. Total Inventory by Category

SELECT category, SUM(availableQuantity) AS Total_Inventory
FROM QuickMart
GROUP BY category
ORDER BY Total_Inventory DESC;

------------------------------------------------------------------------------
-- CHECKING FOR NULL OR MISSING VALUES --
---------------------------------------------------------------
SELECT *
FROM QUICKMART
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;
------------------------------------------------------------
-- DATA CLEANING --

UPDATE QuickMart
SET availableQuantity = 0
WHERE availableQuantity IS NULL;

UPDATE QuickMart
SET discountPercent = 0
WHERE discountPercent IS NULL;

DELETE FROM QuickMart
WHERE mrp IS NULL;

SELECT name, COUNT(*) AS Total_Records
FROM QuickMart
GROUP BY name
HAVING COUNT(*) > 1;

SELECT *
FROM QuickMart
WHERE mrp = 0
OR discountedSellingPrice = 0
OR availableQuantity = 0;

UPDATE QuickMart
SET mrp = 120
WHERE sku_id = 1001;

SELECT *
FROM QuickMart
WHERE discountedSellingPrice > mrp;

SELECT *
FROM QuickMart
WHERE discountPercent < 0;

SELECT *
FROM QuickMart
WHERE discountPercent > 100;

SELECT *
FROM QuickMart
WHERE availableQuantity < 0;

SELECT *
FROM QuickMart
WHERE weightInGms < 0;

UPDATE QuickMart
SET discountPercent = 20
WHERE sku_id = 1050;

UPDATE QuickMart
SET availableQuantity = 50
WHERE availableQuantity < 0;

-- DATA ANALYSIS --

-- 1. Which are the top 10 most expensive products based on MRP?
SELECT name, category, mrp
FROM QuickMart
ORDER BY mrp DESC
LIMIT 10;
-------------------------------------------------------------------------------
-- 2. Which are the top 10 cheapest products based on MRP?

SELECT name, category, mrp
FROM QuickMart
ORDER BY mrp ASC
LIMIT 10;
-------------------------------------------------------------------------------
-- 3. Which products have the highest discount percentage?

SELECT name, category, discountPercent
FROM QuickMart
ORDER BY discountPercent DESC
LIMIT 10;

-------------------------------------------------------------------------------
-- 4. Which products are currently out of stock?

SELECT name, category
FROM QuickMart
WHERE outOfStock = TRUE;

-------------------------------------------------------------------------------
-- 5. Which category contains the highest number of products?

SELECT category, COUNT(*) AS Total_Products
FROM QuickMart
GROUP BY category
ORDER BY Total_Products DESC;

-------------------------------------------------------------------------------
-- 6. Which category offers the highest average discount?

SELECT category,
ROUND(AVG(discountPercent),2) AS Average_Discount
FROM QuickMart
GROUP BY category
ORDER BY Average_Discount DESC;

-------------------------------------------------------------------------------
-- 7. Which category has the highest total inventory available?

SELECT category,
SUM(availableQuantity) AS Total_Inventory
FROM QuickMart
GROUP BY category
ORDER BY Total_Inventory DESC;

-------------------------------------------------------------------------------
-- 8. Which products have no discount?

SELECT name, category, mrp, discountPercent
FROM QuickMart
WHERE discountPercent = 0;

-------------------------------------------------------------------------------
-- 9. Which products have the maximum difference between MRP and Selling Price?

SELECT name,
category,
mrp,
discountedSellingPrice,
(mrp - discountedSellingPrice) AS Discount_Amount
FROM QuickMart
ORDER BY Discount_Amount DESC
LIMIT 10;

-------------------------------------------------------------------------------
-- 10. Which product names appear multiple times (different pack sizes/variants)?

SELECT name,
COUNT(*) AS Number_of_Variants
FROM QuickMart
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY Number_of_Variants DESC;
---------------------------------------------------------------------------



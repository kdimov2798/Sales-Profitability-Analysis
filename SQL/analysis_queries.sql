SELECT
  `Customer ID` as Customer_ID,
  `Product ID` as Product_ID,
  `Order ID` as Order_ID,
  Segment,
  Category,
  `Sub-Category` as Sub_Category,
  COUNT(*) as Products_Purchased,
  ROUND(SUM(Sales), 2) as Revenue,
  ROUND(SUM(Profit), 2) as Profit,
  CASE
    WHEN AVG(Discount) BETWEEN 0.01 AND 0.1 THEN '1-10%'
    WHEN AVG(Discount) BETWEEN 0.11 AND 0.2 THEN '11-20%'
    WHEN AVG(Discount) BETWEEN 0.21 AND 0.4 THEN '21-40%'
    WHEN AVG(Discount) BETWEEN 0.41 AND 0.6 THEN '41-60%'
    WHEN AVG(Discount) BETWEEN 0.61 AND 1 THEN '61-100%'
    ELSE 'No Discount'
  END AS Discount_Range,
  `Ship Mode` as Ship_Mode,
  `Ship Date` as Ship_Date,
  ROUND(AVG(DATE_DIFF(`Ship Date`, `Order Date`, DAY)), 2) AS Avg_Shipping_Time,
  EXTRACT(YEAR FROM `Order Date`) AS Year,
  EXTRACT(MONTH FROM `Order Date`) AS Month,
  CASE
    WHEN EXTRACT(MONTH FROM `Order Date`) IN (1, 2, 3) THEN 'Q1'
    WHEN EXTRACT(MONTH FROM `Order Date`) IN (4, 5, 6) THEN 'Q2'
    WHEN EXTRACT(MONTH FROM `Order Date`) IN (7, 8, 9) THEN 'Q3'
    WHEN EXTRACT(MONTH FROM `Order Date`) IN (10, 11, 12) THEN 'Q4'
  END AS Quarter
FROM `tactile-temple-444418-c7.portfolioproj1.superstore`
GROUP BY 
  Order_ID, Segment, Category, Sub_Category, Ship_Mode, Ship_Date, `Order Date`, Customer_ID, Product_ID
ORDER BY
  Revenue DESC, Profit DESC;


SELECT
  `Customer ID` as Customer_ID,
  `Customer Name` as Customer_Name,
  Country,
  City,
  State_Province,
  Segment
FROM `tactile-temple-444418-c7.portfolioproj1.superstore`;


SELECT
  `Product ID` as Product_ID,
  `Product Name` as Product_Name,
  Category,
  `Sub-Category` as Sub_Category
FROM `tactile-temple-444418-c7.portfolioproj1.superstore`;


SELECT
  `Order ID` as Order_ID,
  `Order Date` as Order_Date,
  `Ship Date` as Ship_Date,
  `Ship Mode` as Ship_Mode,
  Country,
  Region
FROM `tactile-temple-444418-c7.portfolioproj1.superstore`




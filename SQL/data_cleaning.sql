# DATA CLEANING

# Updating negative stock levels in inventory table

UPDATE `project3.inventory`
SET stock_level = 0 
WHERE stock_level < 0;

# Updating missing restock dates with estimated restock date of 1 month prior

UPDATE `project3.inventory`
SET last_restock_date = DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
WHERE last_restock_date IS NULL;

# Updating 574 rows with negative or NULL revenue values

UPDATE `project3.sales` s
SET s.revenue = ROUND(s.quantity_sold * p.retail_price, 2)
FROM `project3.products` p
WHERE s.product_id = p.product_id
AND s.revenue < 0;

UPDATE `project3.sales` s
SET s.revenue = ROUND(s.quantity_sold * p.retail_price, 2)
FROM `project3.products` p
WHERE s.product_id = p.product_id
AND s.revenue IS NULL;

# Dropping 6 rows with missing quantity_sold data

CREATE OR REPLACE TABLE `project3.sales` AS
SELECT * 
FROM `project3.sales`
WHERE quantity_sold IS NOT NULL;

# Dropping duplicate rows

CREATE OR REPLACE TABLE `project3.sales` AS
WITH sales_cte AS (
  SELECT *, 
    ROW_NUMBER() OVER (PARTITION BY store_id, product_id, sale_date ORDER BY sale_id) AS row_num
  FROM `project3.sales`
)
SELECT * EXCEPT(row_num)
FROM sales_cte
WHERE row_num = 1;

# Updated revenue data that was not rounded properly

UPDATE `project3.sales`
SET revenue = ROUND(revenue, 2)
WHERE revenue <> ROUND(revenue, 2);













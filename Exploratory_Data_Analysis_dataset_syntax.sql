-- EDA Superstore Dataset Using Google BigQuery

-- Number of Distinct Customer name
SELECT count(Distinct Customer_Name) as total_customer_distinct
FROM `superstore-410608.sales_superstore.sales`
	-- 793 number of distinct customer name in the dataset
-- Number of Distinct City
SELECT 
  COUNT(distinct City) AS total_distinct_city
FROM `superstore-410608.sales_superstore.sales`
	-- 529 Number of distinct city in the dataset
-- Number of Distinct State
SELECT 
  COUNT(DISTINCT State) AS Distinct_State_Count
FROM `superstore-410608.sales_superstore.sales`

-- Number of Distinct Segment
SELECT 
  COUNT (DISTINCT Segment) AS total_distinct_segment
FROM `superstore-410608.sales_superstore.sales`

-- Number of Distinct product name
SELECT 
  COUNT(DISTINCT Product_Name) AS total_product_distinct
FROM `superstore-410608.sales_superstore.sales`

-- Number of Distinct Category
SELECT
  COUNT(DISTINCT Category) AS total_category_distinct
FROM `superstore-410608.sales_superstore.sales`

 -- Number of Distinct ship mode
SELECT count(Distinct ship_date) as total_ship_distinct
FROM `superstore-410608.sales_superstore.sales`

-- Number of Distinct Country
SELECT count(Distinct Country) as total_category_distinct
FROM `superstore-410608.sales_superstore.sales`

-- Number of First order and end order
SELECT 
    MIN(Order_Date) AS Min_Date, 
    Max(Order_Date) AS Max_Date
FROM `superstore-410608.sales_superstore.sales`

-- Order date range in dataset
SELECT 
   EXTRACT( DAY FROM (Max(Order_Date) - MIN(Order_Date))) AS Total_Days
FROM `superstore-410608.sales_superstore.sales`

-- Order sales range (sales smallest and largest)
SELECT
  MIN(Sales) AS Min_Sales,
  Max(Sales) AS Max_Sales
FROM `superstore-410608.sales_superstore.sales`

-- Distribution sales dataset (mean and median)
SELECT 
  DISTINCT PERCENTILE_DISC(sales, 0.50) OVER () AS Median,
  ROUND(AVG(Sales) OVER (),2) AS Mean
FROM `superstore-410608.sales_superstore.sales`

-- Distribusi Histogram sales
SELECT
  DISTINCT TRUNC(Sales,-2) AS Sale_Bucket,
  COUNT(*) AS Bucket_Count
FROM `superstore-410608.sales_superstore.sales`
GROUP BY Sale_Bucket
ORDER BY Sale_Bucket;




 -- 1. What was most profitable based on Region, State, City

SELECT 
  DISTINCT Region,
  ROUND(SUM(sales), 2) as total_sales_reg
FROM `superstore-410608.sales_superstore.sales` 
GROUP BY Region
ORDER BY total_sales_reg DESC
  -- West is Region with most profitable

SELECT
  DISTINCT State,
  ROUND(SUM(Sales) OVER(PARTITION BY State), 2) AS sales_state_west_Reg,
  ROUND(SUM(Sales) OVER (),2) AS West_Region_Total, 
  ROUND((SUM(Sales) OVER (PARTITION BY State))/(SUM(Sales) OVER ()),2) AS West_Region_State_Pct
FROM `superstore-410608.sales_superstore.sales` 
WHERE Region = 'West'
ORDER BY sales_state_west_Reg DESC
  -- California was the most profitable state in the western region with a sales total of $446,306.46, 
  -- accunting for 63% of the Western region's total sales

SELECT
  DISTINCT City,
  State,
  ROUND (SUM(Sales) OVER (PARTITION BY City, State), 2) AS Sales_Cal_city_totals,
  ROUND (SUM(Sales) OVER (), 2) AS Cal_State_Total,
  ROUND((SUM(Sales) OVER (PARTITION BY City, State) / SUM(Sales) OVER ()), 2) AS Cal_State_Region_pct
FROM `superstore-410608.sales_superstore.sales`
WHERE State = 'California'
ORDER BY Sales_Cal_city_totals DESC
  -- Los Angeles was most profitable in the California state with a sales $ 173,420.18 
  -- and persentase 39% from total sales in the california city

  -- 2. What was most profitable based on Category and subcategory
-- based on category
SELECT
  DISTINCT Category,
  ROUND(SUM(Sales) OVER (PARTITION BY Category), 2) AS total_sales_cat,
  ROUND(SUM(Sales) OVER (), 2) AS total_sales,
  ROUND((SUM(Sales) OVER (PARTITION BY Category)/ SUM(Sales) OVER ()), 2) AS Contribute_sales
FROM `superstore-410608.sales_superstore.sales`
ORDER BY total_sales_cat DESC LIMIT 3
  -- Technology was most profitable in the category with total sales $ 827,455.00
  -- And Contribute sales is 37%

-- Product name in the technoloy category was most profitable
SELECT
  DISTINCT Product_Name,
  ROUND(SUM(Sales) OVER (PARTITION BY Product_Name), 2) AS tot_sales_tech_cat,
  ROUND(SUM(Sales) OVER (), 2) AS tot_sales_Cat,
  ROUND((SUM(Sales) OVER (PARTITION BY Product_Name) / SUM(Sales) OVER ()), 2) AS Contribute_Sales
FROM `superstore-410608.sales_superstore.sales`
WHERE Category = 'Technology'
ORDER BY tot_sales_tech_cat DESC LIMIT 3
  -- Canon image Class 2200 Advanced Copier product was most profitable in the technology category with sales is $61,599,82
  -- With Contribute sales in the technology category is 7%

-- Based on Sub category
SELECT
  DISTINCT Sub_Category,
  ROUND(SUM(Sales) OVER (PARTITION BY Sub_Category), 2) AS tot_sales_sub_cat,
  ROUND(SUM(Sales) OVER (), 2) AS tot_sales,
  ROUND((SUM(Sales) OVER (PARTITION BY Sub_Category) / SUM(Sales) OVER ()), 2) AS Contribute_Sales
FROM `superstore-410608.sales_superstore.sales`
ORDER BY tot_sales_sub_cat DESC LIMIT 3
  -- Sub Category was most profitable is Phones with total sales is $ 327,782.45
  -- With contribute sales 14%

-- Product name in the Sub category phone was most profitable
SELECT 
  DISTINCT Product_Name,
  ROUND(SUM(Sales) OVER (PARTITION BY Product_Name), 2) AS tot_sales_sub_cat_phone,
  ROUND(SUM(Sales) OVER (), 2) AS tot_sales_sub_cat,
  ROUND((SUM(Sales) OVER (PARTITION BY Product_Name)/SUM(Sales) OVER ()), 2) AS Contribute_sales
FROM `superstore-410608.sales_superstore.sales`
WHERE Sub_Category = 'Phones'
ORDER BY tot_sales_sub_cat_phone DESC LIMIT 3 
  -- Samsung Galaxy Mega 6.3 was most profitable in the sub category phone with total sales is & 13,943.67
  -- With contribute sales is 4%

-- 3. What is the most profitable in the product 

SELECT 
  DISTINCT Product_Name,
  ROUND(SUM(Sales) OVER (PARTITION BY Product_Name), 2) AS tot_sales_product,
  ROUND(SUM(Sales) OVER (), 2) AS tot_sales,
  ROUND((SUM(Sales) OVER (PARTITION BY Product_Name)/SUM(Sales) OVER ()), 2) AS Contribute_sales
FROM `superstore-410608.sales_superstore.sales`
ORDER BY tot_sales_product DESC LIMIT 3 
  -- As a whole was most profitable in the product name is canno image CLASS 2200 Advanced with sales $ 61,599.82 

-- 4. What is the most profitable based on ship mode
-- the shipmode most used by customers
SELECT 
  DISTINCT Ship_Mode,
  COUNT (*) OVER (PARTITION BY Ship_Mode) AS count_ship_mode,
  COUNT (*) OVER () AS total_count_ship,
  ROUND ((COUNT(*) OVER (PARTITION BY Ship_Mode) / COUNT(*) OVER ()), 2) AS Contribute_sales_shipmode
FROM `superstore-410608.sales_superstore.sales`
ORDER BY count_ship_mode DESC LIMIT 3
  -- The most widely used shipping mode is standard class with count is 5,859
  -- And with percentase contribute is 60% 

-- Shipmode which the most profitable
SELECT
  DISTINCT Ship_Mode,
  ROUND(SUM(Sales) OVER (PARTITION BY Ship_Mode), 2) AS Tot_sales_shipmode,
  ROUND(SUM(Sales) OVER (), 2) AS tot_sales,
  ROUND((SUM(Sales) OVER (PARTITION BY Ship_Mode)/SUM(Sales) OVER()), 2) AS Contribute_sales_shipmode
FROM `superstore-410608.sales_superstore.sales`
ORDER BY Tot_sales_shipmode DESC LIMIT 3
  -- Shipmode which the most profitable is Standard Class with sales $ 1,340,831.78 
  -- And percentase contribute is 59% to total sales

-- 5. What the difference in days between the order date and the ship date affect sales?
-- Korelasi between Difference days with sales
SELECT
  ROUND(CORR(Diff_Day, Sales), 2) AS Coefisien_korelasi
FROM 
  (
  SELECT
    Order_date,
    Ship_date,
    DATE_DIFF(Ship_date, Order_date, DAY) AS Diff_Day,
    Sales
  FROM `superstore-410608.sales_superstore.sales`
  )
  -- There is no correlation between the amount of time between order date and shipping date. Indicated in the correlation coeffiienct value -0.01 

-- 6. What was the most profitable by the years
SELECT
  DISTINCT sub.Year,
  ROUND(SUM(Sub.Sales) OVER(PARTITION BY sub.Year), 2) AS tot_sales_year,
  ROUND(SUM(Sub.Sales) OVER(), 2) AS total_sales,
  ROUND((SUM(Sub.Sales) OVER (PARTITION BY sub.Year)/SUM(Sub.Sales) OVER ()), 2) AS Contribute_Sales
FROM (
      SELECT
        EXTRACT(YEAR FROM Order_date) AS Year,
        Sales
      FROM `superstore-410608.sales_superstore.sales`
      ) AS Sub
GROUP BY Sub.Year 
  -- 2018 was recorded as the year with the highest sales in the amount of $ 722,052.02

-- 7. What is the sales trend from year to year?
  
CREATE TEMP TABLE t1 AS
SELECT
  sub1.Year, 
  sub1.Year_Sales_Total,
  COALESCE(ROUND(sub1.Year_Sales_Total - LAG(sub1.Year_sales_total,1) OVER (ORDER BY sub1.Year),2),0) 
  AS YoY_Total_Sales_Change,
  COALESCE(ROUND((sub1.Year_Sales_Total - LAG(sub1.Year_sales_total,1) OVER (ORDER BY sub1.Year))
  /(LAG(sub1.Year_Sales_Total,1) OVER (ORDER BY sub1.Year)),2),0) AS YoY_Total_Sales_Pct_Change
FROM
  (SELECT 
      DISTINCT sub.Year,
      ROUND(SUM(sub.Sales) OVER (PARTITION BY sub.Year),2) AS Year_Sales_Total,
      ROUND(SUM(sub.sales) OVER (),2) AS Total_Sales,
      ROUND((SUM(sub.Sales) OVER (PARTITION BY sub.Year))/( SUM(sub.sales) OVER ()),2) AS Sales_Pct
  FROM
    (SELECT
      EXTRACT(YEAR FROM Order_Date) AS Year,
      Sales
    FROM `superstore-410608.sales_superstore.sales`
    ) AS sub
    ORDER BY Year_Sales_Total DESC
  ) AS sub1
ORDER BY sub1.Year;

SELECT
  ROUND(AVG(t1.Yoy_Total_Sales_Change),2) AS Avg_YoY_Change,
  ROUND(AVG(t1.YoY_Total_Sales_Pct_Change),2) AS Avg_YoY_Pct_Change
FROM t1;

SELECT *
FROM t1







  

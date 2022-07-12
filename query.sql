#First query to match the data entry string in that column

##to look the data before cleaning
SELECT DISTINCT city
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY city

##to convert all strings to capital
SELECT DISTINCT UPPER(city)
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

#Second query to to delete the same value with different writing

##to look the data before cleaning
SELECT DISTINCT category
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

##to remove ".0" in the category column
SELECT DISTINCT REPLACE(category, ".0", "")
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

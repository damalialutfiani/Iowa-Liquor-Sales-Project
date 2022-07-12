#First query to match the data entry string in that column

##to look the data before cleaning
SELECT DISTINCT city
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY city

##to convert all strings to capital
SELECT DISTINCT UPPER(city)
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

#First query to match the data entry string in that column

##to look the data before cleaning
SELECT DISTINCT city
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY city

##to convert all strings to capital
SELECT DISTINCT UPPER(city)
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

#Second query to delete the same value with different writing

##to look the data before cleaning
SELECT DISTINCT category
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

##to remove ".0" in the category column
SELECT DISTINCT REPLACE(category, ".0", "")
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

#Third query to clean the data that has more than one value

##to look the data before cleaning
SELECT DISTINCT REPLACE(category, ".0", ""), UPPER(category_name)
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
ORDER BY 1

##to take just one value from the same nomor identity 
SELECT DISTINCT REPLACE(category, ".0", ""), ANY_VALUE(UPPER(category_name))
FROM `bigquery-public-data.iowa_liquor_sales.sales` 
GROUP BY 1
ORDER BY 1,2

#The whole query is ready to be visualized

SELECT
  date,
  invoice_and_item_number,
  city,
  REPLACE(zip_code, ".0", "") zip_code,
  CASE WHEN bottle_volume_ml BETWEEN 0 AND 500 THEN 'a.Small Size (0-500 ml)'
    WHEN bottle_volume_ml BETWEEN 501 AND 1000 THEN 'b.Medium Size (501-1000 ml)'
    WHEN bottle_volume_ml > 1000 THEN 'c.Large Size (>1000 ml)'
    ELSE null
  END AS category_size_bottle,
  bottles_sold,
  sale_dollars,
  volume_sold_liters,
  store_number,
  county_number,
  REPLACE(category, ".0","") category,
  vendor_number,
  item_number,
  store_location,
  ST_GEOGFROMTEXT(store_location) point_location,
    ST_X(ST_GEOGFROMTEXT(store_location)) as longitude,
    ST_Y(ST_GEOGFROMTEXT(store_location)) as latitude,
  ANY_VALUE(UPPER(store_name)) store_name,
  ANY_VALUE(UPPER(county)) county,
  ANY_VALUE(UPPER(category_name)) category_name,
  ANY_VALUE(UPPER(vendor_name)) vendor_name,
  ANY_VALUE(UPPER(item_description)) item_description,
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE county_number is not null
AND store_number is not null
AND category is not null
AND vendor_number is not null
AND item_number is not null
AND date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14

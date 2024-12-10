/*
#data quality tests

1-Row count test : 100
2-Column coount test: 4
3-Data types : 
     channel_name:varchar
	 total_subsribers:INT
	 total_videos:INT
	 total_views:INT

4-Duplicates : 0

*/

--1. Row count test

SELECT 
   COUNT (*) AS rows_count
FROM 
   view_top_uk_youtubers_2024

--2.Column coount test 

SELECT 
   COUNT(*) AS column_count
FROM 
   INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME ='view_top_uk_youtubers_2024'

--3.Data type test 

SELECT 
   COLUMN_NAME,
   DATA_TYPE
FROM 
   INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME ='view_top_uk_youtubers_2024'

--4.Duplicates check
SELECT 
   channel_name,
   count(*) AS duplicate_count
FROM 
   view_top_uk_youtubers_2024
GROUP BY 
   channel_name
HAVING 
   COUNT(*) >1
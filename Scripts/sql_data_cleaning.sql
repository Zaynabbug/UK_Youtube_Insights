/*
 1-Remove unnecessary columns (slect the ones needed)
 2-Extract ytb channel names from the first columns
 3-rename columns


--select 
--   NOMBRE,
--   total_subscribers,
--   total_views,
--   total_videos
--FROM top_uk_youtubers_2024

---CHARINDEX function:

--SUBSTRING function 
*/

CREATE VIEW view_top_uk_youtubers_2024 AS 
SELECT 
     CAST(SUBSTRING(NOMBRE,1,CHARINDEX('@',NOMBRE)-1) AS VARCHAR(100)) AS channel_name ,
     total_subscribers,
     total_views,
     total_videos
FROM
 top_uk_youtubers_2024


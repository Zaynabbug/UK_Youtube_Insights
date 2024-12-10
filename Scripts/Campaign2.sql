DECLARE @conversionRate FLOAT = 0.02;
DECLARE @salePrice FLOAT = 5.0;
DECLARE @number_videos int = 11;
DECLARE @cotsPerVideo FLOAT = 5000.0;

WITH CTE_AVG AS(
 SELECT 
  channel_name,
  total_views,
  total_videos,
  ROUND(CAST(total_views AS FLOAT)/total_videos,- 4) AS avg_views_video
 FROM 
   view_top_uk_youtubers_2024
)

select
  channel_name,
  total_views,
  total_videos,
  avg_views_video,
  avg_views_video * @conversionRate AS Potential_Product_Sales ,
  (avg_views_video * @conversionRate)* @salePrice AS Potential_Revenue,
  (((avg_views_video * @conversionRate)* @salePrice)) - (@number_videos * @cotsPerVideo)  AS Net_Profit
FROM 
   CTE_AVG
WHERE
   channel_name in ('GRM Daily','Man City','Liverpool FC','YOGSCAST Lewis & Simon')
ORDER BY
   Net_Profit DESC

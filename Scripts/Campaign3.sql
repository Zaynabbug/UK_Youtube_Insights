DECLARE @conversionRate FLOAT = 0.02;
DECLARE @salePrice FLOAT = 5.0;
DECLARE @campaignCost FLOAT = 130000.0;

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
  (avg_views_video * @conversionRate* @salePrice)- @campaignCost  AS Net_Profit
FROM 
   CTE_AVG
WHERE
   channel_name in ('DanTDM','Dan Rhodes','Mister Max')
ORDER BY
   Net_Profit DESC
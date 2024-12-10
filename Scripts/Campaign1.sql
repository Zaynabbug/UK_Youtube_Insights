
DECLARE @conversionRate Float = 0.02;
DECLARE @productPrice MONEY= 5.0;
DECLARE @CampaignCost MONEY = 50000.0;


with CTE AS (
SELECT 
  channel_name,
  total_subscribers,
  total_views,
  total_videos,
  ROUND((CAST(total_views AS FLOAT)/ total_videos),-4) AS avg_views_per_vid 

FROM view_top_uk_youtubers_2024
)

Select 
  channel_name,
  total_subscribers,
  total_views,
  total_videos,
  avg_views_per_vid ,
  (avg_views_per_vid * @conversionRate) AS Potential_Product_Sales_per_Video,
  (avg_views_per_vid * @conversionRate * @productPrice ) AS Potential_Revenue_per_Video,
  (avg_views_per_vid * @conversionRate * @productPrice ) - @CampaignCost AS NET_profit

From
  CTE
WHERE 
  channel_name IN ('NoCopyrightSounds','DanTDM','Dan Rhodes')

ORDER BY
  NET_profit DESC

 

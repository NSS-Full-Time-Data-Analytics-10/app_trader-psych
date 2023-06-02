--Highest Review Count Including Name, Rating, and Price From Both Apps
SELECT app_store_apps.name, app_store_apps.review_count ::numeric, app_store_apps.rating, app_store_apps.price
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
GROUP BY app_store_apps.name, app_store_apps.review_count, app_store_apps.rating,app_store_apps.price
ORDER BY app_store_apps.review_count :: numeric DESC
LIMIT 1;

--Highest Priced App From Both Apps
SELECT app_store_apps.name, app_store_apps.review_count ::numeric, app_store_apps.rating, app_store_apps.price
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
GROUP BY app_store_apps.name, app_store_apps.review_count, app_store_apps.rating,app_store_apps.price
ORDER BY app_store_apps.price DESC
LIMIT 5;

--AVG Ratings Per App
(SELECT AVG(app_store_apps.rating)
FROM app_store_apps)
--AVG app_store_apps rating = 3.527
SELECT AVG(play_store_apps.rating)
FROM play_store_apps;
--AVG play_store_apps rating = 4.192


WITH first_edit AS (SELECT DISTINCT app_store_apps.name, app_store_apps.price, app_store_apps.rating, app_store_apps.review_count::integer
					FROM app_store_apps
					INNER JOIN play_store_apps
					USING(name)
					WHERE app_store_apps.price>0 AND app_store_apps.review_count::integer >10000
					ORDER BY app_store_apps.review_count::integer DESC)
SELECT ROUND(first_edit.rating,25)
FROM first_edit

--b. Develop a Top 10 List of the apps that App Trader should buy based on profitability/return on investment as the sole priority.
--appears on both stores and higher the rating the higher of the apps longevity
SELECT DISTINCT app_store_apps.name,app_store_apps.rating AS Apple_store,play_store_apps.rating AS Google_store,
app_store_apps.review_count::numeric, primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric, primary_genre,app_store_apps.price, play_store_apps.price
ORDER BY app_store_apps.rating DESC,play_store_apps.rating DESC
LIMIT 10;

--c. c. Develop a Top 4 list of the apps that App Trader should buy that are profitable but that also are thematically appropriate for the upcoming 
--Fourth of July themed campaign.
SELECT DISTINCT app_store_apps.name,app_store_apps.rating AS Apple_store,play_store_apps.rating AS Google_store,
app_store_apps.review_count::numeric, primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
	  AND name ILIKE '%blast%' OR name ILIKE'%Domino%' OR name ILIKE '%Where%'
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric, primary_genre,app_store_apps.price, play_store_apps.price
ORDER BY app_store_apps.rating DESC,play_store_apps.rating DESC;





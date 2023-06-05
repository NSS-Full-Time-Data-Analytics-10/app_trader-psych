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

--a. Develop some general recommendations about the price range, genre, content rating, or any other app characteristics that the company should target.
SELECT
  DISTINCT app_store_apps.name AS top_10,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 12 AS projected_lifespan,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 5000 AS monthly_revenue,
  greatest((LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 5000 - 1000, 0) AS monthly_profit,
  app_store_apps.primary_genre,
  CASE
    WHEN app_store_apps.price <= 2.5 THEN 25000
    ELSE app_store_apps.price * 10000
  END AS purchase_cost,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 5000 * (LEAST(greatest(app_store_apps.rating, 0), 4) * 2 + 1) * 12 AS potential_profit
FROM
  app_store_apps
 JOIN play_store_apps USING (name)
ORDER BY
  potential_profit DESC
LIMIT 10;

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
--Option 1
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

--Option 2
SELECT DISTINCT app_store_apps.name, app_store_apps.rating, app_store_apps.review_count::integer, app_store_apps.content_rating
FROM
 app_store_apps
INNER JOIN play_store_apps USING (name)
WHERE
  app_store_apps.review_count::integer > 10000
  AND app_store_apps.name ILIKE '%Toy Blast' OR app_store_apps.name ILIKE '%Angry Birds Blast%' OR app_store_apps.name ILIKE '%Domin%' OR app_store_apps.name ILIKE 'MARVEL Contest of %Champ%'
ORDER BY app_store_apps.review_count::integer DESC,app_store_apps.name,app_store_apps.rating, app_store_apps.content_rating
LIMIT 4;
--includes content rating



SELECT *
FROM play_store_apps
ORDER BY review_count::numeric DESC;

SELECT DISTINCT a.name,a.rating AS app_store_rating,
a.price::money,a.primary_genre,p.rating AS play_store_rating
FROM app_store_apps AS a
JOIN play_store_apps AS p
USING (name)
WHERE a.price = 0
GROUP BY a.name,a.rating,a.rating,
a.price::money,a.primary_genre,p.rating
ORDER BY a.rating DESC, p.rating DESC;

(SELECT name, AVG(review_count)
FROM play_store_apps
GROUP BY name);

SELECT DISTINCT app_store_apps.name, app_store_apps.rating, app_store_apps.review_count::integer
FROM
 app_store_apps
INNER JOIN play_store_apps USING (name)
WHERE
  app_store_apps.primary_genre LIKE '%Games%'
  AND app_store_apps.review_count::integer > 10000
ORDER BY app_store_apps.review_count::integer DESC,app_store_apps.name,app_store_apps.rating
LIMIT 100;

SELECT name, a.rating, p.rating, ROUND(a.review_count::integer + pr.reviews, 0) AS total_reviews
FROM app_store_apps AS a
INNER JOIN (SELECT name, AVG(review_count) AS reviews
FROM play_store_apps
GROUP BY name) AS pr
USING (name)
INNER JOIN play_store_apps AS p
USING (name)
GROUP BY name, a.rating, p.rating, total_reviews
ORDER BY a.rating DESC, p.rating DESC;


WITH top_10_apps AS (SELECT name, 
app.rating AS app_rating, 
ROUND(play.rating/25,2)*25 AS play_rating, 
ROUND(((app.rating + play.rating)/2)/25,2)*25 AS avg_rating,
genres, 
primary_genre,
play.price::NUMERIC + app.price AS price, 
CAST(TRIM(TRAILING '+' FROM REPLACE(install_count, ',', '')) AS integer) AS installation_count
FROM app_store_apps AS app
INNER JOIN play_store_apps AS play
USING (name)
WHERE app.rating >= 4.5 AND play.rating >= 4.5
AND play.price = '0' AND app.price = 0
AND primary_genre LIKE 'Games'
AND app.review_count::NUMERIC > (SELECT AVG(review_count::NUMERIC) FROM app_store_apps)
AND play.review_count > (SELECT AVG(review_count) FROM play_store_apps)
AND app.content_rating LIKE '4+'
AND play.content_rating LIKE 'Everyone'
AND CAST(TRIM(TRAILING '+' FROM REPLACE(install_count, ',', '')) AS integer) > 50000000
GROUP BY name, app.rating, play.rating, genres, primary_genre, play.price, app.price, installation_count
ORDER BY app_rating DESC, play_rating DESC)

SELECT name, ROUND((((avg_rating/.25)*6)/12)+1,2) AS years_in_store, 
(price + 25000)::MONEY AS intial_cost,
(((((avg_rating/.25)*6)/12)+1) * 1000)::MONEY AS total_advertising_cost,
(price + 25000)::MONEY + (((((avg_rating/.25)*6)/12)+1) * 1000)::MONEY AS total_cost,
((((avg_rating/.25)*6)/12)+1)*12*5000::MONEY AS revenue,
(((((avg_rating/.25)*6)/12)+1)*12*5000)::MONEY - ((price + 25000)::MONEY + (((((avg_rating/.25)*6)/12)+1) * 1000)::MONEY) AS profit
FROM top_10_apps;


SELECT
  app_store_apps.name AS top_10,
  (LEAST(greatest(app_store_apps.rating, 0), 4) * 2 + 1) * 6 AS projected_lifespan,
  (LEAST(greatest(app_store_apps.rating, 0), 4) * 2 + 1) * 5000 AS monthly_revenue,
  greatest((LEAST(greatest(app_store_apps.rating, 0), 4) * 2 + 1) * 5000 - 1000, 0) AS monthly_profit,
  CASE
    WHEN app_store_apps.price <= 2.5 THEN 25000
    ELSE app_store_apps.price * 10000
  END AS purchase_cost,
  (LEAST(greatest(app_store_apps.rating, 0), 4) * 2 + 1) * 5000 * (LEAST(greatest(app_store_apps.rating, 0), 4) * 2 + 1) * 6 AS potential_profit
FROM
  app_store_apps
 JOIN play_store_apps USING (name)
ORDER BY
  potential_profit DESC
LIMIT 10;


SELECT
  DISTINCT app_store_apps.name AS top_10,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 12 AS projected_lifespan,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 12 * 5000 AS total_revenue,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 12 * 4000 - CASE
    WHEN app_store_apps.price <= 2.5 THEN 25000
    ELSE app_store_apps.price * 10000 END AS total_profit,
	app_store_apps.primary_genre
FROM
  app_store_apps
 JOIN play_store_apps USING (name)
ORDER BY
  total_profit DESC
LIMIT 10;






--filter for 4th of july
--WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
--      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
--	  AND name ILIKE 'toy blast' OR name ILIKE '%angry birds blast'
--	  OR name ILIKE 'bible' OR name ILIKE 'Domi%'


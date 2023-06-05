SELECT DISTINCT app_store_apps.name,app_store_apps.review_count::numeric AS app_review,app_store_apps.rating AS app_store_rating,
app_store_apps.price::money,app_store_apps.primary_genre,play_store_apps.rating AS play_store_rating
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
GROUP BY app_store_apps.name,app_store_apps.review_count::numeric,app_store_apps.rating,app_store_apps.rating,
app_store_apps.price::money,app_store_apps.primary_genre,play_store_apps.rating
ORDER BY app_store_apps.rating DESC, play_store_apps.rating DESC;


SELECT DISTINCT name AS play_name,rating
FROM app_store_apps
GROUP BY name,rating
ORDER BY rating DESC 

SELECT DISTINCT name AS play_name,play_store_apps.rating,app_store_apps.rating
FROM play_store_apps
INNER JOIN app_store_apps
USING (name)
GROUP BY name,play_store_apps.rating ,app_store_apps.rating
ORDER BY play_store_apps.rating DESC NULLS LAST

SELECT DISTINCT app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric
ORDER BY app_store_apps.rating DESC,play_store_apps.rating DESC
LIMIT 10;

SELECT DISTINCT app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating, app_store_apps.primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating, app_store_apps.primary_genre
ORDER BY app_store_apps.rating DESC,play_store_apps.rating DESC,
app_store_apps.content_rating DESC;

SELECT DISTINCT app_store_apps.price::money,app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating, app_store_apps.primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
ORDER BY  price DESC;

SELECT DISTINCT app_store_apps.price::money,app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating, app_store_apps.primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)

SELECT DISTINCT app_store_apps.name,app_store_apps.price::money,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating, app_store_apps.primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND play_Store_apps.rating>=4.5
ORDER BY app_store_apps.rating,play_Store_apps.rating

SELECT DISTINCT app_store_apps.name,app_store_apps.price::money,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating, app_store_apps.primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING(name)
WHERE app_store_apps.price>='4.99' AND app_store_apps.rating>=4.5
                                   AND play_store_apps.rating>=4.5

SELECT DISTINCT app_store_apps.name,app_store_apps.price,app_store_apps.rating
FROM app_store_apps
INNER JOIN play_store_apps
USING(name)
WHERE app_store_apps.price=0 AND app_store_apps.review_count::numeric>100000
ORDER BY app_store_apps.rating  DESC;

WITH first_edit AS(SELECT DISTINCT app_store_apps.name,app_store_apps.price,app_store_apps.rating
				FROM app_store_apps
				INNER JOIN play_store_apps
				USING(name)
				WHERE app_store_apps.price=0 AND app_store_apps.review_count::numeric>100000
				ORDER BY app_store_apps.rating  DESC)
				
SELECT first_edit.name,first_edit.rating
FROM first_edit

SELECT DISTINCT app_store_apps.name
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)

SELECT DISTINCT app_store_apps.name,app_store_apps.price::money,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,REPLACE(app_store_apps.content_rating,'+','')::numeric, app_store_apps.primary_genre
FROM app_store_apps
INNER JOIN play_store_apps
USING(name)
WHERE app_store_apps.price>='4.99' AND app_store_apps.rating>=4.5
                                   AND play_store_apps.rating>=4.5
								   
SELECT DISTINCT app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,REPLACE(app_store_apps.content_rating,'+','')::numeric AS rating
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating
ORDER BY app_store_apps.rating DESC,play_store_apps.rating DESC
LIMIT 10;

SELECT DISTINCT app_store_apps.name,ROUND(AVG(app_store_apps.rating+play_store_apps.rating)/2,2) AS avg_rating,
app_store_apps.review_count::numeric,REPLACE(app_store_apps.content_rating,'+','')::numeric AS content_rating,
play_store_apps.genres
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
	  AND genres LIKE 'Puzzle' OR genres LIKE 'Arcade'
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating,play_store_apps.genres
ORDER BY avg_rating
LIMIT 10;

SELECT DISTINCT app_store_apps.name,ROUND(AVG(app_store_apps.rating+play_store_apps.rating)/2,2) AS avg_rating,
app_store_apps.review_count::numeric,REPLACE(app_store_apps.content_rating,'+','')::numeric AS content_rating,
play_store_apps.genres,
CASE WHEN app_store_apps.rating<=2.5 THEN 25000
ELSE app_store_apps.rating*10000 END AS purchase_cost
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
	  AND genres LIKE 'Arcade'
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating,play_store_apps.genres
ORDER BY avg_rating
LIMIT 10;

SELECT DISTINCT app_store_apps.name AS top_4,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,REPLACE(app_store_apps.content_rating,'+','')::numeric AS content_rating,
play_store_apps.genres,
CASE WHEN app_store_apps.rating<=2.5 THEN 25000
ELSE app_store_apps.rating*10000 END AS purchase_cost
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
	  AND name ILIKE 'toy blast' OR name ILIKE '%angry birds blast'
	  OR name ILIKE '%champ%' OR name ILIKE 'Domi%'
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.content_rating,play_store_apps.genres
ORDER BY play_store_apps.rating
LIMIT 4;

SELECT DISTINCT app_store_apps.name,app_store_apps.rating, app_store_apps.review_count::integer
FROM
 app_store_apps
INNER JOIN play_store_apps USING (name)
WHERE
  app_store_apps.review_count::integer > 10000
  AND app_store_apps.name ILIKE '%Toy Blast' OR app_store_apps.name ILIKE '%Angry Birds Blast%' OR app_store_apps.name ILIKE '%Domin%' OR app_store_apps.name ILIKE 'MARVEL Contest of %Champ%'
ORDER BY app_store_apps.review_count::integer DESC,app_store_apps.name,app_store_apps.rating
LIMIT 4;

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
LIMIT 50;

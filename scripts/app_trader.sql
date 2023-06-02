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
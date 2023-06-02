---- use distinct name, 
--- use weighted value for review_counts( what number is)and rating

SELECT *
FROM app_store_apps;

SELECT *
FROM play_store_apps;


SELECT DISTINCT app_store_apps.name,app_store_apps.review_count::numeric,app_store_apps.rating
FROM app_store_apps
INNER JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
GROUP BY app_store_apps.name, app_store_apps.review_count,app_store_apps.rating
ORDER BY app_store_apps.review_count::numeric DESC;





SELECT play_store_apps.name, play_store_apps.review_count AS google_review_count, app_store_apps.review_count::numeric AS apple_review_count
from app_store_apps
INNER JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
ORDER BY play_store_apps.review_count DESC;

SELECT *
from app_store_apps
INNER JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
ORDER BY play_store_apps.rating DESC, app_store_apps.rating DESC

SELECT play_store_apps.name, play_store_apps.review_count AS google_review_count, app_store_apps.review_count::numeric AS apple_review_count
from app_store_apps
LEFT JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
ORDER BY play_store_apps.review_count DESC
NULLS LAST;

SELECT *
from app_store_apps
INNER JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
ORDER BY play_store_apps.review_count DESC;



SELECT app_store_apps.name,play_store_apps.name, app_store_apps.content_rating,play_store_apps.content_rating
from app_store_apps
LEFT JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
GROUP BY app_store_apps.name, play_store_apps.name,app_store_apps.content_rating,play_store_apps.content_rating
ORDER BY app_store_apps.content_rating ASC ,play_store_apps.content_rating ASC;




SELECT DISTINCT play_store_apps.name AS google_name, app_store_apps.name AS apple_name
from app_store_apps
INNER JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
GROUP BY genre

---

SELECT DISTINCT app_store_apps.name,app_store_apps.rating AS app_store_rating,
app_store_apps.price::money,app_store_apps.primary_genre,play_store_apps.rating AS play_store_rating
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
GROUP BY app_store_apps.name,app_store_apps.rating,app_store_apps.rating,
app_store_apps.price::money,app_store_apps.primary_genre,play_store_apps.rating

SELECT DISTINCT name, review_count::numeric
FROM  app_store_apps
ORDER BY review_count DESC;



-- maybe subquery to selefct
 
(SELECT DISTINCT name, review_count::numeric
FROM play_store_apps
ORDER BY review_count DESC
LIMIT 1

SELECT app_store.apps.name, app_store_apps.rating,play_store_apps.rating,
 app_store_apps.review_count::numeric
FROM 
 
 --- primary target is games ( micro transactions are the bane of existence)
--- count monthly average, make new column formatting profitability 		
 
 
 SELECT DISTINCT app_store_apps.name AS top_ten_apps,ROUND(app_store_apps.rating [0.25]),ROUND(play_store_apps.rating[0.25]),
app_store_apps.review_count::numeric, app_store_apps.primary_genre, app_store_apps.content_rating
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.primary_genre, app_store_apps.content_rating
ORDER BY app_store_apps.rating DESC,play_store_apps.rating DESC;
 
 
 
 
 -- 4th of July ideas ; Toy Blast, Angry Birds Blast, Marvel, 

 
 SELECT DISTINCT app_store_apps.name, app_store_apps.rating AS apple_rating, play_store_apps.rating AS google_play,
app_store_apps.review_count::numeric
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric
ORDER BY app_store_apps.review_count::numeric DESC, app_store_apps.name

-- code for name, not free, ratings,  and review count > 10000
 
 WITH first_edit AS (SELECT DISTINCT app_store_apps.name,app_store_apps.price, app_store_apps.rating, app_store_apps.review_count::integer
 					FROM app_store_apps
 					INNER JOIN play_store_apps
 					USING (name)
 					WHERE app_store_apps.price > 0 AND app_store_apps.review_count::integer > 10000
 					ORDER BY app_store_apps.review_count::integer DESC
 
 

	-- 	rounding practice examples t/e			 
 
  WITH first_edit AS SELECT DISTINCT app_store_apps.name,app_store_apps.price, app_store_apps.rating, app_store_apps.review_count::integer
 					FROM app_store_apps
 					INNER JOIN play_store_apps
 					USING (name)
 					WHERE app_store_apps.price > 0 AND app_store_apps.review_count::integer > 10000
 					ORDER BY app_store_apps.review_count::integer DESC
 
 SELECT (CAST (ROUND(first_edit.rating / 0.25, 2) AS int)) * 0.25
 FROM first_edit

 
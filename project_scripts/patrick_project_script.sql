
--Review count highest to lowest
SELECT DISTINCT app_store_apps.name,app_store_apps.review_count::numeric,app_store_apps.rating
FROM app_store_apps
INNER JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
GROUP BY app_store_apps.name, app_store_apps.review_count,app_store_apps.rating
ORDER BY app_store_apps.review_count::numeric DESC;


-- Content rating ordered 
SELECT app_store_apps.name,play_store_apps.name, app_store_apps.content_rating,play_store_apps.content_rating
from app_store_apps
LEFT JOIN play_store_apps ON app_store_apps.name = play_store_apps.name
GROUP BY app_store_apps.name, play_store_apps.name,app_store_apps.content_rating,play_store_apps.content_rating
ORDER BY app_store_apps.content_rating ASC ,play_store_apps.content_rating ASC;







-- apps with 4.5 rating or higher on joined table
SELECT DISTINCT app_store_apps.name,app_store_apps.rating AS app_store_rating,
app_store_apps.price::money,app_store_apps.primary_genre,play_store_apps.rating AS play_store_rating
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating >= 4.5
GROUP BY app_store_apps.name,app_store_apps.rating,app_store_apps.rating,
app_store_apps.price::money,app_store_apps.primary_genre,play_store_apps.rating;


-- Apple apps ordered by review count
SELECT DISTINCT name, review_count::numeric
FROM  app_store_apps
ORDER BY review_count DESC;




 
-- primary target is games ( micro transactions are the bane of existence)
-- count monthly average, make new column formatting profitability 		
 
-- TOP 10 listed and ordered by review count and > 4.5 rating
 SELECT DISTINCT app_store_apps.name AS top_ten_apps,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric, app_store_apps.primary_genre, app_store_apps.content_rating
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE app_store_apps.rating>=4.5 AND app_store_apps.review_count::numeric>'10000'
      AND play_store_apps.rating>=4.5 AND play_store_apps.review_count>10000
GROUP BY app_store_apps.name,app_store_apps.rating,play_store_apps.rating,
app_store_apps.review_count::numeric,app_store_apps.primary_genre, app_store_apps.content_rating
ORDER BY app_store_apps.review_count::numeric DESC
LIMIT 10;
 
 
 
 
 
 -- 4th of July ideas ; Toy Blast, Angry Birds Blast, Marvel, Dominos  
 -- filtering out top 10 apps based on review counts
 
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
LIMIT 10;

-- code for name, not free, ratings,  and review count > 10000
 
 SELECT DISTINCT app_store_apps.name,app_store_apps.price, app_store_apps.rating, app_store_apps.review_count::integer
 					FROM app_store_apps
 					INNER JOIN play_store_apps
 					USING (name)
 					WHERE app_store_apps.price > 0 AND app_store_apps.review_count::integer > 10000
 					ORDER BY app_store_apps.review_count::integer DESC;
 
 
-- 	CTE practice.	 
 
  WITH first_edit AS (SELECT DISTINCT app_store_apps.name,app_store_apps.price, app_store_apps.rating, app_store_apps.review_count::integer
 					FROM app_store_apps
 					INNER JOIN play_store_apps
 					USING (name)
 					WHERE app_store_apps.price > 0 AND app_store_apps.review_count::integer > 10000
 					ORDER BY app_store_apps.review_count::integer DESC)
 
 SELECT *
 FROM first_edit;

					 
	-- 4th of July options targeting - games		 4th of July ideas ; Toy Blast, Angry Birds Blast, Marvel, Dominos 	 
					 
SELECT DISTINCT app_store_apps.name, app_store_apps.rating, app_store_apps.review_count::integer,app_store_apps.content_rating
FROM
 app_store_apps
INNER JOIN play_store_apps USING (name)
WHERE
  app_store_apps.review_count::integer > 10000
  AND app_store_apps.name ILIKE '%Toy Blast' OR app_store_apps.name ILIKE '%Angry Birds Blast%' OR app_store_apps.name ILIKE '%Domin%' OR app_store_apps.name ILIKE 'MARVEL Contest of %Champ%'

ORDER BY app_store_apps.review_count::integer DESC,app_store_apps.name,app_store_apps.rating
LIMIT 4;
					 
					 



-- filtering ideas for projected life_span, monthly_revenue,month_profit

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

-- Profitablity predictions based solely on Games genre
 
 SELECT
  DISTINCT app_store_apps.name AS top_10,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 12 AS projected_lifespan,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 12 * 5000 AS total_revenue,
  (LEAST(greatest(app_store_apps.rating, 0), 5) * 2 + 1) * 12 * 4000 - CASE
    WHEN app_store_apps.price <= 2.5 THEN 25000
    ELSE app_store_apps.price * 10000 END AS total_profit
FROM
  app_store_apps
 JOIN play_store_apps USING (name)
WHERE primary_genre LIKE 'Games'
ORDER BY
total_profit DESC
LIMIT 10;


--example table using AI help, not real analysis work
SELECT name, size_bytes, currency, price_text, rating, content_rating, genre, total_review_count
FROM (
    SELECT DISTINCT ON (name)
        name,
        size_bytes,
        currency,
        price_text,
        rating,
        content_rating,
        genre,
        SUM(review_count_numeric) AS total_review_count
    FROM (
        SELECT
            name,
            size_bytes,
            currency,
            price::text AS price_text,
            rating,
            content_rating,
            primary_genre AS genre,
            CASE
                WHEN price::text ~ '^\\$[0-9]' THEN CAST(REPLACE(price::text, '$', '') AS NUMERIC)
                ELSE NULL
            END AS price_numeric,
            CASE
                WHEN review_count::text ~ '^[0-9]+$' THEN CAST(review_count AS NUMERIC)
                ELSE NULL
            END AS review_count_numeric
        FROM app_store_apps

        UNION ALL

        SELECT
            name,
            NULL AS size_bytes,
            NULL AS currency,
            price::text AS price_text,
            rating,
            content_rating,
            genres AS primary_genre,
            NULL AS price_numeric,
            CASE
                WHEN review_count::text ~ '^[0-9]+$' THEN CAST(review_count AS NUMERIC)
                ELSE NULL
            END AS review_count_numeric
        FROM play_store_apps
    ) AS combined_apps
    GROUP BY
        name,
        size_bytes,
        currency,
        price_text,
        rating,
        content_rating,
        genre
) AS distinct_apps
ORDER BY total_review_count DESC;


SELECT DISTINCT a.name,a.rating AS app_store_rating,
a.price::money,a.primary_genre,p.rating AS play_store_rating
FROM app_store_apps AS a
JOIN play_store_apps AS p
USING (name)
WHERE a.price = 0
GROUP BY a.name,a.rating,a.rating,
a.price::money,a.primary_genre,p.rating
ORDER BY a.rating DESC, p.rating DESC;

SELECT DISTINCT name, app_store_rating, play_store_rating, price, primary_genre
FROM (
	SELECT name, rating AS app_store_rating, NULL AS price, NULL AS primary_genre, rating AS play_store_rating
	FROM app_store_apps
	WHERE price = 0

	UNION ALL

	SELECT DISTINCT name, 0 AS app_store_rating, rating AS play_store_rating, NULL AS price, 0 AS primary_genre
	FROM play_store_apps
	WHERE NAME IN (
		SELECT name
		FROM app_store_apps
		WHERE price = 0
		)
)AS apps;


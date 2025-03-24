WITH years AS (
    SELECT year
    FROM raw.disease_mortality
    ORDER BY year ASC
)

SELECT *
FROM years
WHERE year = ( SELECT MIN(year) FROM years);


SELECT *
FROM raw.disease_mortality
ORDER BY year ASC;

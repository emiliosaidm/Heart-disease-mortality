SELECT location_id, COUNT(location_id) AS concurrencia
FROM raw.disease_mortality
GROUP BY location_id
HAVING  COUNT(location_id) = 0;

SELECT *
FROM raw.disease_mortality;

SELECT y_lat, x_lon, COUNT(*) AS concurrencia
FROM raw.disease_mortality
GROUP BY y_lat, x_lon;


-- data_value, location_id, y_lat, x_lat, year

SELECT "data_value_type", COUNT("data_value_type")
FROM raw.disease_mortality
GROUP BY "data_value_type"
HAVING  COUNT("data_value_type") > 0
ORDER BY COUNT("data_value_type") DESC;



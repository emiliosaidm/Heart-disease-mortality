-- data_value, location_id, y_lat, x_lat, year

SELECT MIN(data_value) AS min_data_value,
       MAX(data_value) AS max_data_value,
       AVG(data_value) AS avg_data_value,
       MIN(year) AS min_year,
       MAX(year) AS max_year,
       AVG(year::Numeric) AS avg_year,
       MIN(y_lat) AS min_y_lat,
       MAX(y_lat) AS max_y_lat,
       AVG(y_lat) AS avg_y_lat,
       MIN(x_lon) AS min_x_lon,
       MAX(x_lon) AS max_x_lon,
       AVG(x_lon) AS avg_x_lon,
    MIN(location_id) AS location_id,
       MAX(location_id) AS location_id,
       AVG(location_id) AS location_id

FROM raw.disease_mortality;
-- Eliminamos, si es que ya existe, el schema "clean" y luego lo creamos.
DROP SCHEMA IF EXISTS clean;
CREATE SCHEMA clean;

-- Eliminamos, si es que ya existe, la tabla en el schema "clean.disease_mortality" y luego la creamos.
DROP TABLE IF EXISTS clean.disease_mortality;
CREATE TABLE clean.disease_mortality (
    year VARCHAR(4),
    location_abbr VARCHAR(2),
    location_description VARCHAR(100),
    geographic_level VARCHAR(50),
    data_source VARCHAR(10),
    data_value DOUBLE PRECISION,
    data_value_unit VARCHAR(150),
    data_value_type VARCHAR(150),
    stratification_category1 VARCHAR(10),
    stratification1 VARCHAR(10),
    stratification_category2 VARCHAR(50),
    stratification2 VARCHAR(50),
    location_id INTEGER,
    y_lat DOUBLE PRECISION,
    x_lon DOUBLE PRECISION
);

INSERT INTO clean.disease_mortality(
  year,
  location_abbr,
  location_description,
  geographic_level,
  data_source,
  data_value,
  data_value_unit,
  data_value_type,
  stratification_category1,
  stratification1,
  stratification_category2,
  stratification2,
  location_id,
  y_lat,
  x_lon
)
SELECT year,
  location_abbr,
  location_description,
  geographic_level,
  data_source,
  data_value,
  data_value_unit,
  data_value_type,
  stratification_category1,
  stratification1,
  stratification_category2,
  stratification2,
  location_id,
  y_lat,
  x_lon
FROM raw.disease_mortality;


SELECT *
FROM clean.disease_mortality;

SELECT *
FROM clean.disease_mortality
WHERE "topic" ='Cardiovascular Diseases';

-- Crear las tablas y relacionarlas para poder normalizar los datos.
DROP SCHEMA IF EXISTS normalized;
CREATE SCHEMA normalized;

DROP TABLE IF EXISTS normalized.location;
CREATE TABLE normalized.location(
    id BIGSERIAL PRIMARY KEY,
    abbreviation VARCHAR(5) NOT NULL,
    description varchar(200) NOT NULL,
    y_lat double precision,
    x_lon  double precision,
    geografic_level varchar(20) NOT NULL
);

DROP TABLE IF EXISTS normalized.data_recollection;
CREATE TABLE normalized.data_recollection(
    id BIGSERIAL PRIMARY KEY,
    unit varchar(20) NOT NULL,
    value double precision NOT NULL,
    type varchar(200) NOT NULL,
    source varchar(200) NOT NULL,
    year int NOT NULL,
    location_id bigint NOT NULL CONSTRAINT fk_location_id REFERENCES normalized.location (id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS normalized.stratification;
CREATE TABLE normalized.stratification(
    id BIGSERIAL PRIMARY KEY,
    category varchar(25) NOT NULL,
    value varchar(200) NOT NULL
);

DROP TABLE IF EXISTS normalized.heart_disease_stratification;

CREATE TABLE normalized.heart_disease_stratification(
    id BIGSERIAL PRIMARY KEY,
    data_recollection_id BIGINT NOT NULL CONSTRAINT fk_data_recollection_id REFERENCES normalized.data_recollection (id) ON DELETE CASCADE,
    stratification_id BIGINT NOT NULL CONSTRAINT fk_stratification_id REFERENCES normalized.stratification (id) ON DELETE CASCADE
);

-- Copiar los datos a la forma normalizada

INSERT INTO normalized.location(abbreviation, description, y_lat, x_lon, geografic_level)
SELECT DISTINCT location_abbr, location_description, y_lat, x_lon, geographic_level
FROM clean.disease_mortality;

SELECT data_value_unit, data_value, data_value_type, data_source, year
FROM clean.disease_mortality;

SELECT COUNT(*)
FROM clean.disease_mortality
WHERE data_value IS NULL;

SELECT COUNT(*)
FROM clean.disease_mortality;

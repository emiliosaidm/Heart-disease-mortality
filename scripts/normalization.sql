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
    unit varchar(100) NOT NULL,
    value double precision NOT NULL,
    type varchar(200) NOT NULL,
    source varchar(200) NOT NULL,
    year varchar(4) NOT NULL,
    stratification_category1 varchar(100),
    stratification_category2 varchar(100),
    stratification1 varchar(100),
    stratification2 varchar(100),
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

INSERT INTO normalized.data_recollection(unit, value, type, source, year, stratification_category1, stratification1, stratification_category2, stratification2, location_id)
SELECT data_value_unit, data_value, data_value_type, data_source, year,  clean.disease_mortality.stratification_category1, clean.disease_mortality.stratification1, clean.disease_mortality.stratification_category2, clean.disease_mortality.stratification2, normalized.location.id
FROM clean.disease_mortality
JOIN normalized.location ON
    normalized.location.abbreviation = clean.disease_mortality.location_abbr
        AND normalized.location.description = clean.disease_mortality.location_description
        AND  normalized.location.geografic_level = clean.disease_mortality.geographic_level;

INSERT INTO normalized.stratification(category, value)
SELECT DISTINCT stratification_category1, stratification1
FROM clean.disease_mortality;

INSERT INTO normalized.stratification(category, value)
SELECT DISTINCT stratification_category2, stratification2
FROM clean.disease_mortality;

INSERT INTO normalized.heart_disease_stratification(data_recollection_id, stratification_id)
SELECT normalized.data_recollection.id, normalized.stratification.id
FROM normalized.data_recollection
JOIN normalized.stratification
    ON (normalized.data_recollection.stratification_category1 = normalized.stratification.category AND normalized.data_recollection.stratification1 =  normalized.stratification.value)
    OR (normalized.data_recollection.stratification_category2 = normalized.stratification.category AND normalized.data_recollection.stratification2 =  normalized.stratification.value);

ALTER TABLE normalized.data_recollection
DROP COLUMN stratification1,
DROP COLUMN stratification2,
DROP COLUMN stratification_category1,
DROP COLUMN stratification_category2;
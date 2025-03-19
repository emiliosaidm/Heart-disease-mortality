-- Crear el Schema crudo.
CREATE SCHEMA raw;

-- Crear la tabla en el Schema raw.
DROP TABLE IF EXISTS raw.disease_mortality;
CREATE TABLE raw.disease_mortality (
    year VARCHAR(4),
    location_abbr VARCHAR(2),
    location_description VARCHAR(100),
    geographic_level VARCHAR(50),
    data_source VARCHAR(10),
    class VARCHAR(50),
    topic VARCHAR(100),
    data_value DOUBLE PRECISION,
    data_value_unit VARCHAR(150),
    data_value_type VARCHAR(150),
    data_value_footnote_symbol TEXT,
    data_value_footnote VARCHAR(50),
    stratification_category1 VARCHAR(10),
    stratification1 VARCHAR(10),
    stratification_category2 VARCHAR(50),
    stratification2 VARCHAR(50),
    topic_id VARCHAR(5),
    location_id INTEGER,
    y_lat DOUBLE PRECISION,
    x_lon DOUBLE PRECISION,
    georeference TEXT
);

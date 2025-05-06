-- Promedio muertes por enfermedades cardiacas por localidad
SELECT normalized.location.description AS location, AVG(normalized.data_recollection.value)
FROM normalized.data_recollection
JOIN normalized.location ON normalized.data_recollection.location_id = normalized.location.id
GROUP BY  normalized.location.id, normalized.location.description
ORDER BY AVG(normalized.data_recollection.value) DESC;

-- Contar el número total de fallecimientos de hombres y mujeres
SELECT str.value, SUM(dr.value)
FROM normalized.data_recollection AS dr
LEFT JOIN normalized.heart_disease_stratification AS hds ON hds.data_recollection_id = dr.id
LEFT JOIN normalized.stratification AS str ON str.id = hds.stratification_id
WHERE str.category = 'Sex'
GROUP BY str.value
ORDER BY SUM(dr.value) DESC;

-- Contar el número total de fallecimientos por raza.
SELECT str.value, SUM(dr.value)
FROM normalized.data_recollection AS dr
LEFT JOIN normalized.heart_disease_stratification AS hds ON hds.data_recollection_id = dr.id
LEFT JOIN normalized.stratification AS str ON str.id = hds.stratification_id
WHERE str.category = 'Race/Ethnicity'
GROUP BY str.value
ORDER BY SUM(dr.value) DESC;

-- Contar los tipos de datos en la recolección de datos.
SELECT d_type.value, COUNT(*)
FROM normalized.data_recollection AS dr
JOIN normalized.data_type_recollection AS d_type_r ON dr.id = d_type_r.data_type_id
JOIN normalized.data_type AS d_type ON d_type.id = d_type_r.data_type_id
GROUP BY d_type.value;

-- Promedio por categoria de estratificación
SELECT str.value, AVG(dr.value)
FROM normalized.data_recollection AS dr
LEFT JOIN normalized.heart_disease_stratification AS hds ON hds.data_recollection_id = dr.id
LEFT JOIN normalized.stratification AS str ON str.id = hds.stratification_id
WHERE str.category = 'Race/Ethnicity'
GROUP BY str.value
ORDER BY AVG(dr.value) DESC;

-- Correlación entre dos datos: 'Age-adjusted' y '3-year Average Rate'
WITH metrics AS (
    SELECT dr.id, dt.value AS data_type, dr.value
    FROM normalized.data_recollection AS dr
    JOIN normalized.data_type_recollection AS d_type_r ON d_type_r.data_recollection_id = dr.id
    JOIN normalized.data_type AS dt ON d_type_r.data_type_id = dt.id
)

SELECT corr(m1.value, m2.value)
FROM metrics AS m1
JOIN metrics AS m2 ON m1.id = m2.id
WHERE m1.data_type = '3-year Average Rate' AND m2.data_type = 'Spatially Smoothed';

--


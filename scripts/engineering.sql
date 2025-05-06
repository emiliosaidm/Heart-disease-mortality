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

--
SELECT DISTINCT dr.type
FROM normalized.data_recollection AS dr;



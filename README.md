# Análisis de Mortalidad por Enfermedades Cardiovasculares en EE.UU.

Los datos sobre la mortalidad por enfermedades cardiovasculares en adultos mayores de 35 años en Estados Unidos son recopilados por el **Centro para el Control y la Prevención de Enfermedades (CDC)**, con respaldo del **Departamento de Salud y Servicios Humanos de los EE.UU.**. La información proviene de registros estatales y territoriales y se publica en plataformas gubernamentales de acceso abierto.

El objetivo de la recolección de estos datos es analizar patrones y tendencias en la mortalidad relacionada con enfermedades cardíacas, identificar qué estados o territorios presentan mayores tasas de incidencia, explorar las características demográficas de los afectados y determinar si existen correlaciones con factores geográficos o socioeconómicos. Esta información es clave para la toma de decisiones en salud pública y la prevención de enfermedades cardiovasculares.

Los datos están disponibles en la plataforma oficial del gobierno de EE.UU., accesibles a través del siguiente enlace: **[Heart Disease Mortality Data](https://catalog.data.gov/dataset/heart-disease-mortality-data-among-us-adults-35-by-state-territory-and-county-2019-2021)**. La última actualización de la base de datos fue el **3 de febrero de 2025**, con registros previos el **30 de enero de 2025** y la publicación inicial el **23 de febrero de 2024**.

El dataset cuenta con **78,793 registros** y **21 atributos**, que incluyen información sobre ubicación, tasas de mortalidad y estratificación demográfica. A continuación, se detallan los atributos:

| Atributo                                   | Descripción                                                                             |
| ------------------------------------------ | --------------------------------------------------------------------------------------- |
| **Year** _(numérico)_                      | Año de recopilación (2019, 2020, 2021).                                                 |
| **LocationAbbr** _(categórico)_            | Abreviatura del estado o territorio.                                                    |
| **LocationDesc** _(categórico)_            | Nombre completo del estado, territorio o condado.                                       |
| **GeographicLevel** _(categórico)_         | Nivel geográfico del dato (State o County).                                             |
| **DataSource** _(categórico)_              | Fuente de los datos (NVSS - National Vital Statistics System).                          |
| **Class** _(categórico)_                   | Categoría general de la enfermedad (Cardiovascular Diseases).                           |
| **Topic** _(categórico)_                   | Subcategoría específica (Heart Disease Mortality).                                      |
| **Data_Value** _(numérico)_                | Tasa de mortalidad por enfermedades cardíacas (muertes por cada 100,000 habitantes).    |
| **Data_Value_Unit** _(categórico)_         | Unidad de medida: "per 100,000 population".                                             |
| **Data_Value_Type** _(categórico)_         | Tipo de medida utilizada para la tasa de mortalidad.                                    |
| **Data_Value_Footnote** _(texto)_          | Notas aclaratorias sobre los valores de los datos.                                      |
| **StratificationCategory1** _(categórico)_ | Primera categoría de estratificación ("Sex").                                           |
| **Stratification1** _(categórico)_         | Estratificación por sexo ("Male" o "Female").                                           |
| **StratificationCategory2** _(categórico)_ | Segunda categoría de estratificación ("Race/Ethnicity").                                |
| **Stratification2** _(categórico)_         | Estratificación por raza/etnicidad (White, Black, Hispanic, Asian, More than one race). |
| **TopicID** _(categórico)_                 | Código interno del tema de la base de datos.                                            |
| **LocationID** _(numérico)_                | Código único asignado al estado o condado.                                              |
| **Y_lat** _(numérico)_                     | Coordenada de latitud geográfica.                                                       |
| **X_lon** _(numérico)_                     | Coordenada de longitud geográfica.                                                      |
| **Georeference** _(texto)_                 | Ubicación en formato POINT (longitud, latitud).                                         |

Los atributos pueden agruparse de la siguiente manera:

- **Atributos numéricos:** `Year`, `Data_Value`, `LocationID`, `Y_lat`, `X_lon`.
- **Atributos categóricos:** `LocationAbbr`, `Class`, `LocationDesc`, `GeographicLevel`, `StratificationCategory1`, `Stratification1`, `StratificationCategory2`, `Stratification2`, `TopicID`, `DataSource`, `Data_Value_Unit`, `Data_Value_Type`.
- **Atributos de tipo texto:** `Data_Value_Footnote`, `Georeference`.

Este análisis busca comprender la distribución de la mortalidad por enfermedades cardiovasculares en EE.UU., identificar posibles causas y analizar factores que influyen en la prevalencia de estas enfermedades. La información obtenida permite diseñar estrategias de prevención y políticas públicas enfocadas en reducir la incidencia de muertes por enfermedades cardíacas.

En términos éticos, el análisis de estos datos considera la privacidad y anonimización de la información, la integridad de los datos sin manipulación de valores, la objetividad en el análisis y la equidad en la interpretación de los resultados. Se evita cualquier sesgo que pueda generar discriminación o reforzar desigualdades en el acceso a la salud.

---

### Carga inicial de datos

Ten en cuenta que los comandos incluidos en este repositorio asumen que la carpeta **scripts** se encuentra en el directorio actual de la terminal. Si la ubicación es distinta, asegúrate de utilizar la ruta relativa o absoluta correcta para ejecutar los comandos.

**Nota**: todo el trabajo será realizado por medio de PostgreSQL, puedes descagarlo desde el [sitio oficial](https://www.postgresql.org/download/).

Desde tu terminal, ejecuta la serie de comandos mostrados a continuación para poder obtener los datos.

```bash
# Entrar a la consola de postgres
psql -U postgres
```

```bash
# Crea una nueva base de datos para el análisis
CREATE DATABASE heart_disease_mortality;

# Conéctate a la base de datos recién creada
\c heart_disease_mortality

```

Ahora, hay que ejecutar el siguiente script, el cual se encargará de crear un schema llamado **raw** con la tabla `raw.disease_mortality`, a la cual le importaremos los datos de la fuente usada.

```bash
# Ejecuta el script para crear el esquema de la base de datos
\i scripts/raw_schema_creation.sql
```

Posteriormente, corremos el siguiente comando para poder importar las filas del CSV en la tabla `raw.disease_mortality`

```bash
# Importamos el contenido del CSV
\copy raw.disease_mortality (year, location_abbr, location_description, geographic_level, data_source, topic, class, data_value data_value_unit, data_value_type, data_value_footnote_symbol, data_value_footnote, stratification_category1, stratification1, stratification_category2, stratification2, topic_id, location_id, y_lat, x_lon, georeference ) FROM 'path_to_csv_file.csv' WITH(FORMAT CSV, HEADER true, DELIMITER ',');
```

Se deben de importar alrededor de 78792 tuplas.

A través de un análisis extenso, se identificaron patrones útiles para poder hacer posteriormente una limpieza de datos.

De las 20 columnas, ninguna contiene valores únicos. Al agrupar los datos por algún identificador, como `location_id`, se observa que cada grupo cuenta con al menos 24 tuplas distintas.

El conjunto de datos incluye una columna relacionada con fechas, que representa el año de recopilación. Según la documentación, esta columna abarca un rango de años desde 2019 hasta 2021. Sin embargo, tras analizar los datos, se encontró que todas las tuplas corresponden únicamente al año 2020, sin registros de otros años.

El conjunto de datos incluye 4 columnas con valores numéricos. Aunque ya se discutió la columna `Year`, que representa un valor numérico, a continuación se presenta una tabla que resume los valores mínimos, máximos y promedios de las columnas numéricas: `Year`, `Data_Value`, `LocationID`, `Y_lat` y `X_lon`:

| Columna         | Min          | Avg      | Max         |
| --------------- | ------------ | -------- | ----------- |
| **year**        | 2020         | 2020     | 2020        |
| **data_value**  | 0            | 351.61   | 3203.9      |
| **location_id** | 0            | 30922.42 | 78030       |
| **y_lat**       | -14.30175426 | 37.90    | 69.30952908 |
| **x_lon**       | -170.7194738 | -91.41   | 145.7512588 |

Analizamos si existen **valores duplicados** dentro de las columnas categóricas, es decir, aquellas que agrupan o clasifican datos, como:

- `LocationAbbr`
- `Class`
- `LocationDesc`
- `GeographicLevel`
- `StratificationCategory1`
- `Stratification1`
- `StratificationCategory2`
- `Stratification2`
- `TopicID`
- `DataSource`
- `Data_Value_Unit`
- `Data_Value_Type`

En general, **sí se encontraron valores duplicados en varias columnas categóricas**. A continuación se resumen los hallazgos más relevantes:

- **`LocationAbbr`** presenta múltiples repeticiones. El valor más frecuente es **_TX_**, con **6,120 apariciones**, y en total se identificaron **57 abreviaciones distintas** con duplicados.

- **`LocationDesc`** también mostró duplicados: hubo **2,022 repeticiones**, siendo **_Washington County_** el valor más frecuente, seguido por **_Jefferson County_**, con una disminución gradual en el resto de valores.

- En **`GeographicLevel`** solo hay tres categorías: **County**, **State** y **Nation**, con **77,424**, **1,344** y **24** apariciones respectivamente, lo cual indica una alta repetición.

- Para **`Stratification1`**, se observaron tres categorías: **Overall**, **Male** y **Female**, cada una con **26,264 repeticiones**.

- En **`Stratification2`**, se identificaron **8 categorías** distintas, todas con exactamente **9,849 repeticiones**.

- En el caso de **`Data_Value_Type`**, hay dos valores predominantes:
  - **_Age-adjusted, Spatially Smoothed, 3-year Average Rate_** con **77,424 apariciones**
  - **_Age-adjusted, 3-year Average Rate_** con **1,368 apariciones**

Por otro lado, el resto de las columnas categóricas analizadas **no presentan duplicados significativos** o los valores se distribuyen de forma única.

Continunado, se compararon todas las columnas categóricas entre sí para **detectar redundancias en su contenido**. Algunas columnas son conceptualmente redundantes:

- **`Year`**, se observa que muestra un único dato, este es el de "2020", dandonos como resultado que este set de datos, solo se enfoca en un mismo tiempo.
- **`Class`**, **`Topic`** y **`TopicID`**, expresan la misma temática (enfermedades cardiovasculares y mortalidad por enfermedades del corazón).
- **`Data_Value_Unit`** siempre indica la misma unidad de medida.
- **`Data_Source`** tiene un solo valor constante.
- **`Stratification_Category1`** y **`Stratification_Category2`** siempre contienen "Sex" y "Race/Ethnicity", respectivamente.
- **`Data_value_footnote`** y **`Data_value_footnote_symbol`**, son columnas de correlación, ambas comparten "null" y cada vez que aparece "~" en **`Data_value_footnote_symbol`**, viene acompañado de "Insufficient data" `Data_value_footnote`\*\*.

Ahora, al momento de identificar el **conteo de tuplas por categoria**, se decidío distinguirlos por etnia. Logrando identificar los siguientes datos:

| Etnicidad                                      | Total_Tuplas |
| ---------------------------------------------- | ------------ |
| **Hispanic**                                   | **9849**     |
| **Native Hawaiian or Other Pacific Islanders** | **9849**     |
| **Asian**                                      | **9849**     |
| **White**                                      | **9849**     |
| **More than one race**                         | **9849**     |
| **Black**                                      | **9849**     |
| **American Indian or Alaska Native**           | **9849**     |
| **Overall**                                    | **9849**     |

Obteniendo como resultado, la misma cantidad de cada uno de los grupos, obteniendo en total las **78,7982** tuplas de nuestro set de datos.

Por otra parte, al realizar el **conteo de nulos en nuestro set de datos**, decidimos distinguirlo por cada categoria y después, obtener el resultado final.
La visualización de datos es la siguiente:

| Columna                        | null_count |
| ------------------------------ | ---------- |
| **data_value**                 | **44,362** |
| **data_value_footnote**        | **34,430** |
| **data_value_footnote_symbol** | **34,430** |
| **y_lat**                      | **24**     |
| **x_lon**                      | **24**     |
| **georeference**               | **24**     |

Encontrando, un total de **113,294** valores **`NULL`** en este set de datos.

Por último, al momento de analizar **inconsistencias en el set de datos**, buscamos encontrar, que no hubiera valores negativos en **`data_value`**, verificamos si existian valores inválidos en **`geographic_level`**, coordenadas inválidas y valores nulos en campos clave.

Logrando conlcuir, que nuestro set de datos no cuenta con inconsitencias en ningún campo verificado por nosotros.

---

### Limpieza de datos

En este paso se optimiza la estructura del dataset eliminando columnas redundantes e innecesarias:

• Se eliminará la columna `Georeference`, ya que la información geográfica se consolida en `Y_lat` y `X_lon`.

• Se eliminará la columna `Class`,`Topic` y `TopicId`, puesto que para todo el Dataset sus valores son "Heart Disease Mortality", "Cardiovascular Diseases" y "T2" respectivamente. 
A pesar de que el atributo `DataSource` también mantiene un único valor desde que se modelaron los datos, esta es más probable que pudiera cambiar en alguna ocasión.

• Se eliminará la columna `LocationId`, ya que durante el proceso de normalización se incluirá una nueva. Además, la columna actual probablemente hace referencia a una tabla distinta de localizaciones perteneciente a la organización que recopiló los datos.

• Se eliminarán las columnas `Data_Value_Footnote` y `Data_Value_Footnote_Symbol`, pues contienen mayormente valores nulos o uniformes (por ejemplo, “~” o “Insufficent Data”) que no aportan información relevante.
 
Existen aproximadamente 88,724 tuplas en las que el atributo `DataValue` es nulo. Para los fines de este proyecto, dichas tuplas no aportan información útil, ya que únicamente indican la localidad sin proporcionar el número de mortalidades. Por lo tanto, no tiene sentido conservarlas y se eliminarán del conjunto de datos.

Antes de iniciar la limpieza, asegúrate de estar conectado a la base de datos en la terminal de Postgres. Luego, ejecuta el siguiente comando:

```bash
\i scripts/clean.sql
```

Este script creará un nuevo schema, llamado `clean`, en el estará la tabla `disease_mortality` con los cambios ya explicados.

---

# Normalización de Datos (4FN)

A continuación se listan, para cada relvar, sus dependencias funcionales no triviales y sus dependencias multivaluadas no triviales.

---

## 1. Data\_Recollection

**Atributos**

```
{id, unit, value, type, source, year, location_id}
```

**Clave primaria**

```
{id}
```

**Dependencias funcionales no triviales**

* `{id} → {unit, value, type, source, year, location_id}`

**Dependencias multivaluadas no triviales**

* Ninguna

---

## 2. Data\_Type

**Atributos**

```
{id, value}
```

**Clave primaria**

```
{id}
```

**Dependencias funcionales no triviales**

* `{id} → {value}`

**Dependencias multivaluadas no triviales**

* Ninguna

---

## 3. Location

**Atributos**

```
{id, abbreviation, description, y_lat, x_lat, geographic_level}
```

**Clave primaria**

```
{id}
```

**Dependencias funcionales no triviales**

* `{id} → {abbreviation, description, y_lat, x_lat, geographic_level}`

**Dependencias multivaluadas no triviales**

* Ninguna

---

## 4. Stratification

**Atributos**

```
{id, category, value}
```

**Clave primaria**

```
{id}
```

**Dependencias funcionales no triviales**

* `{id} → {category, value}`

**Dependencias multivaluadas no triviales**

* Ninguna

---

## 5. Data\_Type\_Recollection

**Atributos**

```
{id, data_recollection_id, data_type_id}
```

**Clave primaria**

```
{id}
```

**Claves alternas**

```
{data_recollection_id, data_type_id}
```

**Dependencias funcionales no triviales**

* `{id} → {data_recollection_id, data_type_id}`
* `{data_recollection_id, data_type_id} → {id}`

**Dependencias multivaluadas no triviales**

* Ninguna

---

## 6. Heart\_Disease\_Stratification

**Atributos**

```
{id, data_recollection_id, stratification_id}
```

**Clave primaria**

```
{id}
```

**Claves alternas**

```
{data_recollection_id, stratification_id}
```

**Dependencias funcionales no triviales**

* `{id} → {data_recollection_id, stratification_id}`
* `{data_recollection_id, stratification_id} → {id}`

**Dependencias multivaluadas no triviales**

* Ninguna

Todas las relaciones están descompuestas de manera que cada atributo dependiente depende únicamente de la clave primaria.

Al no haber MVDs, cada relvar cumple automáticamente con la condición de 4FN.

Para normalizar los datos, ejecuta el siguiente comando, el cual se encargará de crear las tablas,
asociarlas y popularlas. El nuevo schema de datos estará guardado en el schema **normalized**.
```bash
\i scripts/normalization.sql
```


---
### Diagrama entidad-relación 

![Proyecto final BD](https://github.com/user-attachments/assets/9b98607c-d65d-495f-887f-8f8bd7635854)

---

## Consultas

La siguiente query calcula el promedio por localidad de muertes. Se puede ver que Martinsville City es la ciudad que más muertes tiene en promedio.

```sql
-- Promedio muertes por enfermedades cardiacas por localidad
SELECT normalized.location.description AS location, AVG(normalized.data_recollection.value)
FROM normalized.data_recollection
JOIN normalized.location ON normalized.data_recollection.location_id = normalized.location.id
GROUP BY  normalized.location.id, normalized.location.description
ORDER BY AVG(normalized.data_recollection.value) DESC;
```
La siguiente query suma las muertes agrupando por sexo, permitiendo ver que mueren más hombres que mujeres y sexos no descritos.

```sql
-- Contar el número total de fallecimintos de hombres y mujeres
SELECT str.value, SUM(dr.value)
FROM normalized.data_recollection AS dr
LEFT JOIN normalized.heart_disease_stratification AS hds ON hds.data_recollection_id = dr.id
LEFT JOIN normalized.stratification AS str ON str.id = hds.stratification_id
WHERE str.category = 'Sex'
GROUP BY str.value
ORDER BY SUM(dr.value) DESC;
```
La siguiente consulta suma todas las muertes de todas las localidades y las agrupa por Raza. Se puede determinar que la categoría 'Overall' es la que más muertes suma, seguido de la raza
blanca y luego la negra.

```sql
-- Contar el número total de fallecimientos por raza.
SELECT str.value, SUM(dr.value)
FROM normalized.data_recollection AS dr
LEFT JOIN normalized.heart_disease_stratification AS hds ON hds.data_recollection_id = dr.id
LEFT JOIN normalized.stratification AS str ON str.id = hds.stratification_id
WHERE str.category = 'Race/Ethnicity'
GROUP BY str.value
ORDER BY SUM(dr.value) DESC;
```
La siguiente query cuenta el número de tipos de datos recolectados; "3-year Average Rate" y "Age-adjusted" son los más frecuentes, con una periodicidad de 68860, mientras que 
Spatially Smoothed con 66862.

```sql
-- Contar los tipos de datos de la recolección de datos.
SELECT d_type.value, COUNT(*)
FROM normalized.data_recollection AS dr
JOIN normalized.data_type_recollection AS d_type_r ON dr.id = d_type_r.data_type_id
JOIN normalized.data_type AS d_type ON d_type.id = d_type_r.data_type_id
GROUP BY d_type.value;
```
La siguiente consulta busca determinar el promedio por categoría de estratificación, donde se pudo determinar que en promedio mueren más personas de la raza Negra que cualquier otra,
seguido de nativos de islas en Hawaii, en una zona determinada.

```sql
-- Promedio por categoria de estratificación
SELECT str.value, AVG(dr.value)
FROM normalized.data_recollection AS dr
LEFT JOIN normalized.heart_disease_stratification AS hds ON hds.data_recollection_id = dr.id
LEFT JOIN normalized.stratification AS str ON str.id = hds.stratification_id
WHERE str.category = 'Race/Ethnicity'
GROUP BY str.value
ORDER BY AVG(dr.value) DESC;
```
El resultado de la siguiente consulta es 1. Esto significa que la correlación entre esos dos datos es directamente proporcional, lo que indica que siempre que haya un tipo de dato
`Age-adjusted` siempre va haber un `3-year Average Rate` asociado. 
```sql
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
```
La siguiente query da los valores promedios de una latitud y longitud dada.
```sql
-- Valores promedios en latitud y longitud.
SELECT l.x_lon,
       l.y_lat,
       AVG(dr.value) AS avg_value
FROM normalized.data_recollection AS dr
JOIN normalized.location AS l ON dr.location_id = l.id
GROUP BY l.x_lon, l.y_lat;
```
El resultado se visualizó mediante un *heatmap* interactivo generado con [Kepler](https://kepler-preview.foursquare.com/), lo cual permite identificar claramente las zonas con mayor cantidad de muertes. Como se puede observar, los estados del este de Estados Unidos, así como Puerto Rico, son las regiones más afectadas por fallecimientos relacionados con complicaciones cardíacas.

![kepler gl](https://github.com/user-attachments/assets/8e079131-2658-4e36-84bc-94d6c938b419)

La siguiente consulta busca determinar si hay una correlación de la longitud y latitud de donde los datos se recolectaron con el número de muertos
de esa localidad en específico.

Se pudo ver que hay una correlación del 5% en longitud y una correlación inversamente proporcional en latitud del 12% aproximadamente.
```sql
-- Correlación de la longitud y latitud de donde los datos se recolectaron con el número de muertos.
SELECT corr(dr.value, l.x_lon) AS corr_long, corr(dr.value, l.y_lat) AS corr_lat
FROM normalized.data_recollection AS dr
JOIN normalized.location AS l
ON dr.location_id = l.id;
```

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

Primero, es necesario crear la base de datos para poder realizar la carga de la base de datos.

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
\copy raw.disease_mortality (
  year,
  location_abbr,
  location_description,
  geographic_level,
  data_source,
  topic,
  class,
  data_value,
  data_value_unit,
  data_value_type,
  data_value_footnote_symbol,
  data_value_footnote,
  stratification_category1,
  stratification1,
  stratification_category2,
  stratification2,
  topic_id,
  location_id,
  y_lat,
  x_lon,
  georeference
) FROM 'path_to_csv_file.csv'
  WITH (FORMAT CSV, HEADER true, DELIMITER ',');
```

Se deben de importar alrededor de 78792 tuplas.

A través de un análisis extenso, se identificaron patrones útiles para poder hacer posteriormente una limpieza de datos.

De las 20 columnas, ninguna contiene valores únicos. Al agrupar los datos por algún identificador, como `location_id`, se observa que cada grupo cuenta con al menos 24 tuplas distintas.

El conjunto de datos incluye una columna relacionada con fechas, que representa el año de recopilación. Según la documentación, esta columna abarca un rango de años desde 2019 hasta 2021. Sin embargo, tras analizar los datos, se encontró que todas las tuplas corresponden únicamente al año 2020, sin registros de otros años.

---

### Limpieza de datos

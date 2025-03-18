# Análisis de Mortalidad por Enfermedades Cardiovasculares en EE.UU.

Los datos sobre la mortalidad por enfermedades cardiovasculares en adultos mayores de 35 años en Estados Unidos son recopilados por el **Centro para el Control y la Prevención de Enfermedades (CDC)**, con respaldo del **Departamento de Salud y Servicios Humanos de los EE.UU.**. La información proviene de registros estatales y territoriales y se publica en plataformas gubernamentales de acceso abierto.

El objetivo de la recolección de estos datos es analizar patrones y tendencias en la mortalidad relacionada con enfermedades cardíacas, identificar qué estados o territorios presentan mayores tasas de incidencia, explorar las características demográficas de los afectados y determinar si existen correlaciones con factores geográficos o socioeconómicos. Esta información es clave para la toma de decisiones en salud pública y la prevención de enfermedades cardiovasculares.

Los datos están disponibles en la plataforma oficial del gobierno de EE.UU., accesibles a través del siguiente enlace: **[Heart Disease Mortality Data](https://catalog.data.gov/dataset/heart-disease-mortality-data-among-us-adults-35-by-state-territory-and-county-2019-2021)**. La última actualización de la base de datos fue el **3 de febrero de 2025**, con registros previos el **30 de enero de 2025** y la publicación inicial el **23 de febrero de 2024**.

El dataset cuenta con **78,793 registros** y **21 atributos**, que incluyen información sobre ubicación, tasas de mortalidad y estratificación demográfica. A continuación, se detallan los atributos:

| Atributo                                   | Descripción                                                                                             |
|-------------------------------------------|---------------------------------------------------------------------------------------------------------|
| **Year** *(numérico)*                      | Año de recopilación (2019, 2020, 2021).                                                                |
| **LocationAbbr** *(categórico)*            | Abreviatura del estado o territorio.                                                                  |
| **LocationDesc** *(categórico)*            | Nombre completo del estado, territorio o condado.                                                     |
| **GeographicLevel** *(categórico)*         | Nivel geográfico del dato (State o County).                                                           |
| **DataSource** *(categórico)*              | Fuente de los datos (NVSS - National Vital Statistics System).                                        |
| **Class** *(categórico)*                   | Categoría general de la enfermedad (Cardiovascular Diseases).                                         |
| **Topic** *(categórico)*                   | Subcategoría específica (Heart Disease Mortality).                                                    |
| **Data_Value** *(numérico)*                | Tasa de mortalidad por enfermedades cardíacas (muertes por cada 100,000 habitantes).                  |
| **Data_Value_Unit** *(categórico)*         | Unidad de medida: "per 100,000 population".                                                          |
| **Data_Value_Type** *(categórico)*         | Tipo de medida utilizada para la tasa de mortalidad.                                                  |
| **Data_Value_Footnote** *(texto)*          | Notas aclaratorias sobre los valores de los datos.                                                    |
| **StratificationCategory1** *(categórico)* | Primera categoría de estratificación ("Sex").                                                        |
| **Stratification1** *(categórico)*         | Estratificación por sexo ("Male" o "Female").                                                       |
| **StratificationCategory2** *(categórico)* | Segunda categoría de estratificación ("Race/Ethnicity").                                             |
| **Stratification2** *(categórico)*         | Estratificación por raza/etnicidad (White, Black, Hispanic, Asian, More than one race).              |
| **TopicID** *(categórico)*                 | Código interno del tema de la base de datos.                                                         |
| **LocationID** *(numérico)*                | Código único asignado al estado o condado.                                                           |
| **Y_lat** *(numérico)*                     | Coordenada de latitud geográfica.                                                                    |
| **X_lon** *(numérico)*                     | Coordenada de longitud geográfica.                                                                   |
| **Georeference** *(texto)*                 | Ubicación en formato POINT (longitud, latitud).                                                     |

Los atributos pueden agruparse de la siguiente manera:

- **Atributos numéricos:** `Year`, `Data_Value`, `LocationID`, `Y_lat`, `X_lon`.
- **Atributos categóricos:** `LocationAbbr`, `Class`, `LocationDesc`, `GeographicLevel`, `StratificationCategory1`, `Stratification1`, `StratificationCategory2`, `Stratification2`, `TopicID`, `DataSource`, `Data_Value_Unit`, `Data_Value_Type`.
- **Atributos de tipo texto:** `Data_Value_Footnote`, `Georeference`.

Este análisis busca comprender la distribución de la mortalidad por enfermedades cardiovasculares en EE.UU., identificar posibles causas y analizar factores que influyen en la prevalencia de estas enfermedades. La información obtenida permite diseñar estrategias de prevención y políticas públicas enfocadas en reducir la incidencia de muertes por enfermedades cardíacas.

En términos éticos, el análisis de estos datos considera la privacidad y anonimización de la información, la integridad de los datos sin manipulación de valores, la objetividad en el análisis y la equidad en la interpretación de los resultados. Se evita cualquier sesgo que pueda generar discriminación o reforzar desigualdades en el acceso a la salud.


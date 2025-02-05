# Análisis de Mortalidad por Enfermedades Cardiovasculares en EE.UU.

## ¿Quién los recolecta?
Los datos son recopilados a nivel federal por el **Centro para el Control y la Prevención de Enfermedades (CDC)** del Departamento de Salud de los Estados Unidos. La recolección se realiza en cada estado y territorio con el respaldo del **Departamento de Salud y Servicios Humanos de los EE.UU.**

## ¿Cuál es el propósito de su recolección?
El propósito de esta recolección de datos es analizar los índices de mortalidad en adultos mayores de 35 años debido a enfermedades cardiovasculares en los Estados Unidos. La muestra busca identificar patrones y tendencias que contribuyen al desarrollo de problemas cardíacos y sus consecuencias.

## ¿Dónde se pueden obtener?
Los datos son de acceso público y están disponibles en la página oficial de catálogos de datos del gobierno de los Estados Unidos. Se pueden consultar de diversas formas a través del siguiente enlace: **Heart Disease Mortality Data**.

## ¿Con qué frecuencia se actualizan?
Se tiene registro de las siguientes fechas de actualización:
- **23 de febrero de 2024**: Publicación inicial.
- **30 de enero de 2025**: Penúltima modificación.
- **3 de febrero de 2025**: Última modificación confirmada.

## ¿Cuántas tuplas y cuántos atributos tiene el set de datos?
El documento contiene más de **78,000** tuplas. Específicamente, el dataset proporcionado cuenta con **78,793** tuplas y **21 atributos**.

## ¿Qué significa cada atributo del set?
| Atributo | Descripción |
|----------|------------|
| **Year** | Año en el que se recopilaron los datos (2019, 2020, 2021). |
| **LocationAbbr** | Abreviatura del estado o territorio donde se registraron los datos (por ejemplo, "CA" para California). |
| **LocationDesc** | Nombre completo del estado, territorio o condado. |
| **GeographicLevel** | Nivel geográfico al que pertenecen los datos (State o County). |
| **DataSource** | Fuente de los datos (NVSS - National Vital Statistics System). |
| **Class** | Categoría general de la enfermedad (Cardiovascular Diseases). |
| **Topic** | Subcategoría específica del problema de salud (Heart Disease Mortality). |
| **Data_Value** | Tasa de mortalidad por enfermedades cardíacas (muertes por cada 100,000 habitantes). |
| **Data_Value_Unit** | Unidad de medida utilizada: "per 100,000 population". |
| **Data_Value_Type** | Tipo de medida utilizada para la tasa de mortalidad. |
| **Data_Value_Footnote** | Información adicional o notas aclaratorias sobre los valores de los datos. |
| **StratificationCategory1** | Primera categoría de estratificación de los datos ("Sex"). |
| **Stratification1** | Estratificación según sexo ("Male" o "Female"). |
| **StratificationCategory2** | Segunda categoría de estratificación ("Race/Ethnicity"). |
| **Stratification2** | Estratificación por raza/etnicidad (White, Black, Hispanic, Asian, More than one race). |
| **TopicID** | Código interno asociado al tema de la base de datos (T2 para enfermedades cardíacas). |
| **LocationID** | Código único asignado al estado o condado. |
| **Y_lat** | Coordenada de latitud geográfica del lugar. |
| **X_lon** | Coordenada de longitud geográfica del lugar. |
| **Georeference** | Ubicación geográfica en formato POINT (longitud, latitud). |

## Tipos de atributos
### Atributos numéricos:
- Data_Value
- LocationID
- Y_lat
- X_lon

### Atributos categóricos:
- LocationAbbr
- LocationDesc
- GeographicLevel
- StratificationCategory1
- Stratification1
- StratificationCategory2
- Stratification2
- TopicID

### Atributos de tipo texto:
- DataSource
- Class
- Topic
- Data_Value_Type
- Georeference
- Data_Value_Unit
- Data_Value_Footnote
- Data_Value_Footnote_Symbol

### Atributos temporales:
- Year

## ¿Cuál es el objetivo buscado con el set de datos? ¿Para qué se usará por el equipo?
El objetivo de este análisis es **examinar los índices y la distribución del riesgo de mortalidad por enfermedades cardíacas en los EE.UU.**. Buscamos:
- Identificar **qué estados o territorios presentan mayor y menor riesgo**.
- Inferir **posibles causas** detrás de estas diferencias.
- Analizar las características físicas de las personas más propensas a padecer estos riesgos.
- Explorar si **existe relación entre factores geográficos, edad y riesgo cardiovascular**.

Estos datos permitirán visualizar tendencias y realizar diagnósticos objetivos para la toma de decisiones en la **prevención de enfermedades cardiovasculares**.

## ¿Qué consideraciones éticas conlleva el análisis y explotación de dichos datos?
Hemos tomado diversas medidas para garantizar un análisis ético de los datos:
- **Privacidad**: Todos los datos utilizados son públicos, de acceso abierto y completamente anónimos.
- **Integridad**: Nos comprometemos a **no modificar ni manipular ninguna tupla** para alterar los resultados.
- **Objetividad**: Nos aseguramos de que el análisis esté basado en **evidencia científica**, sin sesgos o interpretaciones erróneas.
- **Equidad**: Se busca evitar que el estudio **refuerce desigualdades preexistentes** en acceso a la salud.
- **No discriminación**: No se atribuirán tendencias de riesgo a factores raciales de manera discriminatoria.

Nuestro objetivo es realizar un **estudio riguroso y objetivo** que contribuya a la comprensión y prevención de enfermedades cardiovasculares, sin generar prejuicios ni reforzar inequidades.

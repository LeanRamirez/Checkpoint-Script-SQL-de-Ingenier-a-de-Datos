# RetailPro — Análisis de ventas con SQL y Power BI

## Descripción del proyecto

RetailPro es un proyecto académico de análisis de datos orientado al estudio de las ventas de una empresa minorista de productos tecnológicos.

El repositorio contiene scripts SQL para crear una base de datos, cargar datos de prueba y realizar consultas destinadas a obtener información comercial. También incluye archivos de Power BI relacionados con el proceso ETL y el análisis de los datos.

## Objetivos

Los principales objetivos del proyecto son:

* Crear una base de datos relacional para almacenar información sobre clientes, productos, categorías y ventas.
* Aplicar claves primarias y foráneas para relacionar las tablas.
* Obtener métricas comerciales mediante consultas SQL.
* Identificar los productos con mayor volumen de ventas y facturación.
* Analizar el comportamiento de compra de los clientes.
* Detectar clientes y productos sin ventas.
* Consolidar las ventas según el canal comercial.
* Preparar y transformar los datos para su análisis en Power BI.

## Herramientas utilizadas

* SQL Server.
* T-SQL.
* Power BI.
* Power Query.
* Git y GitHub.

## Estructura del repositorio

### `Creando_la_base_de_datos_Ventas_Tech_DB.sql`

Script principal encargado de:

* Crear la base de datos `Ventas_Tech_DB`.
* Crear las tablas `categorias`, `clientes`, `productos` y `ventas`.
* Definir claves primarias y relaciones mediante claves foráneas.
* Insertar datos de prueba.
* Consultar las tablas para verificar la carga de los registros.

### `m4_consultas_negocio.sql`

Contiene consultas destinadas a obtener métricas comerciales:

* Resumen mensual de ventas.
* Total facturado.
* Promedio facturado por registro de venta.
* Ranking de productos.
* Clientes con más de una compra.
* Comparación de la facturación mensual con el promedio.

### `m5_consultas_joins.sql`

Contiene consultas que combinan diferentes tablas mediante:

* `INNER JOIN`.
* `LEFT JOIN`.
* `UNION ALL`.
* Subconsultas.
* Agrupaciones con `GROUP BY`.

Estas consultas permiten construir una vista detallada de las ventas, identificar clientes sin compras, encontrar productos sin ventas y consolidar la facturación entre canales online y presenciales.

Este script utiliza las tablas `canal`, `segmentos` y `region`, además de columnas relacionadas con ellas. Estas estructuras no se encuentran creadas en el script `Creando_la_base_de_datos_Ventas_Tech_DB.sql`, por lo que deben existir previamente en la base de datos para poder ejecutar todas las consultas de este archivo.

### `Pipeline_ETL`

Documento que explica las decisiones tomadas durante la limpieza y transformación de los datos.

Entre las transformaciones documentadas se encuentran:

* Reemplazo de valores nulos en `email` y `ciudad` por `"Sin informar"`.
* Asignación de la categoría `"Computación"` al producto `"Laptop Gaming Pro"`, utilizando como referencia su nombre y subcategoría.
* Corrección del precio nulo del producto `"SSD Externo 1TB"` con el precio unitario registrado en la tabla de ventas.

### Archivos de Power BI

El repositorio contiene los siguientes archivos:

* `Pipeline_ETL_Ramirez_Leandro_Maximiliano.pbix`.
* `Ramirez_Leandro_Maximiliano_Checkpoint2.pbix`.

Estos archivos pueden abrirse con Power BI Desktop.

## Modelo de datos inicial

El script principal crea las siguientes tablas:

### `categorias`

Almacena las categorías de productos y su descripción.

### `clientes`

Almacena los datos principales de cada cliente:

* Nombre.
* Correo electrónico.
* Ciudad.
* Fecha de registro.

### `productos`

Almacena la información del catálogo:

* Nombre del producto.
* Categoría.
* Precio.
* Stock.
* Estado del producto.

Cada producto se relaciona con una categoría mediante `id_categoria`.

### `ventas`

Registra las operaciones de venta:

* Cliente.
* Producto.
* Cantidad.
* Precio unitario.
* Fecha de venta.

Cada venta se relaciona con las tablas `clientes` y `productos` mediante claves foráneas.

## Cómo ejecutar los scripts SQL

### 1. Descargar el repositorio

El proyecto puede descargarse desde GitHub o clonarse mediante Git:

```bash
git clone https://github.com/LeanRamirez/Checkpoint-Script-SQL-de-Ingenier-a-de-Datos.git
```

### 2. Crear la base de datos

Abrir y ejecutar primero el archivo:

```text
Creando_la_base_de_datos_Ventas_Tech_DB.sql
```

Este script crea la base de datos `Ventas_Tech_DB`, genera las tablas principales e inserta los datos de prueba.

> El script contiene instrucciones `DROP TABLE IF EXISTS`. Si las tablas ya existen, serán eliminadas antes de volver a crearlas.

### 3. Seleccionar la base de datos

Antes de ejecutar las consultas de análisis, verificar que se esté utilizando la base correcta:

```sql
USE Ventas_Tech_DB;
GO
```

### 4. Ejecutar las consultas comerciales

Ejecutar el archivo:

```text
m4_consultas_negocio.sql
```

Este archivo genera el resumen mensual, el ranking de productos, el análisis de clientes recurrentes y la comparación de la facturación mensual.

### 5. Ejecutar las consultas con JOIN

El archivo:

```text
m5_consultas_joins.sql
```

requiere que la base de datos también contenga las tablas `canal`, `segmentos` y `region`, junto con las columnas utilizadas para relacionarlas con `ventas` y `clientes`.

Una vez disponibles esas estructuras, el script permite generar la fuente de datos detallada para Power BI y ejecutar los análisis de clientes, productos y canales.

## Consultas de negocio

El proyecto responde preguntas como:

* ¿Cuánto se facturó durante cada mes?
* ¿Cuál es el importe promedio de los registros de venta?
* ¿Qué productos generan mayor facturación?
* ¿Qué clientes realizaron más de una compra?
* ¿Qué clientes todavía no realizaron compras?
* ¿Qué productos no registran ventas?
* ¿Cuánto se facturó mediante canales online y presenciales?
* ¿Qué meses se encuentran por encima o por debajo del promedio calculado?

## Resultados obtenidos con los datos de prueba

A partir de los registros incluidos en el script principal se obtuvieron los siguientes resultados:

* Se registraron 10 operaciones de venta durante marzo de 2024.
* La facturación total fue de `$6.444`.
* El promedio facturado por registro de venta fue de `$644,40`.
* El producto con `id_producto = 1` generó la mayor facturación, con un total de `$3.600`.
* El producto con `id_producto = 2` presentó la mayor cantidad de unidades vendidas, con 13 unidades.
* El cliente con `id_cliente = 1` registró un gasto total de `$2.640`.

## Conceptos aplicados

Durante el desarrollo del proyecto se utilizaron los siguientes conceptos:

* Creación de bases de datos y tablas.
* Tipos de datos.
* Claves primarias y foráneas.
* Integridad referencial.
* Inserción de registros.
* Funciones de agregación: `COUNT`, `SUM` y `AVG`.
* Agrupación mediante `GROUP BY`.
* Filtrado de grupos mediante `HAVING`.
* Ordenamiento mediante `ORDER BY`.
* Expresiones condicionales con `CASE`.
* Combinación de tablas mediante `INNER JOIN` y `LEFT JOIN`.
* Combinación de resultados mediante `UNION ALL`.
* Limpieza y transformación de datos.
* Preparación de información para Power BI.

## Autor

Leandro Maximiliano Ramirez

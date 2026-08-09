                               --Cruzando tablas para enriquecer el análisis

--Consulta 1 — Vista base del proyecto (INNER JOIN) Combiná ventas, clientes, productos y territorios para obtener en una sola 
--fila: fecha, nombre del cliente, segmento, región, nombre del producto, categoría, cantidad, precio unitario, total de venta y canal. 
--Esta consulta será la fuente de datos principal en Power BI.
select * from canal

SELECT 
	v.fecha_venta AS fecha,
	c.nombre AS "nombre del cliente",
	s.nombre_segmento AS segmento,
	r.nombre_region AS region,
	p.nombre_producto AS "nombre del producto",
	ca.nombre_categoria AS categoria,
	v.cantidad,
	v.precio_unitario AS "precio unitario",
	v.cantidad * v.precio_unitario AS "total de venta",
	cl.nombre_canal AS canal

FROM dbo.ventas v -- tabla de hechos que contiene las FK para poder conectar con las otras tablas
-- joineamos las tablas necesarias para tener la tabla con los campos que necesitamos
INNER JOIN clientes c ON v.id_cliente = c.id_cliente 
INNER JOIN dbo.productos p ON p.id_producto = v.id_producto
INNER JOIN dbo.categorias ca ON p.id_categoria = ca.id_categoria
INNER JOIN dbo. canal cl ON cl.id_canal = v.id_canal
INNER JOIN dbo.segmentos s ON s.id_segmento = c.id_segmentos
INNER JOIN dbo.region r ON r.id_region = c.id_region



 --Consulta 2 — Clientes sin ventas (LEFT JOIN) Identificá clientes registrados que aún no han realizado ninguna compra. 
 --Mostrá su nombre, email y fecha de registro. Usá WHERE ... IS NULL para aislar los casos.

 SELECT 
	c.nombre,
	c.email,
	c.fecha_registro

 FROM dbo.clientes c --tabla principal donde estan todos los clientes que necesitamos encontrar coincidencias con las ventas
 LEFT JOIN dbo.ventas v ON v.id_cliente = c.id_cliente --seleccionamos la tabla con la que queremos unir relacionando a traves de los ids

 WHERE v.id_venta IS NULL



 --Consulta 3 — Productos sin ventas (LEFT JOIN) Identificá productos del catálogo que no tienen ninguna venta registrada. 
 --Mostrá nombre del producto, categoría y precio. Usá WHERE ... IS NULL.

 SELECT 
	p.nombre_producto,
	c.nombre_categoria,
	p.precio

 FROM dbo.productos p
 LEFT JOIN dbo.ventas v ON p.id_producto = v.id_producto
 LEFT JOIN dbo.categorias c ON p.id_categoria = c.id_categoria
 WHERE v.id_venta IS NULL

-- Consulta 4 — Consolidado por canal (UNION ALL) Usá UNION ALL para combinar en un solo resultado las ventas Online y Presencial,
--agregando una columna canal que identifique el origen de cada fila. 
--Al final calculá el total por canal con un GROUP BY.



SELECT
    canal,
    SUM(total_venta) AS total_por_canal

    -- POR EL ORDEN DE EJECUCION TENGO QUE CREAR LAS DOS TABLAS Y UNIRLAS PARA PODER USAR EL GROUP BY
FROM (
    -- Ventas Online
    SELECT
        v.id_venta,
        v.fecha_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Online' AS canal
    FROM dbo.ventas AS v
    INNER JOIN dbo.canal AS c
        ON v.id_canal = c.id_canal
    WHERE c.nombre_canal IN (
        'Página web',
        'WhatsApp',
        'Mercado Libre'
    )

    UNION ALL

    -- Ventas Presenciales
    SELECT
        v.id_venta,
        v.fecha_venta,
        v.cantidad * v.precio_unitario AS total_venta,
        'Presencial' AS canal
    FROM dbo.ventas AS v
    INNER JOIN dbo.canal AS c
        ON v.id_canal = c.id_canal
    WHERE c.nombre_canal = 'Sucursal'
) AS ventas_consolidadas

GROUP BY canal
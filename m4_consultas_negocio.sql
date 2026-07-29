-- Extrayendo métricas clave con SQL


-- Resumen mensual ejecutivo
SELECT
	COUNT (cantidad) AS cantitad_total_pedidos, -- cuenta el total de los pedidos
	SUM (cantidad * precio_unitario) AS total_facturado, -- primero multiplica la cantidad de productos por el precio y despues los suma
	AVG(cantidad * precio_unitario) AS ticket_promedio, -- multiplica la cantidad por el precio y hace el promedio del total
	MONTH (fecha_venta) AS mes
FROM dbo.ventas

GROUP BY MONTH(fecha_venta); -- agrupa por el mes de la venta


-- Ranking de productos

SELECT TOP 5
	id_producto AS producto,  -- ronombra la columna por "producto"
	SUM (cantidad) AS ventas_por_producto, -- agrupa (suma) las ventas con el mismo id
	SUM (cantidad * precio_unitario) AS total_facturado -- calcula el total facturado sumando el total de la cantidad por el precio unitario

FROM dbo.ventas

GROUP BY id_producto -- agrupa las observaciones segun el id del producto
ORDER BY SUM(cantidad * precio_unitario) DESC; -- ordena la tabla de forma descendente segun el total facturado


-- Clientes recurrentes

SELECT 
	id_cliente AS cliente, -- Renombrar la columna
	COUNT (cantidad) AS cantidad_compra_por_cliente, -- cuenta la cantidad de compras que hizo cada cliente
	SUM (cantidad * precio_unitario) AS total_gastado_por_cliente -- calcula el total gastado por cliente

FROM dbo.ventas

GROUP BY id_cliente -- agrupa segun el id del cliente 
HAVING COUNT (*) > 1; -- filtra los datos agrupados por el que tiene mas de 1 en este caso


--Meses por encima/por debajo del promedio

SELECT
    MONTH(fecha_venta) AS mes, -- toma solo el mes de la fecha y renombra la columna a "mes"
    SUM(cantidad * precio_unitario) AS total_facturado, -- calcula el total facturado
    CASE 
        WHEN SUM(cantidad * precio_unitario) >
        (
            SELECT
                SUM(cantidad * precio_unitario) / -- calcula el promedio facturado mensual
                COUNT(DISTINCT MONTH(fecha_venta))
            FROM dbo.ventas
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM dbo.ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- En marzo se realizaron 10 ventas con un total de de $ 6.444 y un ticket promedio de $644.
-- El mismo mes el producto mas vendido es el producto con id 2. El producto que mas se facturo es el id 1.
-- El cliente que mas compro en el mes de Marzo es el cliente numero 1 con dos compras y un total facturado de $2640.
-- El mes de marzo esta por debaajo del promedio total facturado.

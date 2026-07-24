-- creacion de la base de datos		
CREATE DATABASE Ventas_Tech_DB;
GO

USE Ventas_Tech_DB;
GO

--comprobacion de tablas existentes

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

--creacion de tablas necesarias

CREATE TABLE categorias(
	id_categoria INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	nombre_categoria VARCHAR (50) NOT NULL,
	descripcion VARCHAR (100)
	);

CREATE TABLE clientes (
	id_cliente INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	nombre VARCHAR (100) NOT NULL,
	email VARCHAR (100) UNIQUE,
	ciudad VARCHAR (100),
	fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
	id_producto INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	nombre_producto VARCHAR (100) NOT NULL,
	id_categoria INT NOT NULL,
	precio DECIMAL (10,2) NOT NULL,
	stock INT,
	activo BIT,
	
	--CONEXION FK
	CONSTRAINT fk_productos_categoria FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE ventas(
	id_venta INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	id_cliente INT,
	id_producto INT,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL (10,2) NOT NULL,
	fecha_venta DATE NOT NULL,

	--CONEXIONES CON LAS TABLAS A TRAVES DE FK

	CONSTRAINT fk_ventas_clientes FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
	CONSTRAINT fk_ventas_productos FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);


-- carga de datos en las tabla categorias

INSERT INTO categorias ( nombre_categoria, descripcion)
	VALUES 
		( 'Computación', 'Laptops, PCs y monitores'),
		('Accesorios', 'Periféricos y complementos'),
		('Audio', 'Auriculares y parlantes'),
		('Almacenamiento', 'Discos y memorias')


-- comprobar la carga de datos exitosa

SELECT * FROM categorias

	
-- Carga de datos en la tabla clientes

INSERT INTO clientes (nombre, email, ciudad, fecha_registro)
	VALUES
		('María López', 'maria@mail.com', 'Buenos Aires', '2024-01-05'),
		('Carlos Ruíz', 'carlos@mail.com', 'Córdoba', '2024-01-10'),
		('Ana Gómez', 'ana@mail.com', 'Rosario', '2024-02-01'),
		('Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15'),
		('Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01')

-- comprobar la carga de datos exitosa

SELECT * FROM clientes


-- carga de datos en la tabla productos

INSERT INTO productos (nombre_producto, id_categoria, precio, stock, activo)

	VALUES 
		('Laptop Pro 15', 1, 1200.00, 15, 1),
		('Mouse Inalámbrico', 2, 28.00, 80, 1),
		('Monitor 4K 27"', 1, 450.00, 12, 1),
		('Auriculares BT Pro', 3, 120.00, 35, 1),
		('SSD Externo 1TB',     4,  130.00, 18, 1),
		('Teclado Mecánico',    2,   95.00, 40, 1)

-- comprobar la carga de datos exitosa

SELECT * FROM productos


-- carga de datos en la tabla ventas

INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
	VALUES 
		(1, 1, 2, 1200.00, '2024-03-05'),
		(2, 2, 5, 28.00, '2024-03-06'),
		(3, 3, 1, 450.00, '2024-03-07'),
		(1, 4, 2, 120.00, '2024-03-08'),
		(4, 5, 3, 130.00, '2024-03-10'),
		(2, 6, 4, 95.00, '2024-03-11'),
		(5, 1, 1, 1200.00, '2024-03-12'),
		(3, 2, 8, 28.00, '2024-03-13'),
		(4, 4, 1, 120.00, '2024-03-14'),
		(5, 3, 2, 450.00, '2024-03-15');

-- Comprobar si se cargaron los datos exitosamente en la  tabla ventas

SELECT * FROM ventas

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
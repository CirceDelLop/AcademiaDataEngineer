DROP DATABASE tiendaArticulos;
CREATE DATABASE tiendaArticulos;
USE tiendaArticulos;
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50));
    
CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    precio DECIMAL(10, 2),
    id_categoria INT,
    stock INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria));

CREATE TABLE clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(100),
    email VARCHAR(50));

CREATE TABLE ventas(
	id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    cantidad INT,
    id_cliente INT,
    fecha DATE,
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente));

INSERT INTO categorias(nombre_categoria)
VALUES 
	("XBOX"),
    ("Tenis"),
    ("Ropa"),
    ("Articulos para jovenes");

INSERT INTO productos(nombre_producto, precio, id_categoria, stock)
VALUES 
	('Xbox Series X', 499.99, 1, 30),
    ('Xbox Series S', 299.99, 1, 50),
    ('Tenis Nike Air Max', 120.00, 2, 100),
    ('Tenis Adidas Ultraboost', 180.00, 2, 80),
    ('Camiseta Nike', 25.00, 3, 200),
    ('Pantalón Levi\'s', 45.00, 3, 150),
    ('Mochila para jóvenes', 35.00, 4, 120),
    ('Auriculares para jóvenes', 60.00, 4, 75);

INSERT INTO clientes(nombre_cliente, email)
VALUES
	('Carlos Pérez', 'carlos@example.com'),
    ('Ana Gómez', 'ana@example.com'),
    ('Luis Martínez', 'luis@example.com'),
    ('Marta Rodríguez', 'marta@example.com');

INSERT INTO ventas(id_cliente, id_producto, cantidad, fecha) 
VALUES
	(1, 1, 2, '2025-01-05'),
	(2, 3, 1, '2025-01-10'),
	(3, 5, 3, '2025-01-12'),
	(4, 7, 1, '2025-01-14');

--  Obtener el total de compras realizadas por cada cliente usando INNER JOIN
SELECT 
    c.nombre_cliente AS Cliente,
    SUM(v.cantidad) AS Total_Compras
FROM
    ventas v
        INNER JOIN
    clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre_cliente;

-- ***SOLUCIÓN PROFESORA***
SELECT 
    clientes.nombre_cliente,
    SUM(ventas.cantidad) AS Total_cantidad
FROM
    ventas
        INNER JOIN
    clientes ON ventas.id_cliente = clientes.id_cliente
GROUP BY clientes.nombre_cliente;
/*-Usamos un INNER JOIN para combinar las tablas ventas y clientes a través del id_cliente.
  -Usamos COUNT(v.id_venta) para contar las ventas realizadas por cada cliente.
  -Agrupamos por el nombre del cliente (GROUP BY).*/

-- 1. Obtener los productos más vendidos (usando LEFT JOIN y SUM)
SELECT 
    p.nombre_producto AS Producto,
    SUM(v.cantidad) AS Total_ventas
FROM
    productos p
        LEFT JOIN
    ventas v ON p.id_producto = v.id_producto
GROUP BY p.nombre_producto
HAVING Total_ventas > 0
ORDER BY Total_ventas DESC;

-- ***SOLUCIÓN PROFESORA***
SELECT 
    productos.nombre_producto,
    SUM(ventas.cantidad) AS total_vendido
FROM
    productos
        LEFT JOIN
    ventas ON productos.id_producto = ventas.id_producto
GROUP BY productos.nombre_producto
ORDER BY total_vendido DESC;
/*-Usamos un LEFT JOIN para asegurarnos de que todos los productos se muestren, 
   incluso si no tienen ventas asociadas.
  -La función SUM(ventas.cantidad) nos da el total de unidades vendidas por cada producto.
  -Ordenamos por la cantidad total vendida en orden descendente.*/

-- 2. Obtener el precio promedio de los productos por categoría (usando AVG)
SELECT 
	c.nombre_categoria AS Categoria,
    AVG(p.precio) AS Precio_promedio
FROM categorias c
LEFT JOIN productos p
ON c.id_categoria=p.id_categoria
GROUP BY Categoria;

-- ***SOLUCIÓN PROFESORA***
SELECT 
    categorias.nombre_categoria,
    AVG(productos.precio) AS precio_promedio
FROM
    productos
        INNER JOIN
    categorias ON productos.id_categoria = categorias.id_categoria
GROUP BY categorias.nombre_categoria
LIMIT 0 , 1000;
/*-Usamos un INNER JOIN entre productos y categorias para combinar ambas tablas.
  -AVG(productos.precio) calcula el precio promedio de los productos en cada categoría.
  -Agrupamos por nombre_categoria.*/

-- 3. Obtener el producto más caro y el más barato (usando MAX y MIN)
SELECT
	nombre_producto AS Producto,
	 MAX(precio),
     MIN(precio)
FROM productos
WHERE precio = (SELECT MAX(precio) FROM productos) or precio = (SELECT MIN(precio) FROM productos)
GROUP BY nombre_producto;

-- ***SOLUCIÓN PROFESORA***
SELECT 
    MAX(precio) AS producto_mas_caro,
    MIN(precio) AS producto_mas_barato
FROM
    productos;
/*-Usamos MAX(precio) para obtener el precio más alto.
  -Usamos MIN(precio) para obtener el precio más bajo.*/

/* 4. Obtener la cantidad total de productos vendidos y el total de 
   ventas por cliente subconsulta*/
-- ***SOLUCIÓN PROFESORA***
SELECT 
    clientes.nombre_cliente,
    (SELECT 
            SUM(ventas.cantidad)
        FROM
            ventas
        WHERE
            ventas.id_cliente = clientes.id_cliente) AS cantidad_total_comprada,
    (SELECT 
            SUM(ventas.cantidad * productos.precio)
        FROM
            ventas
                INNER JOIN
            productos ON ventas.id_producto = productos.id_producto
        WHERE
            ventas.id_cliente = clientes.id_cliente) AS total_venta
FROM
    clientes
LIMIT 0 , 1000;
/*-Las subconsultas calculan la cantidad total de productos
   comprados y el total de ventas para cada cliente.
  -La primera subconsulta calcula la cantidad total de productos que un
   cliente ha comprado.
  -La segunda subconsulta calcula el total de dinero gastado por un cliente, 
   multiplicando la cantidad de productos por su precio.*/

-- 5. Obtener los productos con stock bajo (usando WHERE y COUNT)
SELECT 
	nombre_producto AS Producto,
    stock
FROM productos
WHERE stock < 50;

-- ***SOLUCIÓN PROFESORA***
SELECT 
    nombre_producto,
    stock,
    (SELECT 
            COUNT(*)
        FROM
            productos
        WHERE
            stock < 50) AS cantidad_productos_bajos
FROM
    productos
WHERE
    stock < 50
ORDER BY stock ASC;

SELECT 
    nombre_producto, stock
FROM
    productos
WHERE
    stock < 50;
/*Usamos WHERE stock < 50 para filtrar los productos con stock bajo*/

-- 6. Obtener los productos que han sido comprados por más de un cliente.
SELECT 
    p.nombre_producto AS Nombre,
    COUNT(DISTINCT v.id_cliente) AS Cantidad_clientes
FROM
    productos p
        JOIN
    ventas v ON p.id_producto = v.id_producto
GROUP BY p.id_producto , p.nombre_producto
HAVING COUNT(DISTINCT v.id_cliente) > 1;

-- ***SOLUCIÓN PROFESORA***
SELECT 
    productos.nombre_producto,
    COUNT(DISTINCT ventas.id_cliente) AS clientes_distintos
FROM
    productos
        JOIN
    ventas ON productos.id_producto = ventas.id_producto
GROUP BY productos.nombre_producto
HAVING COUNT(DISTINCT ventas.id_cliente) > 1;
/*-JOIN: Unimos las tablas productos y ventas a través de id_producto 
   para conocer qué clientes han comprado cada producto.
  -COUNT(DISTINCT ventas.id_cliente): Contamos los clientes distintos 
   que han comprado cada producto. Utilizamos DISTINCT para evitar 
   contar más de una vez a un mismo cliente si compró el mismo producto 
   varias veces.
  -HAVING: Filtramos para mostrar solo los productos que han sido 
   comprados por más de un cliente.*/

-- 7. Obtener el total de ventas por cada categoría
SELECT
	c.nombre_categoria AS Categoria,
    COUNT(v.id_producto) AS Total_ventas
FROM categorias c
JOIN productos p
ON c.id_categoria=p.id_categoria
JOIN ventas v
ON p.id_producto=v.id_producto
GROUP BY c.id_categoria, c.nombre_categoria;    

-- ***SOLUCIÓN PROFESORA***
SELECT 
    clientes.nombre_categoria,
    SUM(ventas.cantidad * producto.precio) AS total_ventas_categoria
FROM
    categorias
        JOIN
    productos ON clientes.id_categoria = productos.id_categoria
        JOIN
    ventas ON productos.id_producto = ventas.id_producto
GROUP BY c.nombre_categoria
ORDER BY total_ventas_categoria DESC;
/*-JOIN: Unimos las tablas categorias, productos y ventas para obtener 
   toda la información necesaria para calcular las ventas por categoría.
  -SUM(ventas.cantidad * producto.precio): Calculamos el total de ventas 
   multiplicando la cantidad vendida por el precio de cada producto.
  -GROUP BY: Agrupamos por nombre_categoria para obtener los totales por 
  categoría.
  -ORDER BY: Ordenamos por el total de ventas en orden descendente para 
   que las categorías con mayores ventas aparezcan primero.*/

-- 8. Obtener los productos que no han sido vendidos
SELECT 
    p.nombre_producto AS Producto,
    SUM(v.cantidad) AS Total_ventas
FROM
    productos p
        LEFT JOIN
    ventas v ON p.id_producto = v.id_producto
GROUP BY p.nombre_producto
HAVING Total_ventas = 0 OR Total_ventas IS NULL;

-- ***SOLUCIÓN PROFESORA***
SELECT 
    productos.nombre_producto, productos.stock
FROM
    productos
        LEFT JOIN
    ventas ON productos.id_producto = ventas.id_producto
WHERE
    ventas.id_venta IS NULL;
/*-LEFT JOIN: Unimos las tablas productos y ventas utilizando 
   un LEFT JOIN. Esto incluye todos los productos, incluso 
   aquellos que no tienen ventas registradas.
  -WHERE ventas.id_venta IS NULL: Filtramos para obtener solo
   aquellos productos que no tienen ninguna venta asociada 
   (es decir, aquellos productos que no tienen una venta en 
   la tabla ventas).*/


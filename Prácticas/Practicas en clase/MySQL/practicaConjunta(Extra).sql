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
FROM ventas v
INNER JOIN clientes c
ON v.id_cliente=c.id_cliente
GROUP BY c.nombre_cliente;

-- 1. Obtener los productos más vendidos (usando LEFT JOIN y SUM)
SELECT 
	p.nombre_producto AS Producto,
    SUM(v.cantidad) AS Total_ventas
FROM productos p
LEFT JOIN ventas v
ON p.id_producto=v.id_producto
GROUP BY p.nombre_producto
HAVING Total_ventas>0
ORDER BY Producto_mas_vendido DESC;

-- 2. Obtener el precio promedio de los productos por categoría (usando AVG)
SELECT 
	c.nombre_categoria AS Categoria,
    AVG(p.precio) AS Precio_promedio
FROM categorias c
LEFT JOIN productos p
ON c.id_categoria=p.id_categoria
GROUP BY Categoria;

-- 3. Obtener el producto más caro y el más barato (usando MAX y MIN)
SELECT
	nombre_producto AS Producto,
	precio AS Precio
FROM productos
WHERE precio = (SELECT MAX(precio) FROM productos) or precio = (SELECT MIN(precio) FROM productos);

-- 4. Obtener los productos con stock bajo (usando WHERE y COUNT)
SELECT 
	nombre_producto AS Producto,
    stock
FROM productos
WHERE stock < 100; -- (SELECT COUNT(stock) FROM productos);

-- 5. Obtener los productos que han sido comprados por más de un cliente.
SELECT p.nombre_producto AS Nombre, COUNT(DISTINCT v.id_cliente) AS Cantidad_clientes  
FROM productos p
JOIN ventas v
ON p.id_producto=v.id_producto
GROUP BY p.id_producto, p.nombre_producto
HAVING COUNT(DISTINCT v.id_cliente) > 1;

-- 6. Obtener el total de ventas por cada categoría
SELECT
	c.nombre_categoria AS Categoria,
    COUNT(v.id_producto) AS Total_ventas
FROM categorias c
JOIN productos p
ON c.id_categoria=p.id_categoria
JOIN ventas v
ON p.id_producto=v.id_producto
GROUP BY c.id_categoria, c.nombre_categoria;    

-- 7. Obtener los productos que no han sido vendidos
SELECT 
	p.nombre_producto AS Producto,
    SUM(v.cantidad) AS Total_ventas
FROM productos p
LEFT JOIN ventas v
ON p.id_producto=v.id_producto
GROUP BY p.nombre_producto
HAVING Total_ventas=0 or Total_ventas IS NULL;
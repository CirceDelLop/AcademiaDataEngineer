CREATE DATABASE empresa;
USE empresa;

CREATE TABLE clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50));

CREATE TABLE pedidos(
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    total DECIMAL(10,2),
    fecha_pedido DATE,
    id_cliente INT);

INSERT INTO clientes VALUES
	(1,"Circe Delgadillo"),
    (2,"Julio Vargas"),
    (3,"Tomas Galicia"),
    (4,"Laura Valverde");

INSERT INTO pedidos (total,fecha_pedido,id_cliente) VALUES
	(400.30,"2025-01-07",2),
    (105.45,"2025-01-10",1),
    (259.22,"2025-01-13",4),
    (368.58,"2025-01-01",3);
    
SELECT nombre
FROM clientes
WHERE id_cliente IN (SELECT id_cliente   
                     FROM pedidos   
                     WHERE fecha_pedido BETWEEN '2025-01-01' AND '2025-01-14');

CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),
    categoria VARCHAR(50));

INSERT INTO productos(nombre,precio,categoria)
VALUES
	("Agual ciel 1L",10.50,"Bebidas"),
    ("Refresco cola 1L",25.60,"Bebidas"),
    ("Chicarrones",15.24,"Botanas"),
    ("Creveza 650ml",27.56,"Cervezar y licores");

SELECT categoria, AVG(precio) AS Promedio_ventas, SUM(precio) AS Suma_ventas   
FROM productos   
GROUP BY categoria;

USE empresa;
ALTER TABLE pedidos ADD region VARCHAR(50);
UPDATE pedidos SET region = CASE
	WHEN id_pedido = 1 THEN "Norte"
    WHEN id_pedido = 2 THEN "Sur"
    WHEN id_pedido = 3 THEN "Norte"
    WHEN id_pedido = 4 THEN "Sur"
    END
WHERE id_pedido IN (1,2,3,4);

SELECT c.nombre, p.region   
FROM clientes c   
JOIN pedidos p ON c.id_cliente = p.id_cliente   
WHERE p.total > 500;

SELECT * FROM pedidos;

-- Ejercicio propuesto Profesora
-- Cantidad de ventas realizadas por cada empleado
INSERT INTO Empleados (nombre, salario, id_departamento,edad,region,ventas)
VALUES
    ('Juan Pérez', 25000.00, 1,20,"Norte",4),
    ('María López', 30000.00, 2,35,"Sur",9),
    ('Luis Gómez', 28000.00, 3,47,"Norte",2),
    ('Ana García', 27000.00, 3,35,"Centro",30),
    ('Carlos Torres', 35000.00, 2,20,"Norte",10);

SELECT * FROM empleados;

SELECT nombre, SUM(ventas) AS Total_ventas
FROM empleados
GROUP BY nombre;
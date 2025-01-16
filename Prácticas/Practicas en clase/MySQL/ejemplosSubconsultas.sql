-- Ejemplo 1
SELECT nombre, salario
FROM empleados   
WHERE salario > (SELECT AVG(salario) FROM empleados); 

-- Ejemplo 2
ALTER TABLE empleados ADD region VARCHAR(50);
ALTER TABLE empleados ADD ventas int;

UPDATE empleados SET region = CASE
	WHEN id_empleado = 1 or id_empleado = 5 or id_empleado = 10 THEN "Norte"
    WHEN id_empleado = 2 or id_empleado = 6 or id_empleado = 9 THEN "Sur"
    WHEN id_empleado = 3 or id_empleado = 7 or id_empleado = 8 THEN "Norte"
    WHEN id_empleado = 4 THEN "Centro"
    END
WHERE id_empleado IN (1,2,3,4,5,6,7,8,9,10);

UPDATE empleados SET ventas = CASE
	WHEN id_empleado = 1 or id_empleado = 5 or id_empleado = 10 THEN 20
    WHEN id_empleado = 2 or id_empleado = 6 or id_empleado = 9 THEN 10
    WHEN id_empleado = 3 or id_empleado = 7 or id_empleado = 8 THEN 17
    WHEN id_empleado = 4 THEN 0
    END
WHERE id_empleado IN (1,2,3,4,5,6,7,8,9,10);

SELECT region, SUM(ventas) AS total_ventas
FROM empleados
GROUP BY region;

-- Ejemplo 3
CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2));

INSERT INTO productos VALUES
	("Agua ciel",10.50);
-- Identificar las columnas necesarias: nombre, edad. 
ALTER TABLE empleados ADD edad int;

UPDATE empleados 
SET 
	edad=20
WHERE 
	id_empleado=1 or id_empleado=5 or id_empleado=10;

UPDATE empleados 
SET 
	edad=35 
WHERE 
	id_empleado=2 or id_empleado=4 or id_empleado=9;

UPDATE empleados 
SET 
	edad=47 
WHERE 
	id_empleado=3 or id_empleado=7 or id_empleado=8;

UPDATE empleados 
SET 
	edad=56 
WHERE
	id_empleado=6;

-- Usar SELECT y especificar la tabla empleados
SELECT nombre,edad FROM empleados;
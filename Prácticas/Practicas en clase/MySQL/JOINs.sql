CREATE DATABASE practicarjoin;
USE practicarjoin;
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    salario DECIMAL(10, 2),
    id_departamento INT
);

CREATE TABLE Departamentos (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_departamento VARCHAR(50)
);

INSERT INTO departamentos (nombre_departamento)
VALUES 
    ('Recursos Humanos'),
    ('Desarrollo'),
    ('Ventas'),
    ('Marketing');

INSERT INTO Empleados (nombre, salario, id_departamento)
VALUES
    ('Juan Pérez', 25000.00, 1),
    ('María López', 30000.00, 2),
    ('Luis Gómez', 28000.00, 3),
    ('Ana García', 27000.00, NULL),
    ('Carlos Torres', 35000.00, 2);
    
SELECT 
    Empleados.nombre AS Nombre_Empleado,
    Departamentos.nombre_departamento AS Departamento,
    Empleados.salario AS Salario
FROM 
    Empleados
INNER JOIN 
    Departamentos
ON 
    Empleados.id_departamento = Departamentos.id_departamento;
    
SELECT 
    Empleados.nombre AS Nombre_Empleado,
    Departamentos.nombre_departamento AS Departamento,
    Empleados.salario AS Salario
FROM 
    Empleados
LEFT JOIN 
    Departamentos
ON 
    Empleados.id_departamento = Departamentos.id_departamento;

SELECT 
    Empleados.nombre AS Nombre_Empleado,
    Departamentos.nombre_departamento AS Departamento,
    Empleados.salario AS Salario
FROM 
    Empleados
RIGHT JOIN 
    Departamentos
ON 
    Empleados.id_departamento = Departamentos.id_departamento;

-- En la practica del join agregar tres departamentos,
-- agregar 3 personas con datos completos, y dos con null.
INSERT INTO departamentos (nombre_departamento)
VALUES 
    ('Informatica'),
    ('Seguridad'),
    ('Reclutamiento');
 
INSERT INTO Empleados (nombre, salario, id_departamento)
VALUES
    ('Jose Delgadillo', 20000.00, 4),
    ('Laura Valverde', 35000.00, 5),
    ('Tomas Galicia', 22000.00, 6),
    ('Jesus Ruiz', 27000.00, NULL),
    ('Carla Torres', 29000.00, NULL);
    
SELECT 
    Empleados.nombre AS Nombre_Empleado,
    Departamentos.nombre_departamento AS Departamento,
    Empleados.salario AS Salario
FROM 
    Empleados
INNER JOIN 
    Departamentos
ON 
    Empleados.id_departamento = Departamentos.id_departamento;
    
SELECT 
    Empleados.nombre AS Nombre_Empleado,
    Departamentos.nombre_departamento AS Departamento,
    Empleados.salario AS Salario
FROM 
    Empleados
LEFT JOIN 
    Departamentos
ON 
    Empleados.id_departamento = Departamentos.id_departamento;

SELECT 
    Empleados.nombre AS Nombre_Empleado,
    Departamentos.nombre_departamento AS Departamento,
    Empleados.salario AS Salario
FROM 
    Empleados
RIGHT JOIN 
    Departamentos
ON 
    Empleados.id_departamento = Departamentos.id_departamento;
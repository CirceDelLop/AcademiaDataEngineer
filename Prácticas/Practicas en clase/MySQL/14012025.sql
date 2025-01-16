create database practicas;
use practicas;
create table empleados(nombre varchar(50),edad int);
select * from empleados;
insert into empleados values("Circe",30);
insert into empleados values("Jose",56);
select * from empleados;
insert into empleados values("Hanna",56);
create database practicas2;
use practicas2;
create table empleados2(nombre varchar(50),edad int);
insert into empleados2 values("Brandon",26);
insert into empleados2 values("Brenda",24);
select * from empleados2;
select * from empleados where edad > 30;
select * from empleados where edad >=30;

alter table empleados add ventas int;
alter table empleados add descripcion varchar(50);
alter table empleados add fecha date;

insert into empleados values("Eduardo",35,0,"electrodomesticos","2025-01-3");
insert into empleados values("Carla",25,4,"electrodomesticos","2025-01-13");
insert into empleados values("Francisco",25,10,"electrodomesticos","2025-01-10");
insert into empleados values("Jesus",25,0,"electrodomesticos","2025-01-7");

select * from empleados;
select nombre,ventas,fecha from empleados where fecha>"2025-01-01" and fecha<"2025-01-31"; -- month(numMes)
select nombre,ventas,fecha from empleados where ventas=0;

CREATE DATABASE practicajoin;
USE practicajoin;
CREATE TABLE izquierda (
    izquierda1 VARCHAR(50),
    izquierda2 VARCHAR(50),
    izquierda3 VARCHAR(50)
);
CREATE TABLE derecha (
    derecha1 VARCHAR(50),
    derecha2 VARCHAR(50),
    derecha3 VARCHAR(50)
);
CREATE TABLE frente (
    frente1 VARCHAR(50),
    frente2 VARCHAR(50),
    frente3 VARCHAR(50)
);

INSERT INTO izquierda values("uno","dos","tres");
INSERT INTO derecha VALUES ("cuatro","cinco","seis");
INSERT INTO derecha VALUES("uno","dos","tres");
INSERT INTO frente VALUES ("siete","ocho","nueve");
INSERT INTO frente VALUES("cuatro","cinco","seis");

SELECT 
    *
FROM
    izquierda;
SELECT 
    *
FROM
    derecha;
SELECT 
    *
FROM
    frente;

SELECT 
    f.frente1 AS frente, d.derecha1 AS derecha
FROM
    frente AS f
        RIGHT JOIN
    derecha AS d ON f.frente2 = d.derecha2;

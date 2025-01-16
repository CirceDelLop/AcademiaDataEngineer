USE empresa;
-- Suponiendo que se tienen dos tablas: ventas y productos.
-- Obtener una lista de todas las ventas realizadas junto
-- con la información de los productos vendidos.

-- Se  desea ver todos los productos, incluso si no han
-- sido vendidos, y las ventas asociadas (si las hay).
select * from pedidos;
ALTER TABLE pedidos ADD id_producto INT;
UPDATE pedidos set id_producto=CASE
	WHEN id_pedido=1 or id_pedido=3 THEN 3
    WHEN id_pedido=2 or id_pedido=4 THEN 1
    END
WHERE id_pedido IN (1,2,3,4);
SELECT p.nombre as Producto, v.id_pedido as Num_venta
FROM productos p LEFT JOIN pedidos v
ON p.id_producto=v.id_producto;
-- Ver todas las ventas realizadas, incluso aquellas para
-- productos que ya no están disponibles o no tienen detalles
-- en la base de datos.
 
 -- Tienes tres tablas: VENTAS  PRODUCTOS y CLIENTES. 
 -- Obtener la lista de ventas, los productos vendidos, la
 -- cantidad y los clientes que realizaron esas compras.
 
 -- Saber qué productos están en el inventario pero no han sido vendidos.
 
 -- Supón que hay un problema en la base de datos y algunas
 -- ventas no están asociadas con productos registrados.
 -- Deseas ver todas las ventas, incluso aquellas sin un
 -- producto correspondiente.
INSERT INTO pedidos(total,fecha_pedido,id_cliente,region)
VALUES 
	(557.92,"2025-01-11",3,"Centro");
SELECT v.id_pedido as Num_venta, p.nombre as Producto
FROM productos p RIGHT JOIN pedidos v
ON p.id_producto=v.id_producto;
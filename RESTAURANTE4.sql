--a) Crear la base de datos con el archivo create_restaurant_db.sql
--b) Explorar la tabla “menu_items” para conocer los productos del menú.
SELECT * FROM menu_items;

--- 1. Realizar consultas para contestar las siguientes preguntas:

---Encontrar el número de artículos en el menú.
SELECT COUNT (menu_item_id) FROM menu_items;
R= 32 artículos 
---¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT item_name, price FROM menu_items
ORDER BY price ASC
LIMIT 1;
R= Edamame, es el artículo menos caro, al tener un precio de 5.00.

SELECT item_name, price FROM menu_items
ORDER BY price DESC
LIMIT 1;
R= Shrimp Scampi, es el artículo más caro, al tener un precio de 19.95. 

---¿Cuántos platos americanos hay en el menú?
SELECT COUNT (category) AS platillos_americanos FROM menu_items
WHERE category='American';
R= Hay seis platillos americanos.

---¿Cuál es el precio promedio de los platos?
SELECT ROUND (AVG(price),2) AS precio_prom FROM menu_items;
R= El precio promedio de los platos es 13.29.

--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 
SELECT * FROM order_details;

--1.- Realizar consultas para contestar las siguientes preguntas:
---¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT (DISTINCT order_id) AS pedidos_unicos FROM order_details;
R= 5370 platillos unicos. 

---¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT * FROM order_details;
SELECT order_id, COUNT(item_id)
FROM order_details
GROUP BY order_id
ORDER BY COUNT(item_id) DESC
LIMIT 5;
R= Los pedidos con el mayor numero de articulos (14) fueron: 440, 2675, 3473, 4305, 443.

---¿Cuándo se realizó el primer pedido y el último pedido?
SELECT order_id, order_date FROM order_details
ORDER BY order_date ASC;
R= El primer pedido se realizó el día 2023-01-01.
SELECT order_id, order_date FROM order_details
ORDER BY order_date DESC;
R= El último pedido se realizó el día 2023-03-31.

---¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT COUNT (DISTINCT order_id) AS cantidad_pedidos FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';
R= Se realizarón 308 pedidos entre el '2023-01-01' y el '2023-01-05'. 

---Realizar un left join entre entre order_details y menu_items con el identificador
---item_id(tabla order_details) y menu_item_id(tabla menu_items).
SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m
ON o.item_id=m.menu_item_id;

---1. ¿Cuáles fueron los platillos más pedidos del menú?
SELECT COUNT (o.order_id), m.item_name
FROM order_details AS o
LEFT JOIN menu_items AS m
ON o.item_id=m.menu_item_id
GROUP BY m.item_name
ORDER BY COUNT (o.order_id) DESC 
LIMIT 3;
R= Los tres platillos más pedidos fueron: 622 Hamburger, 620 Edamame y 588 Korean Beef Bowl.

---2. ¿Cuáles fueron los platillos menos pedidos del menú?
SELECT COUNT (o.order_id), m.item_name
FROM order_details AS o
LEFT JOIN menu_items AS m
ON o.item_id=m.menu_item_id
GROUP BY m.item_name
ORDER BY COUNT (o.order_id) ASC 
LIMIT 4;
R= Los tres platillos menos pedidos fueron: 123 Chiken tacos, 205 Potstickers y 207 Cheese Lasagna.

---3. ¿Cuántos platos mexicanos hay en el menú?
SELECT COUNT (category) AS platillos_mexicanos FROM menu_items
WHERE category='Mexican';
R= Hay nueve platillos mexicanos en el menú. 

---4. ¿Cantidad de ordenes que no concluyerón y tienen dato nulo en precio?
SELECT * FROM order_details AS o
LEFT JOIN menu_items AS m
ON o.item_id=m.menu_item_id
WHERE price is null;
R= Son 137 las ordenes que no se concluyeron, por lo tanto su dato en precio es nulo. 

---5. ¿Cuál es la categoría con más ventas (precio)?
SELECT category, COUNT (category) AS cantidad_platillos, SUM (price) AS precio_platillos FROM (SELECT ORD.ORDER_DETAILS_ID, ORD.ORDER_ID, ORD.ORDER_DATE,ORD.ORDER_TIME, ME.ITEM_NAME, ME.CATEGORY, ME.PRICE FROM ORDER_DETAILS AS ORD
LEFT JOIN MENU_ITEMS AS ME ON ORD.ITEM_ID = ME.MENU_ITEM_ID)
GROUP BY 1
HAVING SUM(PRICE) IS NOT NULL
ORDER BY precio_platillos DESC; 
R= La comida italiana es la categoría que generó más ventas. 
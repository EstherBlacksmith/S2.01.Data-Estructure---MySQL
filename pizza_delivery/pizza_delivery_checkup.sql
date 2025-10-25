-- CHECKUPS
-- List how many products in the 'drink' category has been sold in one determined locality
SELECT COUNT(quantity) AS 'Total drinks from Ankh-Morpok' FROM product
		INNER JOIN  orders_products ON product.idproduct = product.idproduct	   
		INNER JOIN  orders  ON orders_products.orders_id = orders.id
        INNER JOIN  address ON orders.address_id = address.id        
        INNER JOIN locality ON address.locality_id = locality.id
WHERE product.type = 'drinks' AND locality.name = 'Ankh-Morpok';

-- List how many orders a given employee has placed.
SELECT COUNT(orders.id) FROM  orders 
		INNER JOIN worker ON employee_id = worker.personal_data_id
		INNER JOIN personal_data ON personal_data.id = worker.personal_data_id 
WHERE personal_data.name = 'Ana';

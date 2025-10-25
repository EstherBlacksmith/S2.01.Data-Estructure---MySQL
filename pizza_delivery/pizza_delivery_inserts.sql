USE pizza_delivery;
TRUNCATE TABLE province;
TRUNCATE TABLE locality;
TRUNCATE TABLE address;
TRUNCATE TABLE shop;
TRUNCATE TABLE personal_data;
TRUNCATE TABLE worker;
TRUNCATE TABLE pizza_category;
TRUNCATE TABLE product;
TRUNCATE TABLE pizza;
TRUNCATE TABLE orders;
TRUNCATE TABLE orders_products;

INSERT INTO province (name) VALUES 
('Colonia Beta'), 
('Barrayar'),
('Jackson''s Whole');


INSERT INTO locality (name, province_id) VALUES 
('Trantor', 1),
('Tau Ceti Center', 1),
('Ankh-Morpok', 2),
('Asgard', 3);

INSERT INTO address (street, street_num, locality_id, locality_province_id)
VALUES 
('Carrer de la Pizza', '12', 1,  1),
('Carrer de la Burger', '45', 2,  1),
('Avenida del Reparto', '23', 3,  2),
('Gran Via', '100', 4,  3),
('Calle de los Dragones', '33', 1,  1),
('Calle de las Estrellas', '77', 2, 1),
('Rambla de los Mundos', '56', 4, 3),
('Calle de los Portales', '22', 3, 2),
('Camino de la Hechicera', '19', 1,  1),
('Calle del Tiempo', '101', 1, 1),
('Avenida de los Sueños', '202', 2, 1),
('Camino del Espacio', '303', 3,  2),
('Calle del Bosque Antiguo', '404', 4,  3),
('Calle de las Estrellas Fugaces', '505', 1,  1),
('Rambla de los Portales', '606', 2,  1),
('Paseo del Fénix', '707', 3,  2),
('Calle de las Lunas', '808', 4,  3), 
('Camino del Cristal', '909', 1,1),
('Calle de las Sombras', '999', 3,  2);

INSERT INTO shop (address_id) VALUES 
(1), (2), (3), (4);

INSERT INTO personal_data (name, surname, phone_number, address_id, employee)
VALUES
('Ursula', 'Le Guin', '600111222', 5, 0),       
('Laura', 'Martínez', '600333444', 2, 1),       
('Pedro', 'López', '600555666', 3, 1),          
('Ana', 'Serrano', '600777888', 4, 1),          
('Marta', 'Torres', '600999000', 6, 1),         
('Octavia', 'Butler', '601111222', 7, 0),     
('Anne', 'McCaffrey', '601333444', 8, 0),     
('Lois', 'Hobb', '601555666', 9, 0),         
('Elena', 'Ramírez', '601777888', 1, 1),      
('Iván', 'Suárez', '601999000', 3, 1),        
('N.K.', 'Jemisin', '602111222', 5, 0),       
('Madeleine', 'L’Engle', '602333444', 6, 0),  
('Mary', 'Shelley', '602555111', 10, 0),      
('Margaret', 'Atwood', '602555222', 11, 0),   
('C.J.', 'Cherryh', '602555333', 12, 0),      
('Tananarive', 'Due', '602555444', 13, 0),    
('Naomi', 'Novik', '602555555', 14, 0),       
('V.', 'E. Schwab', '602555666', 15, 0),       
('Suzanne', 'Collins', '602555777', 16, 0),    
('Nnedi', 'Okorafor', '602555888', 17, 0),     
('Diana', 'Wynne Jones', '602555999', 18, 0),  
('Andre', 'Norton', '602556000', 19, 0);       

INSERT INTO worker (nif, personal_data_id, shop_id, rol)
VALUES
(12345678, 2, 1, 'dealer'),
(87654321, 3, 2, 'cook'),
(54321678, 4, 3, 'dealer'),
(65432187, 5, 4, 'cook'),
(11223344, 9, 1, 'dealer'),
(99887766, 10, 2, 'cook');

INSERT INTO pizza_category (name) VALUES 
('Clásica'), 
('Gourmet'), 
('Vegetariana'),
('Picante'),
('Especial de la Casa');

INSERT INTO product (name, description, price, type)
VALUES
('Margarita', 'Pizza clásica con tomate y mozzarella', 8.50, 'pizza'),
('Cuatro Quesos', 'Pizza con mezcla de quesos italianos', 9.00, 'pizza'),
('Diavola', 'Pizza con pepperoni y toque picante', 9.50, 'pizza'),
('Veggie', 'Pizza con vegetales frescos', 8.75, 'pizza'),
('Carbonara', 'Pizza con bacon, huevo y parmesano', 10.00, 'pizza'),
('Burger BBQ', 'Hamburguesa con salsa barbacoa', 7.50, 'burguer'),
('Cheeseburger', 'Hamburguesa con queso cheddar', 6.90, 'burguer'),
('Cola', 'Bebida refrescante de cola', 2.00, 'drinks'),
('Agua', 'Agua mineral', 1.50, 'drinks'),
('Cerveza', 'Cerveza artesanal', 3.00, 'drinks');

INSERT INTO pizza (product_idproduct, pizza_category_id)
VALUES
(1, 1), 
(2, 2), 
(3, 4), 
(4, 3), 
(5, 5); 

INSERT INTO orders (address_id, delivery, total_price, employee_id, client_id)
VALUES

(3, 1, 25.00, 2, 1),
(null, 0, 18.50, 3, 6),
(7, 1, 30.75, 4, 7), 
(3, 1, 22.90, 9, 8),
(null,0, 15.00, 10, 11),
(null,0, 9.50, 10, 12),
(11, 1, 19.80, 2, 13),
(null,0, 11.00, 5, 14),
(15, 1, 28.20, 4, 15),
(null, 0, 10.50, 10, 16);


INSERT INTO orders_products (quantity, product_idproduct, orders_id)
VALUES
(2, 1, 1),
(1, 8, 1),
(2, 3, 2),
(3, 4, 3),
(1, 9, 3),
(1, 2, 4),
(1, 10, 4),
(1, 6, 5),
(1, 5, 6),
(1, 7, 7),
(2, 2, 8),
(1, 8, 8),
(2, 1, 9),
(1, 4, 10);

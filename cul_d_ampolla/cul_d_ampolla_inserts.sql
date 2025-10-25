USE cul_d_ampolla;

TRUNCATE TABLE addresses;
TRUNCATE TABLE brand;
TRUNCATE TABLE customer;
TRUNCATE TABLE glasses;
TRUNCATE TABLE person;
TRUNCATE TABLE sales;
TRUNCATE TABLE supplier;
-- -------------------------
-- PERSONAS (empleados y clientes)
-- -------------------------
INSERT INTO person (name, surname, telephone_number, email, employee) VALUES
('Laura', 'García', '600123456', 'laura.garcia@email.com', 1),
('Carlos', 'Ruiz', '600654321', 'carlos.ruiz@email.com', 1),
('Marta', 'López', '611223344', 'marta.lopez@email.com', 0),
('Javier', 'Sánchez', '622334455', 'javier.sanchez@email.com', 0),
('Lucía', 'Martín', '633445566', 'lucia.martin@email.com', 0),
('Andrés', 'Ortega', '644556677', 'andres.ortega@email.com', 0),
('Nuria', 'Pérez', '655667788', 'nuria.perez@email.com', 0);

-- -------------------------
-- DIRECCIONES
-- -------------------------
INSERT INTO addresses (street, num, flat, door, stair, city, postal_code, country, person_id) VALUES
('Calle Mayor', 12, 2, 1, 'A', 'Madrid', '28001', 'España', 1),
('Avenida del Sol', 45, 3, 2, 'B', 'Barcelona', '08002', 'España', 2),
('Calle Luna', 5, 1, 1, NULL, 'Valencia', '46003', 'España', 3),
('Gran Vía', 98, 4, 3, 'C', 'Sevilla', '41004', 'España', 4),
('Calle Mar', 23, 2, 2, NULL, 'Bilbao', '48005', 'España', 5),
('Ronda Norte', 10, 1, 1, NULL, 'Zaragoza', '50006', 'España', 6),
('Carrer Nou', 88, 5, 2, 'D', 'Girona', '17001', 'España', 7);

-- -------------------------
-- SUPPLIERS (vinculados a empleados)
-- -------------------------
INSERT INTO supplier (nif, fax, person_id) VALUES
('A12345678', '915678900', 1),
('B98765432', NULL, 2);

-- -------------------------
-- BRANDS
-- -------------------------
INSERT INTO brand (brand_name, supplier_id) VALUES
('VisionPro', 1),
('OptiGlass', 2),
('ClearView', 1),
('UrbanEye', 2);

-- -------------------------
-- GAFAS
-- -------------------------
INSERT INTO glasses (frame_material, frame_color, left_graduation, right_graduation, left_color, right_color, brand_id) VALUES
('metal', 'Negro', -1.25, -1.50, 'Transparente', 'Transparente', 1),
('acetate', 'Rojo', -2.00, -1.75, 'Azul', 'Verde', 1),
('acrylic', 'Azul', 0.00, -0.50, 'Transparente', 'Transparente', 2),
('metal', 'Plateado', -0.75, -1.00, 'Transparente', 'Transparente', 3),
('acetate', 'Verde', -2.25, -2.25, 'Marrón', 'Marrón', 4),
('acrylic', 'Negro', -3.00, -3.25, 'Transparente', 'Transparente', 3),
('metal', 'Dorado', 1.25, 1.00, 'Amarillo', 'Amarillo', 2);

-- -------------------------
-- CLIENTES
-- -------------------------
INSERT INTO customer (registration_date, referral_id, person_id) VALUES
('2023-05-10 10:00:00', NULL, 3),
('2023-06-15 12:00:00', 3, 4),
('2023-07-20 09:30:00', 4, 5),
('2023-08-01 16:00:00', 5, 6),
('2023-09-10 11:45:00', 3, 7);

-- -------------------------
-- VENTAS (cliente ≠ empleado)
-- -------------------------
INSERT INTO sales (price, customer_id, employee_id, glasses_id) VALUES
(199.99, 3, 1, 1),
(249.50, 4, 2, 2),
(179.00, 5, 1, 3),
(225.75, 6, 2, 4),
(310.00, 7, 1, 5),
(195.90, 3, 2, 6),
(270.40, 4, 1, 7),
(189.99, 5, 2, 1),
(205.25, 6, 1, 2),
(299.99, 7, 2, 3),
(180.00, 3, 1, 4),
(265.50, 4, 2, 5);

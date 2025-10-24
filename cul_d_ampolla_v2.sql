-- ====================================================
-- SCHEMA: cul_d_ampolla (versión corregida y funcional)
-- ====================================================

DROP SCHEMA IF EXISTS `cul_d_ampolla`;
CREATE SCHEMA IF NOT EXISTS `cul_d_ampolla` DEFAULT CHARACTER SET utf8mb4;
USE `cul_d_ampolla`;

-- ==============================================
-- TABLE: addresses
-- ==============================================
CREATE TABLE `addresses` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `street` VARCHAR(120) NOT NULL,
  `num` INT NULL,
  `flat` INT NULL,
  `door` INT NULL,
  `stair` VARCHAR(12) NULL,
  `city` VARCHAR(80) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: contact_data
-- ==============================================
CREATE TABLE `contact_data` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `telephone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100),
  `address_id` INT NOT NULL,
  FOREIGN KEY (`address_id`) REFERENCES `addresses`(`id`)
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: glasses
-- ==============================================
CREATE TABLE `glasses` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `frame_material` ENUM('metal', 'acrylic', 'acetate') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `left_graduation` DECIMAL(4,2) NULL,
  `right_graduation` DECIMAL(4,2) NULL,
  `left_color` VARCHAR(45) NOT NULL DEFAULT 'Transparent',
  `right_color` VARCHAR(45) NOT NULL,
   FOREIGN KEY (`brand_id`) REFERENCES `brand`(`id`)
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: brand
-- ==============================================
CREATE TABLE `brand` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `brand_name` VARCHAR(45) NOT NULL
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: supplier
-- ==============================================
CREATE TABLE `supplier` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nif` VARCHAR(10) NOT NULL UNIQUE,
  `fax` VARCHAR(15),
  `brand_id` INT,
  FOREIGN KEY (`brand_id`) REFERENCES `brand`(`id`),
  FOREIGN KEY (`person_id`) REFERENCES `person`(`id`)

) ENGINE=InnoDB;

-- ==============================================
-- TABLE: customer
-- ==============================================
CREATE TABLE `customer` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `registration_date` DATE NOT NULL,
  `referral_id` INT NULL,
  `contact_data_id` INT,
  FOREIGN KEY (`person_id`) REFERENCES `person`(`id`)
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: sales
-- ==============================================
CREATE TABLE `sales` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `customer_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`),
  FOREIGN KEY (`glasses_id`) REFERENCES `glasses`(`id`),
  FOREIGN KEY (`employee_id`) REFERENCES `employee`(`id`)

) ENGINE=InnoDB;


-- ==============================================
-- TABLE: employee
-- ==============================================
CREATE TABLE `employee` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(80) NOT NULL,
  `surname` VARCHAR(80) NOT NULL,
  `contact_data_id` INT,
  FOREIGN KEY (`person_id`) REFERENCES `person`(`id`)
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: person
-- (relación general: puede representar cliente, empleado o proveedor)
-- ==============================================
CREATE TABLE `person` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(80) NOT NULL,
  `surname` VARCHAR(80) NOT NULL,
  `contact_data_id` INT,
  `customer_id` INT NULL,
  `employee_id` INT NULL,
  `supplier_id` INT NULL,
  FOREIGN KEY (`contact_data_id`) REFERENCES `contact_data`(`id`)
) ENGINE=InnoDB;

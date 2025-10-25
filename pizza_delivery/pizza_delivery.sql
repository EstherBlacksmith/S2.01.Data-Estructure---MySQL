-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizza_delivery
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizza_delivery` ;

-- -----------------------------------------------------
-- Schema pizza_delivery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizza_delivery` DEFAULT CHARACTER SET utf8 ;
USE `pizza_delivery` ;

-- -----------------------------------------------------
-- Table `pizza_delivery`.`province`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`province` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`province` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`locality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`locality` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`locality` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`id`, `province_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_locality_province_idx` (`province_id` ASC) VISIBLE,
  INDEX `province_id` (`province_id` ASC) VISIBLE,
  CONSTRAINT `fk_locality_province`
    FOREIGN KEY (`province_id`)
    REFERENCES `pizza_delivery`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`address` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NOT NULL,
  `street_num` VARCHAR(5) NOT NULL,
  `flat` VARCHAR(10) NULL,
  `stair` VARCHAR(5) NULL,
  `door` VARCHAR(5) NULL,
  `locality_id` INT NOT NULL, 
  `locality_province_id` INT NOT NULL,
  PRIMARY KEY (`id`, `locality_id`, `locality_province_id`),
  INDEX `fk_address_locality1_idx` (`locality_id` ASC, `locality_province_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_locality1`
    FOREIGN KEY (`locality_id` , `locality_province_id`)
    REFERENCES `pizza_delivery`.`locality` (`id` , `province_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`shop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`shop` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`shop` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_shop_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_shop_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `pizza_delivery`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`orders` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NULL,
  `delivery` TINYINT NULL DEFAULT 0,
  `total_price` DECIMAL(10,2) NULL,
  `date_orders` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),  
  `employee_id` INT  NOT NULL,
  `client_id` INT NOT NULL,    
  INDEX `fk_personal_data_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_address1`
    FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
     CONSTRAINT `fk_orders_employee`
    FOREIGN KEY (`employee_id`) REFERENCES `personal_data`(`id`),
  CONSTRAINT `fk_orderd_client`
    FOREIGN KEY (`client_id`) REFERENCES `personal_data`(`id`),
   PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `pizza_delivery`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`product` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`product` (
  `idproduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(150) NULL,
  `image` BLOB NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `type` ENUM("pizza", "burguer", "drinks") NOT NULL DEFAULT 'pizza',
  PRIMARY KEY (`idproduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`orders_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`orders_products` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`orders_products` (
  `quantity` INT NOT NULL,
  `product_idproduct` INT NOT NULL,
  `orders_id` INT NOT NULL,
  PRIMARY KEY (`product_idproduct`, `orders_id`),
  INDEX `fk_orders_products_order1_idx` (`orders_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_products_product1`
    FOREIGN KEY (`product_idproduct`)
    REFERENCES `pizza_delivery`.`product` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_products_order1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `pizza_delivery`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`pizza_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`pizza_category` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`pizza_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`personal_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`personal_data` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`personal_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(60) NOT NULL,
  `phone_number` VARCHAR(10) NULL DEFAULT 0,
  `address_id` INT NOT NULL,
  `employee` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_personal_data_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_personal_data_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `pizza_delivery`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`worker` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`worker` (
  `nif` INT NOT NULL,
  `personal_data_id` INT NOT NULL,
  `shop_id` INT NOT NULL,
  `rol` ENUM("cook", "dealer") NOT NULL DEFAULT 'dealer',
  PRIMARY KEY (`nif`, `personal_data_id`, `shop_id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_worker_personal_data1_idx` (`personal_data_id` ASC) VISIBLE,
  INDEX `fk_worker_shop1_idx` (`shop_id` ASC) VISIBLE,
  UNIQUE INDEX `personal_data_id_UNIQUE` (`personal_data_id` ASC) VISIBLE,
  CONSTRAINT `fk_worker_personal_data1`
    FOREIGN KEY (`personal_data_id`)
    REFERENCES `pizza_delivery`.`personal_data` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_worker_shop1`
    FOREIGN KEY (`shop_id`)
    REFERENCES `pizza_delivery`.`shop` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza_delivery`.`pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizza_delivery`.`pizza` ;

CREATE TABLE IF NOT EXISTS `pizza_delivery`.`pizza` (
  `product_idproduct` INT NOT NULL,
  `pizza_category_id` INT NOT NULL,
  PRIMARY KEY (`product_idproduct`, `pizza_category_id`),
  INDEX `fk_pizza_product1_idx` (`product_idproduct` ASC) VISIBLE,
  INDEX `fk_pizza_pizza_category1_idx` (`pizza_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_product1`
    FOREIGN KEY (`product_idproduct`)
    REFERENCES `pizza_delivery`.`product` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_pizza_category1`
    FOREIGN KEY (`pizza_category_id`)
    REFERENCES `pizza_delivery`.`pizza_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DELIMITER $$
CREATE TRIGGER trg_check_pizza_insert
BEFORE INSERT ON pizza
FOR EACH ROW
BEGIN
    DECLARE prod_type VARCHAR(20);

    -- Comprobamos si el producto existe
    SELECT type INTO prod_type 
    FROM product 
    WHERE idproduct = NEW.product_idproduct;

    -- Si no existe el producto, error
    IF prod_type IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The associated product doesn''t exists yet.';
    END IF;

    -- Si no es pizza, error
    IF prod_type <> 'pizza' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Just the pizza products can have pizza category.';
    END IF;
END$$


CREATE TRIGGER trg_check_pizza_update
BEFORE UPDATE ON pizza
FOR EACH ROW
BEGIN
    DECLARE prod_type VARCHAR(20);

    SELECT type INTO prod_type 
    FROM product 
    WHERE idproduct = NEW.product_idproduct;

    IF prod_type IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The associated product doesn''t exists yet.';
    END IF;

    IF prod_type <> 'pizza' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Just the pizza products can have pizza category.';
    END IF;
END$$


CREATE TRIGGER trg_check_orders_before_insert
BEFORE INSERT ON `orders`
FOR EACH ROW
BEGIN
    DECLARE w_role ENUM('cook','dealer');

    IF NEW.client_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A client must be assigned to the order.';
    END IF;

    IF NEW.employee_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee must be assigned to the order.';
    END IF;

    IF NEW.client_id = NEW.employee_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee and client cannot be the same person.';
    END IF;

    SELECT rol INTO w_role
    FROM worker
    WHERE personal_data_id = NEW.employee_id
    LIMIT 1;

    IF NEW.delivery = 1 AND w_role <> 'dealer' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only dealers can be assigned to a delivery order.';
    END IF;
END$$

CREATE TRIGGER trg_check_orders_before_update
BEFORE UPDATE ON `orders`
FOR EACH ROW
BEGIN
    DECLARE w_role ENUM('cook','dealer');

    IF NEW.client_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A client must be assigned to the order.';
    END IF;

    IF NEW.employee_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee must be assigned to the order.';
    END IF;

    IF NEW.client_id = NEW.employee_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee and client cannot be the same person.';
    END IF;

    SELECT rol INTO w_role
    FROM worker
    WHERE personal_data_id = NEW.employee_id
    LIMIT 1;

    IF NEW.delivery = 1 AND w_role <> 'dealer' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Only dealers can be assigned to a delivery order.';
    END IF;
END$$

DELIMITER ;
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

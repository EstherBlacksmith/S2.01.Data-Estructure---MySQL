-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cul_d_ampolla` ;

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_d_ampolla` DEFAULT CHARACTER SET utf8mb4 ;
USE `cul_d_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`person` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `surname` VARCHAR(80) NOT NULL,
  `telephone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NULL,
  `employee` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `phone_number` (`telephone_number` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`addresses` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`addresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(120) NOT NULL,
  `num` INT NULL DEFAULT NULL,
  `flat` INT NULL DEFAULT NULL,
  `door` INT NULL DEFAULT NULL,
  `stair` VARCHAR(12) NULL DEFAULT NULL,
  `city` VARCHAR(80) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`id`, `person_id`),
  INDEX `fk_addresses_person1_idx` (`person_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_addresses_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `cul_d_ampolla`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`supplier` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nif` VARCHAR(10) NOT NULL,
  `fax` VARCHAR(15) NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`id`, `person_id`),
  UNIQUE INDEX (`nif` ASC) VISIBLE,
  INDEX `fk_supplier_person1_idx` (`person_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `cul_d_ampolla`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`brand` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(45) NOT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`id`, `supplier_id`),
  INDEX `fk_brand_supplier_idx` (`supplier_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_brand_supplier`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `cul_d_ampolla`.`supplier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`glasses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`glasses` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frame_material` ENUM('metal', 'acrylic', 'acetate') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `left_graduation` DECIMAL(4,2) NULL DEFAULT NULL,
  `right_graduation` DECIMAL(4,2) NULL DEFAULT NULL,
  `left_color` VARCHAR(45) NOT NULL DEFAULT 'Transparent',
  `right_color` VARCHAR(45) NOT NULL,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`id`, `brand_id`),
  INDEX `fk_glasses_brand1_idx` (`brand_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_brand1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `cul_d_ampolla`.`brand` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`customer` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`customer` (
  `registration_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `referral_id` INT NULL DEFAULT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`person_id`),
  INDEX `fk_customer_person1_idx` (`person_id` ASC) VISIBLE,
  UNIQUE INDEX `person_id_UNIQUE` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `cul_d_ampolla`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`sales` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `price` DECIMAL(10,2) NOT NULL,
  `customer_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sales_customer` (`customer_id` ASC) ,
  INDEX `fk_sales_employee` (`employee_id` ASC) ,
  INDEX `fk_sales_glasses` (`glasses_id` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_customer1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `cul_d_ampolla`.`customer` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,    
  CONSTRAINT `fk_sales_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `cul_d_ampolla`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,     
  CONSTRAINT `fk_sales_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `cul_d_ampolla`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

DELIMITER $$

CREATE TRIGGER sales_check_before_create
BEFORE UPDATE ON sales
FOR EACH ROW
BEGIN
    DECLARE emp_type TINYINT;
    DECLARE cust_type TINYINT;

    SELECT employee INTO emp_type
    FROM person
    WHERE id = NEW.employee_id;
    
    IF emp_type != 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: employee_id must be an employee (employee=1)';
    END IF;

    SELECT employee INTO cust_type
    FROM person
    WHERE id = NEW.customer_id;
    
    IF cust_type != 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: customer_id can''t be an employee (employee=0)';
    END IF;

    IF NEW.employee_id = NEW.customer_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: employee y customer no pueden ser la misma persona';
    END IF;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

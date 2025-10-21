-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cul_d_ampolla` ;

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_d_ampolla` DEFAULT CHARACTER SET utf8 ;
USE `cul_d_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`adresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`adresses` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`adresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(120) NOT NULL,
  `num` INT NULL,
  `flat` INT NULL,
  `door` INT NULL,
  `stair` VARCHAR(12) NULL,
  `city` VARCHAR(80) NOT NULL,
  `postal_code` VARCHAR(5) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`contact_data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`contact_data` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`contact_data` (
  `telephone` VARCHAR(10) NOT NULL,
  `email` VARCHAR(45) NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `adresses_id` INT NOT NULL,
  PRIMARY KEY (`id`, `adresses_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_contact_data_adresses1_idx` (`adresses_id` ASC) VISIBLE,
  CONSTRAINT `fk_contact_data_adresses1`
    FOREIGN KEY (`adresses_id`)
    REFERENCES `cul_d_ampolla`.`adresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`glasses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`glasses` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `frame_material` ENUM('metal', 'acrylic', 'acetate') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `left_graduation` DECIMAL(2) NULL,
  `rigth_graduation` DECIMAL(2) NULL,
  `left_color` VARCHAR(45) NOT NULL DEFAULT 'Transparentt',
  `rigth_color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`sales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`sales` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`sales` (
  `costumer_id` INT NOT NULL,
  `costumer_costumer_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  `price` DECIMAL(2) NULL,
  PRIMARY KEY (`costumer_id`, `costumer_costumer_id`, `glasses_id`),
  INDEX `fk_costumer_has_glasses_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_costumer_has_glasses_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `cul_d_ampolla`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`employee` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`employee` (
  `sales_costumer_id` INT NOT NULL,
  `sales_costumer_costumer_id` INT NOT NULL,
  `sales_glasses_id` INT NOT NULL,
  PRIMARY KEY (`sales_costumer_id`, `sales_costumer_costumer_id`, `sales_glasses_id`),
  INDEX `fk_employee_sales1_idx` (`sales_costumer_id` ASC, `sales_costumer_costumer_id` ASC, `sales_glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_sales1`
    FOREIGN KEY (`sales_costumer_id` , `sales_costumer_costumer_id` , `sales_glasses_id`)
    REFERENCES `cul_d_ampolla`.`sales` (`costumer_id` , `costumer_costumer_id` , `glasses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`costumer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`costumer` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`costumer` (
  `email` VARCHAR(45) NOT NULL,
  `registration_data` DATE NOT NULL,
  `referral_id` INT NULL,
  `sales_costumer_id` INT NOT NULL,
  `sales_costumer_costumer_id` INT NOT NULL,
  `sales_glasses_id` INT NOT NULL,
  UNIQUE INDEX `referral_id_UNIQUE` (`referral_id` ASC) VISIBLE,
  PRIMARY KEY (`email`, `sales_costumer_id`, `sales_costumer_costumer_id`, `sales_glasses_id`),
  INDEX `fk_costumer_sales1_idx` (`sales_costumer_id` ASC, `sales_costumer_costumer_id` ASC, `sales_glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_costumer_sales1`
    FOREIGN KEY (`sales_costumer_id` , `sales_costumer_costumer_id` , `sales_glasses_id`)
    REFERENCES `cul_d_ampolla`.`sales` (`costumer_id` , `costumer_costumer_id` , `glasses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`brand` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(45) NOT NULL,
  `glasses_id` INT NOT NULL,
  PRIMARY KEY (`id`, `glasses_id`),
  INDEX `fk_brand_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_brand_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `cul_d_ampolla`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`suplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`suplier` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`suplier` (
  `nif` VARCHAR(10) NOT NULL,
  `fax` VARCHAR(10) NULL,
  `brand_id` INT NOT NULL,
  `brand_glasses_id` INT NOT NULL,
  PRIMARY KEY (`nif`, `brand_id`, `brand_glasses_id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_suplier_brand1_idx` (`brand_id` ASC, `brand_glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_suplier_brand1`
    FOREIGN KEY (`brand_id` , `brand_glasses_id`)
    REFERENCES `cul_d_ampolla`.`brand` (`id` , `glasses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`person` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `contact_data_id` INT NOT NULL,
  `contact_data_adresses_id` INT NOT NULL,
  `employee_sales_costumer_id` INT NOT NULL,
  `employee_sales_costumer_costumer_id` INT NOT NULL,
  `employee_sales_glasses_id` INT NOT NULL,
  `costumer_employee_sales_costumer_id` INT NOT NULL,
  `costumer_employee_sales_costumer_costumer_id` INT NOT NULL,
  `costumer_employee_sales_glasses_id` INT NOT NULL,
  `costumer_email` VARCHAR(45) NOT NULL,
  `suplier_nif` VARCHAR(10) NOT NULL,
  `suplier_brand_id` INT NOT NULL,
  `suplier_brand_glasses_id` INT NOT NULL,
  PRIMARY KEY (`id`, `contact_data_id`, `contact_data_adresses_id`, `employee_sales_costumer_id`, `employee_sales_costumer_costumer_id`, `employee_sales_glasses_id`, `costumer_employee_sales_costumer_id`, `costumer_employee_sales_costumer_costumer_id`, `costumer_employee_sales_glasses_id`, `costumer_email`, `suplier_nif`, `suplier_brand_id`, `suplier_brand_glasses_id`),
  INDEX `fk_person_contact_data1_idx` (`contact_data_id` ASC, `contact_data_adresses_id` ASC) VISIBLE,
  INDEX `fk_person_employee1_idx` (`employee_sales_costumer_id` ASC, `employee_sales_costumer_costumer_id` ASC, `employee_sales_glasses_id` ASC) VISIBLE,
  INDEX `fk_person_costumer1_idx` (`costumer_employee_sales_costumer_id` ASC, `costumer_employee_sales_costumer_costumer_id` ASC, `costumer_employee_sales_glasses_id` ASC, `costumer_email` ASC) VISIBLE,
  INDEX `fk_person_suplier1_idx` (`suplier_nif` ASC, `suplier_brand_id` ASC, `suplier_brand_glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_person_contact_data1`
    FOREIGN KEY (`contact_data_id` , `contact_data_adresses_id`)
    REFERENCES `cul_d_ampolla`.`contact_data` (`id` , `adresses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_employee1`
    FOREIGN KEY (`employee_sales_costumer_id` , `employee_sales_costumer_costumer_id` , `employee_sales_glasses_id`)
    REFERENCES `cul_d_ampolla`.`employee` (`sales_costumer_id` , `sales_costumer_costumer_id` , `sales_glasses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_costumer1`
    FOREIGN KEY (`costumer_email`)
    REFERENCES `cul_d_ampolla`.`costumer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_suplier1`
    FOREIGN KEY (`suplier_nif` , `suplier_brand_id` , `suplier_brand_glasses_id`)
    REFERENCES `cul_d_ampolla`.`suplier` (`nif` , `brand_id` , `brand_glasses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

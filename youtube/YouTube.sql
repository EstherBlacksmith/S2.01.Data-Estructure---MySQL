-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `YouTube` ;

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8 ;
USE `YouTube` ;

-- -----------------------------------------------------
-- Table `YouTube`.`password`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`password` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`password` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`user` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `password_idpassword` INT NOT NULL,
  `gender` ENUM("woman", "man", "non-binary", "other/non-declared") NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `birth_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_password_idx` (`password_idpassword` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_user_password`
    FOREIGN KEY (`password_idpassword`)
    REFERENCES `YouTube`.`password` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`video` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  `video_file_name` VARCHAR(45) NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `duration` BIGINT NOT NULL,
  `state` ENUM("public", "private", "hidden") NOT NULL DEFAULT 'public',
  `publication_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `video_file_name_UNIQUE` (`video_file_name` ASC) ,
  INDEX `fk_video_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_video_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`reproductions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`reproductions` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`reproductions` (
  `video_id` INT NOT NULL,
  `reproductions` BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`video_id`),
  UNIQUE INDEX `video_id_UNIQUE` (`video_id` ASC) ,
  CONSTRAINT `fk_likes_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`labels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`labels` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`labels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`id`, `video_id`),
  INDEX `fk_labels_video1_idx` (`video_id` ASC) ,
  UNIQUE INDEX `video_id_UNIQUE` (`video_id` ASC) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  CONSTRAINT `fk_labels_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`channel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`channel` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`channel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  `creation` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_channel_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_channel_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`subscriptors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`subscriptors` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`subscriptors` (
  `video_id` INT NOT NULL,
  `user_id_subscriber` INT NOT NULL,
  PRIMARY KEY (`video_id`, `user_id_subscriber`),
  INDEX `fk_subscriptors_user1_idx` (`user_id_subscriber` ASC) ,
  UNIQUE INDEX `video_id_UNIQUE` (`video_id` ASC) ,
  CONSTRAINT `fk_subscriptors_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptors_user1`
    FOREIGN KEY (`user_id_subscriber`)
    REFERENCES `YouTube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`video_interactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`video_interactions` ;

CREATE TABLE IF NOT EXISTS `video_interactions` (
  `video_id` INT NOT NULL,
  `user_id_interact` INT NOT NULL,
  `like` TINYINT NOT NULL,
  `interaction_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`video_id`, `user_id_interact`),   -- ✅ asegura unicidad por video + usuario
  INDEX `fk_interactions_user1_idx` (`user_id_interact` ASC),
  CONSTRAINT `fk_interactions_video1`
    FOREIGN KEY (`video_id`) REFERENCES `video` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_interactions_user1`
    FOREIGN KEY (`user_id_interact`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`playlist` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `creation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `status` ENUM("public", "private") NOT NULL DEFAULT 'public',
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `fk_playlist_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`comments` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(500) NOT NULL,
  `comment_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `video_id` INT NOT NULL,
  `user_id_coments` INT NOT NULL,
  PRIMARY KEY (`id`, `video_id`),
  INDEX `fk_comments_video1_idx` (`video_id` ASC) ,
  INDEX `fk_comments_user1_idx` (`user_id_coments` ASC) ,
  CONSTRAINT `fk_comments_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_user1`
    FOREIGN KEY (`user_id_coments`)
    REFERENCES `YouTube`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`comments_interactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`comments_interactions` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`comments_interactions` (
  `like` TINYINT NOT NULL,
  `interaction_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `comments_id` INT NOT NULL,
  `user_id_interact` INT NOT NULL,
  PRIMARY KEY (`comments_id`, `user_id_interact`),  -- ✅ asegura unicidad por comentario + usuario
  INDEX `fk_comments_interactions_user1_idx` (`user_id_interact` ASC),
  CONSTRAINT `fk_comments_interactions_user1`
    FOREIGN KEY (`user_id_interact`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_comments_fk`
    FOREIGN KEY (`comments_id`) REFERENCES `comments` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `YouTube`.`playlist_videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `YouTube`.`playlist_videos` ;

CREATE TABLE IF NOT EXISTS `YouTube`.`playlist_videos` (
  `playlist_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `video_id`),
  INDEX `fk_playlist_videos_video1_idx` (`video_id` ASC) ,
  CONSTRAINT `fk_playlist_videos_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `YouTube`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_videos_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTube`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

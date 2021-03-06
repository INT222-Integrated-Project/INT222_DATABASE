-- MySQL Script generated by MySQL Workbench
-- Tue Nov  9 17:47:31 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sweetsweeties
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sweetsweeties` ;

-- -----------------------------------------------------
-- Schema sweetsweeties
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sweetsweeties` DEFAULT CHARACTER SET utf8 ;
USE `sweetsweeties` ;

-- -----------------------------------------------------
-- Table `sweetsweeties`.`orderStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`orderStatus` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`orderStatus` (
  `statusID` INT(2) NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`statusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`roles` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`roles` (
  `roleID` INT(2) NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`roleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`username`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`username` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`username` (
  `userNameID` INT(10) NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(20) NOT NULL,
  `userPassword` VARCHAR(64) NOT NULL,
  `roleID` INT(2) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NULL,
  `phoneNumber` VARCHAR(12) NOT NULL,
  `cusImage` VARCHAR(60) NULL,
  `address` VARCHAR(400) NULL,
  PRIMARY KEY (`userNameID`),
  INDEX `fk_persons_roles1_idx` (`roleID` ASC) VISIBLE,
  CONSTRAINT `fk_persons_roles1`
    FOREIGN KEY (`roleID`)
    REFERENCES `sweetsweeties`.`roles` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`orders` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`orders` (
  `orderID` INT(10) NOT NULL AUTO_INCREMENT,
  `dateTime` TIMESTAMP NOT NULL,
  `amount` FLOAT(12,2) NULL,
  `paymentDate` TIMESTAMP NULL,
  `statusID` INT(2) NOT NULL,
  `userNameID` INT(10) NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `fk_orders_status1_idx` (`statusID` ASC) VISIBLE,
  INDEX `fk_orders_username1_idx` (`userNameID` ASC) VISIBLE,
  CONSTRAINT `fk_orders_status1`
    FOREIGN KEY (`statusID`)
    REFERENCES `sweetsweeties`.`orderStatus` (`statusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_username1`
    FOREIGN KEY (`userNameID`)
    REFERENCES `sweetsweeties`.`username` (`userNameID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`products` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`products` (
  `caseID` INT(6) NOT NULL AUTO_INCREMENT,
  `caseName` VARCHAR(100) NOT NULL,
  `caseDescription` VARCHAR(500) NULL,
  `casePrice` FLOAT(8,2) NOT NULL,
  `caseDate` DATE NOT NULL,
  `productImage` VARCHAR(60) NOT NULL,
  `userNameID` INT(10) NOT NULL,
  `isOnStore` TINYINT(1) NOT NULL,
  PRIMARY KEY (`caseID`),
  INDEX `fk_products_username1_idx` (`userNameID` ASC) VISIBLE,
  CONSTRAINT `fk_products_username1`
    FOREIGN KEY (`userNameID`)
    REFERENCES `sweetsweeties`.`username` (`userNameID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`brands`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`brands` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`brands` (
  `codeBrand` INT(2) NOT NULL AUTO_INCREMENT,
  `caseBrand` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codeBrand`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`colors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`colors` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`colors` (
  `codeColor` INT(3) NOT NULL AUTO_INCREMENT,
  `caseColor` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`codeColor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`productcolor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`productcolor` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`productcolor` (
  `imageCase` VARCHAR(60) NULL,
  `codeColor` INT(3) NOT NULL,
  `quantity` INT(5) NOT NULL,
  `productcolorID` INT(12) NOT NULL AUTO_INCREMENT,
  `caseID` INT(6) NOT NULL,
  INDEX `fk_productscolor_colors1_idx` (`codeColor` ASC) VISIBLE,
  PRIMARY KEY (`productcolorID`),
  INDEX `fk_productscolor_products1_idx` (`caseID` ASC) VISIBLE,
  CONSTRAINT `fk_productscolor_colors1`
    FOREIGN KEY (`codeColor`)
    REFERENCES `sweetsweeties`.`colors` (`codeColor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productscolor_products1`
    FOREIGN KEY (`caseID`)
    REFERENCES `sweetsweeties`.`products` (`caseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`orderdetail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`orderdetail` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`orderdetail` (
  `quantityOrder` INT(4) NOT NULL,
  `unitPrice` FLOAT(12,2) NOT NULL,
  `orderID` INT(10) NOT NULL,
  `orderdetailID` INT(12) NOT NULL AUTO_INCREMENT,
  `productcolorID` INT(12) NOT NULL,
  INDEX `fk_orderdetail_orders1_idx` (`orderID` ASC) VISIBLE,
  PRIMARY KEY (`orderdetailID`),
  INDEX `fk_orderdetail_productscolor1_idx` (`productcolorID` ASC) VISIBLE,
  CONSTRAINT `fk_orderdetail_orders1`
    FOREIGN KEY (`orderID`)
    REFERENCES `sweetsweeties`.`orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderdetail_productscolor1`
    FOREIGN KEY (`productcolorID`)
    REFERENCES `sweetsweeties`.`productcolor` (`productcolorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`models`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`models` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`models` (
  `modelID` INT(4) NOT NULL AUTO_INCREMENT,
  `modelName` VARCHAR(100) NOT NULL,
  `codeBrand` INT(2) NOT NULL,
  PRIMARY KEY (`modelID`),
  INDEX `fk_models_brands1_idx` (`codeBrand` ASC) VISIBLE,
  CONSTRAINT `fk_models_brands1`
    FOREIGN KEY (`codeBrand`)
    REFERENCES `sweetsweeties`.`brands` (`codeBrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`productmodel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`productmodel` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`productmodel` (
  `modelID` INT(4) NOT NULL,
  `caseID` INT(6) NOT NULL,
  INDEX `fk_models_has_products_products1_idx` (`caseID` ASC) VISIBLE,
  INDEX `fk_models_has_products_models1_idx` (`modelID` ASC) VISIBLE,
  CONSTRAINT `fk_models_has_products_models1`
    FOREIGN KEY (`modelID`)
    REFERENCES `sweetsweeties`.`models` (`modelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_models_has_products_products1`
    FOREIGN KEY (`caseID`)
    REFERENCES `sweetsweeties`.`products` (`caseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sweetsweeties`.`tokenBlackList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sweetsweeties`.`tokenBlackList` ;

CREATE TABLE IF NOT EXISTS `sweetsweeties`.`tokenBlackList` (
  `token` VARCHAR(170) NOT NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

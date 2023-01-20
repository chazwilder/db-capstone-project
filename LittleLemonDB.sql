-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`EmployeeRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`EmployeeRoles` (
  `idEmployeeRoles` INT NOT NULL AUTO_INCREMENT,
  `RoleName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idEmployeeRoles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(200) NOT NULL,
  `LastName` VARCHAR(200) NOT NULL,
  `RoleId` INT NOT NULL,
  `City` VARCHAR(200) NOT NULL,
  `State` VARCHAR(200) NOT NULL,
  `Country` VARCHAR(200) NOT NULL,
  `Street` VARCHAR(200) NOT NULL,
  `PostalCode` INT NOT NULL,
  `ContactNumber` INT(10) NOT NULL,
  `EmailAddress` VARCHAR(200) NOT NULL,
  `Annual_Salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idEmployee`),
  INDEX `EmployeeRoles_idx` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `EmployeeRoles`
    FOREIGN KEY (`RoleId`)
    REFERENCES `LittleLemonDB`.`EmployeeRoles` (`idEmployeeRoles`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(200) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `ContactNumber` INT(10) NOT NULL,
  `EmailAddress` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `PhoneNumber_UNIQUE` (`ContactNumber` ASC) VISIBLE)
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`BookingType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`BookingType` (
  `idBookingType` INT NOT NULL AUTO_INCREMENT,
  `BookingTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBookingType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `idBookings` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATETIME NOT NULL,
  `TableNumber` INT NOT NULL,
  `NumberOfGuests` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `EmployeeID` INT NULL,
  `BookingType` INT NOT NULL,
  PRIMARY KEY (`idBookings`),
  INDEX `StaffRef_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `CustomerRef_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `BookingTypeRef_idx` (`BookingType` ASC) VISIBLE,
  CONSTRAINT `StaffRef`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employee` (`idEmployee`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CustomerRef`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BookingTypeRef`
    FOREIGN KEY (`BookingType`)
    REFERENCES `LittleLemonDB`.`BookingType` (`idBookingType`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderStatus` (
  `idOrderStatus` INT NOT NULL AUTO_INCREMENT,
  `OrderStatusName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idOrderStatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `idOrders` INT NOT NULL AUTO_INCREMENT,
  `BookingID` INT NOT NULL,
  `BillAmount` DECIMAL(5,2) NOT NULL,
  `CustpmerId` INT NOT NULL,
  `OrderStatusId` INT NOT NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `OrderStatus_idx` (`OrderStatusId` ASC) VISIBLE,
  INDEX `Customer_idx` (`CustpmerId` ASC) VISIBLE,
  INDEX `BookingRef_idx` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `OrderStatus`
    FOREIGN KEY (`OrderStatusId`)
    REFERENCES `LittleLemonDB`.`OrderStatus` (`idOrderStatus`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Customer`
    FOREIGN KEY (`CustpmerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BookingRef`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`idBookings`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuCategory` (
  `idMenuCategory` INT NOT NULL AUTO_INCREMENT,
  `MenuCategoryName` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idMenuCategory`),
  UNIQUE INDEX `idMenuCategory_UNIQUE` (`idMenuCategory` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `idMenuItems` INT NOT NULL AUTO_INCREMENT,
  `ItemName` VARCHAR(200) NOT NULL,
  `ItemType` INT NOT NULL,
  `Price` DECIMAL(5) NOT NULL,
  PRIMARY KEY (`idMenuItems`),
  INDEX `ItemCategory_idx` (`ItemType` ASC) VISIBLE,
  CONSTRAINT `ItemCategory`
    FOREIGN KEY (`ItemType`)
    REFERENCES `LittleLemonDB`.`MenuCategory` (`idMenuCategory`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDetails` (
  `idOrderDetails` INT NOT NULL AUTO_INCREMENT,
  `OrderId` INT NOT NULL,
  `MenuItemId` INT NOT NULL,
  `ItemQuantity` INT NOT NULL,
  `DiscountAmonut` DECIMAL(5,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idOrderDetails`),
  INDEX `OrderRef_idx` (`OrderId` ASC) VISIBLE,
  INDEX `MenuItemsRef_idx` (`MenuItemId` ASC) VISIBLE,
  CONSTRAINT `OrderRef`
    FOREIGN KEY (`OrderId`)
    REFERENCES `LittleLemonDB`.`Orders` (`idOrders`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MenuItemsRef`
    FOREIGN KEY (`MenuItemId`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`idMenuItems`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryAddress` (
  `idDeliveryAddress` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(200) NOT NULL,
  `City` VARCHAR(200) NOT NULL,
  `State` VARCHAR(200) NOT NULL,
  `Country` VARCHAR(200) NOT NULL,
  `PostalCode` INT NULL,
  PRIMARY KEY (`idDeliveryAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryStatusCodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryStatusCodes` (
  `idDeliveryStatusCodes` INT NOT NULL AUTO_INCREMENT,
  `StatusCodeName` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idDeliveryStatusCodes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDelivery` (
  `idOrderDelivery` INT NOT NULL AUTO_INCREMENT,
  `OrderId` INT NOT NULL,
  `DeliveryStatusId` INT NOT NULL,
  `OrderDeliveryFee` DECIMAL(5,2) NOT NULL,
  `DeliveryAddressId` INT NULL,
  `BookingType` INT NOT NULL,
  `DriverAssignment` INT NULL,
  PRIMARY KEY (`idOrderDelivery`),
  INDEX `DeliveryAddressRef_idx` (`DeliveryAddressId` ASC) VISIBLE,
  INDEX `OrderRef_idx` (`OrderId` ASC) VISIBLE,
  INDEX `BookingTypeRef_idx` (`BookingType` ASC) VISIBLE,
  INDEX `DeliveryStatus_idx` (`DeliveryStatusId` ASC) VISIBLE,
  INDEX `DriverRef_idx` (`DriverAssignment` ASC) VISIBLE,
  CONSTRAINT `DeliveryAddressRef`
    FOREIGN KEY (`DeliveryAddressId`)
    REFERENCES `LittleLemonDB`.`DeliveryAddress` (`idDeliveryAddress`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `OrderRefId`
    FOREIGN KEY (`OrderId`)
    REFERENCES `LittleLemonDB`.`Orders` (`idOrders`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `BookingTypeRefId`
    FOREIGN KEY (`BookingType`)
    REFERENCES `LittleLemonDB`.`Bookings` (`idBookings`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `DeliveryStatus`
    FOREIGN KEY (`DeliveryStatusId`)
    REFERENCES `LittleLemonDB`.`DeliveryStatusCodes` (`idDeliveryStatusCodes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `DriverRef`
    FOREIGN KEY (`DriverAssignment`)
    REFERENCES `LittleLemonDB`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

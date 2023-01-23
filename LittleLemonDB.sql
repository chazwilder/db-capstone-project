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
    ON UPDATE NO ACTION)
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
  PRIMARY KEY (`CustomerID`))
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
  `NumberOfGuests` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `EmployeeID` INT NULL,
  `BookingType` INT NOT NULL,
  PRIMARY KEY (`idBookings`),
  INDEX `StaffRef_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `BookingTypeRef_idx` (`BookingType` ASC) VISIBLE,
  INDEX `CustomerIDRef_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `StaffRef`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CustomerIDRef`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BookingTypeRef`
    FOREIGN KEY (`BookingType`)
    REFERENCES `LittleLemonDB`.`BookingType` (`idBookingType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `CustomerId` INT NOT NULL,
  `OrderStatusId` INT NOT NULL,
  `TableNumber` INT NOT NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `OrderStatus_idx` (`OrderStatusId` ASC) VISIBLE,
  INDEX `BookingRef_idx` (`BookingID` ASC) VISIBLE,
  INDEX `Customer_idx` (`CustomerId` ASC) VISIBLE,
  CONSTRAINT `OrderStatus`
    FOREIGN KEY (`OrderStatusId`)
    REFERENCES `LittleLemonDB`.`OrderStatus` (`idOrderStatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BookingRef`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`idBookings`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
    ON UPDATE NO ACTION)
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuItemsRef`
    FOREIGN KEY (`MenuItemId`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`idMenuItems`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OrderRefId`
    FOREIGN KEY (`OrderId`)
    REFERENCES `LittleLemonDB`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BookingTypeRefId`
    FOREIGN KEY (`BookingType`)
    REFERENCES `LittleLemonDB`.`Bookings` (`idBookings`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DeliveryStatus`
    FOREIGN KEY (`DeliveryStatusId`)
    REFERENCES `LittleLemonDB`.`DeliveryStatusCodes` (`idDeliveryStatusCodes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DriverRef`
    FOREIGN KEY (`DriverAssignment`)
    REFERENCES `LittleLemonDB`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`CuisineType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`CuisineType` (
  `idCuisineType` INT NOT NULL,
  `CuisineName` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idCuisineType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `idMenu` INT NOT NULL,
  `MenuGroupId` INT NOT NULL,
  `idMenuItems` INT NOT NULL,
  `Cuisine` INT NOT NULL,
  PRIMARY KEY (`idMenu`),
  INDEX `MenuItems_Menu_idx` (`idMenuItems` ASC) VISIBLE,
  INDEX `Cuisine_idx` (`Cuisine` ASC) VISIBLE,
  CONSTRAINT `MenuItems_Menu`
    FOREIGN KEY (`idMenuItems`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`idMenuItems`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cuisine`
    FOREIGN KEY (`Cuisine`)
    REFERENCES `LittleLemonDB`.`CuisineType` (`idCuisineType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`EmployeeRoles`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`EmployeeRoles` (`idEmployeeRoles`, `RoleName`) VALUES (1, 'Manager');
INSERT INTO `LittleLemonDB`.`EmployeeRoles` (`idEmployeeRoles`, `RoleName`) VALUES (2, 'Assistant Manager');
INSERT INTO `LittleLemonDB`.`EmployeeRoles` (`idEmployeeRoles`, `RoleName`) VALUES (3, 'Head Chef');
INSERT INTO `LittleLemonDB`.`EmployeeRoles` (`idEmployeeRoles`, `RoleName`) VALUES (4, 'Assistant Chef');
INSERT INTO `LittleLemonDB`.`EmployeeRoles` (`idEmployeeRoles`, `RoleName`) VALUES (5, 'Head Waiter');
INSERT INTO `LittleLemonDB`.`EmployeeRoles` (`idEmployeeRoles`, `RoleName`) VALUES (6, 'Receptionist');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Employee` (`idEmployee`, `FirstName`, `LastName`, `RoleId`, `City`, `State`, `Country`, `Street`, `PostalCode`, `ContactNumber`, `EmailAddress`, `Annual_Salary`) VALUES (1, 'Mario', 'Gollini', 1, 'Chicago', 'IL', 'United States Of America', '724 Parsley Lane', 62711, 351258074, 'Mario.g@littlelemon.com', 70000.00);
INSERT INTO `LittleLemonDB`.`Employee` (`idEmployee`, `FirstName`, `LastName`, `RoleId`, `City`, `State`, `Country`, `Street`, `PostalCode`, `ContactNumber`, `EmailAddress`, `Annual_Salary`) VALUES (2, 'Adrian', 'Gollini', 2, 'Chicago', 'IL', 'United States Of America', '334 Dill Square', 62711, 351474048, 'Adrian.g@littlelemon.com', 65000.00);
INSERT INTO `LittleLemonDB`.`Employee` (`idEmployee`, `FirstName`, `LastName`, `RoleId`, `City`, `State`, `Country`, `Street`, `PostalCode`, `ContactNumber`, `EmailAddress`, `Annual_Salary`) VALUES (3, 'Giorgos', 'Dioudis', 3, 'Chicago', 'IL', 'United States Of America', '879 Sage Street', 62711, 351970582, 'Giorgos.d@littlelemon.com', 50000.00);
INSERT INTO `LittleLemonDB`.`Employee` (`idEmployee`, `FirstName`, `LastName`, `RoleId`, `City`, `State`, `Country`, `Street`, `PostalCode`, `ContactNumber`, `EmailAddress`, `Annual_Salary`) VALUES (4, 'Fatma', 'Kaya', 4, 'Chicago', 'IL', 'United States Of America', '132  Bay Lane', 62711, 351963569, 'Fatma.k@littlelemon.com', 45000.00);
INSERT INTO `LittleLemonDB`.`Employee` (`idEmployee`, `FirstName`, `LastName`, `RoleId`, `City`, `State`, `Country`, `Street`, `PostalCode`, `ContactNumber`, `EmailAddress`, `Annual_Salary`) VALUES (5, 'Elena', 'Salvai', 5, 'Chicago', 'IL', 'United States Of America', '989 Thyme Square', 62711, 351074198, 'Elena.s@littlelemon.com', 40000.00);
INSERT INTO `LittleLemonDB`.`Employee` (`idEmployee`, `FirstName`, `LastName`, `RoleId`, `City`, `State`, `Country`, `Street`, `PostalCode`, `ContactNumber`, `EmailAddress`, `Annual_Salary`) VALUES (6, 'John', 'Millar', 6, 'Chicago', 'IL', 'United States Of America', '245 Dill Square', 62711, 351584508, 'John.m@littlelemon.com', 35000.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `ContactNumber`, `EmailAddress`) VALUES (1, 'Anna', 'Iversen', 999999999, 'Anna.I@gmail.com');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `ContactNumber`, `EmailAddress`) VALUES (2, 'Joakim', 'Iversen', 989999999, 'Joakim.I@gmail.com');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `ContactNumber`, `EmailAddress`) VALUES (3, 'Vanessa', 'McCarthy', 979999999, 'Vanessa.M@gmail.com');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `ContactNumber`, `EmailAddress`) VALUES (4, 'Marcos', 'Romero', 969999999, 'Marcos.R@gmail.com');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `ContactNumber`, `EmailAddress`) VALUES (5, 'Hiroki', 'Yamane', 959999999, 'Hiroki.Y@gmail.com');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `ContactNumber`, `EmailAddress`) VALUES (6, 'Diana', 'Pinto', 949999999, 'Diana.P@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`BookingType`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`BookingType` (`idBookingType`, `BookingTypeName`) VALUES (1, 'Walk-in');
INSERT INTO `LittleLemonDB`.`BookingType` (`idBookingType`, `BookingTypeName`) VALUES (2, 'Reservation');
INSERT INTO `LittleLemonDB`.`BookingType` (`idBookingType`, `BookingTypeName`) VALUES (3, 'Delivery');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Bookings` (`idBookings`, `BookingDate`, `NumberOfGuests`, `CustomerID`, `EmployeeID`, `BookingType`) VALUES (1, '2023-01-19 15:00', 2, 1, 1, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`idBookings`, `BookingDate`, `NumberOfGuests`, `CustomerID`, `EmployeeID`, `BookingType`) VALUES (2, '2023-01-19 12:00', 1, 2, 1, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`idBookings`, `BookingDate`, `NumberOfGuests`, `CustomerID`, `EmployeeID`, `BookingType`) VALUES (3, '2023-01-19 19:00', 1, 3, 3, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`idBookings`, `BookingDate`, `NumberOfGuests`, `CustomerID`, `EmployeeID`, `BookingType`) VALUES (4, '2023-01-19 15:00', 1, 4, 4, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`idBookings`, `BookingDate`, `NumberOfGuests`, `CustomerID`, `EmployeeID`, `BookingType`) VALUES (5, '2023-01-19 05:00', 1, 5, 2, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`idBookings`, `BookingDate`, `NumberOfGuests`, `CustomerID`, `EmployeeID`, `BookingType`) VALUES (6, '2023-01-19 08:0', 1, 6, 5, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`OrderStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`OrderStatus` (`idOrderStatus`, `OrderStatusName`) VALUES (1, 'New Order');
INSERT INTO `LittleLemonDB`.`OrderStatus` (`idOrderStatus`, `OrderStatusName`) VALUES (2, 'In Progress');
INSERT INTO `LittleLemonDB`.`OrderStatus` (`idOrderStatus`, `OrderStatusName`) VALUES (3, 'Order Complete');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Orders` (`idOrders`, `BookingID`, `BillAmount`, `CustomerId`, `OrderStatusId`, `TableNumber`) VALUES (1, 1, 86, 1, 3, 12);
INSERT INTO `LittleLemonDB`.`Orders` (`idOrders`, `BookingID`, `BillAmount`, `CustomerId`, `OrderStatusId`, `TableNumber`) VALUES (2, 2, 37, 2, 3, 19);
INSERT INTO `LittleLemonDB`.`Orders` (`idOrders`, `BookingID`, `BillAmount`, `CustomerId`, `OrderStatusId`, `TableNumber`) VALUES (3, 3, 37, 3, 3, 15);
INSERT INTO `LittleLemonDB`.`Orders` (`idOrders`, `BookingID`, `BillAmount`, `CustomerId`, `OrderStatusId`, `TableNumber`) VALUES (4, 4, 40, 4, 3, 5);
INSERT INTO `LittleLemonDB`.`Orders` (`idOrders`, `BookingID`, `BillAmount`, `CustomerId`, `OrderStatusId`, `TableNumber`) VALUES (5, 5, 43, 5, 3, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`MenuCategory`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`MenuCategory` (`idMenuCategory`, `MenuCategoryName`) VALUES (1, 'Starters');
INSERT INTO `LittleLemonDB`.`MenuCategory` (`idMenuCategory`, `MenuCategoryName`) VALUES (2, 'Main Courses');
INSERT INTO `LittleLemonDB`.`MenuCategory` (`idMenuCategory`, `MenuCategoryName`) VALUES (3, 'Desserts');
INSERT INTO `LittleLemonDB`.`MenuCategory` (`idMenuCategory`, `MenuCategoryName`) VALUES (4, 'Drinks');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (1, 'Olives', 1, 5);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (2, 'Flatbread', 1, 5);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (3, 'Minestrone', 1, 8);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (4, 'Tomato bread', 1, 8);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (5, 'Falafel', 1, 7);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (6, 'Hummus', 1, 5);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (7, 'Greek salad', 2, 15);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (8, 'Bean soup', 2, 12);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (9, 'Pizza', 2, 15);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (10, 'Greek yoghurt', 3, 7);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (11, 'Ice cream', 3, 6);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (12, 'Cheesecake', 3, 4);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (13, 'Athens White wine', 4, 25);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (14, 'Corfu Red Wine', 4, 30);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (15, 'Turkish Coffee', 4, 10);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (16, 'Turkish Coffee', 4, 10);
INSERT INTO `LittleLemonDB`.`MenuItems` (`idMenuItems`, `ItemName`, `ItemType`, `Price`) VALUES (17, 'Kabasa', 2, 17);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`OrderDetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`OrderDetails` (`idOrderDetails`, `OrderId`, `MenuItemId`, `ItemQuantity`, `DiscountAmonut`) VALUES (1, 1, 1, 2, 0);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`idOrderDetails`, `OrderId`, `MenuItemId`, `ItemQuantity`, `DiscountAmonut`) VALUES (2, 2, 2, 1, 0);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`idOrderDetails`, `OrderId`, `MenuItemId`, `ItemQuantity`, `DiscountAmonut`) VALUES (3, 4, 2, 1, 0);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`idOrderDetails`, `OrderId`, `MenuItemId`, `ItemQuantity`, `DiscountAmonut`) VALUES (4, 4, 3, 1, 0);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`idOrderDetails`, `OrderId`, `MenuItemId`, `ItemQuantity`, `DiscountAmonut`) VALUES (5, 5, 1, 1, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`DeliveryStatusCodes`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`DeliveryStatusCodes` (`idDeliveryStatusCodes`, `StatusCodeName`) VALUES (1, 'Ready For Pickup');
INSERT INTO `LittleLemonDB`.`DeliveryStatusCodes` (`idDeliveryStatusCodes`, `StatusCodeName`) VALUES (2, 'In Transit');
INSERT INTO `LittleLemonDB`.`DeliveryStatusCodes` (`idDeliveryStatusCodes`, `StatusCodeName`) VALUES (3, 'Delivered');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`CuisineType`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`CuisineType` (`idCuisineType`, `CuisineName`) VALUES (1, 'Greek');
INSERT INTO `LittleLemonDB`.`CuisineType` (`idCuisineType`, `CuisineName`) VALUES (2, 'Italian');
INSERT INTO `LittleLemonDB`.`CuisineType` (`idCuisineType`, `CuisineName`) VALUES (3, 'Turkish');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (1, 1, 1, 1);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (2, 1, 7, 1);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (3, 1, 10, 1);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (4, 1, 13, 1);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (5, 2, 3, 2);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (6, 2, 9, 2);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (7, 2, 12, 2);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (8, 2, 15, 2);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (9, 3, 5, 3);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (10, 3, 17, 3);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (11, 3, 11, 3);
INSERT INTO `LittleLemonDB`.`Menu` (`idMenu`, `MenuGroupId`, `idMenuItems`, `Cuisine`) VALUES (12, 3, 16, 3);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

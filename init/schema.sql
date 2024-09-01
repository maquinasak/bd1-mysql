DROP DATABASE IF EXISTS northwind;
CREATE DATABASE IF NOT EXISTS northwind;
USE northwind;
CREATE TABLE `Categories` (
    `CategoryID` INTEGER NOT NULL AUTO_INCREMENT,
    `CategoryName` VARCHAR(15) NOT NULL,
    `Description` MEDIUMTEXT,
    `Picture` LONGBLOB,
    CONSTRAINT `PK_Categories` PRIMARY KEY (`CategoryID`)
);
CREATE INDEX `CategoryName` ON `Categories` (`CategoryName`);
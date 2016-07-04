SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `airbnb` DEFAULT CHARACTER SET latin1 ;
USE `airbnb` ;

-- -----------------------------------------------------
-- Table `airbnb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`city` (
  `city_code` VARCHAR(10) NOT NULL,
  `city` VARCHAR(60) NULL,
  PRIMARY KEY (`city_code`),
  UNIQUE INDEX `city_code_UNIQUE` (`city_code` ASC),
  UNIQUE INDEX `city_UNIQUE` (`city` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`guest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`guest` (
  `guestId` INT NOT NULL,
  `fname` VARCHAR(60) NULL,
  `lname` VARCHAR(60) NULL,
  `gender` VARCHAR(45) NULL,
  `birthdate` DATE NULL,
  `email` VARCHAR(45) NOT NULL,
  `phonenumber` VARCHAR(45) NULL,
  `address` VARCHAR(60) NULL,
  `creation_date` DATE NULL,
  `channel` VARCHAR(60) NULL,
  `verified` TINYINT(1) NULL,
  `city_city_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`guestId`, `city_city_code`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `phonenumber_UNIQUE` (`phonenumber` ASC),
  INDEX `fk_guest_city1_idx` (`city_city_code` ASC),
  CONSTRAINT `fk_guest_city1`
    FOREIGN KEY (`city_city_code`)
    REFERENCES `airbnb`.`city` (`city_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`host`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`host` (
  `hostid` INT NOT NULL,
  `guestId` INT NOT NULL,
  PRIMARY KEY (`hostid`, `guestId`),
  UNIQUE INDEX `hostid_UNIQUE` (`hostid` ASC),
  INDEX `fk_host_guest_idx` (`guestId` ASC),
  CONSTRAINT `fk_host_guest`
    FOREIGN KEY (`guestId`)
    REFERENCES `airbnb`.`guest` (`guestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`property`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`property` (
  `propertyid` INT NOT NULL,
  `home_type` VARCHAR(45) NULL,
  `room_type` VARCHAR(45) NULL,
  `number_of_guests` INT(11) NULL,
  `rates` VARCHAR(45) NULL,
  `house_rules` VARCHAR(300) NULL,
  `safety_features` VARCHAR(200) NULL,
  `description` VARCHAR(150) NULL,
  `hostid` INT NOT NULL,
  `city_city_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`propertyid`, `hostid`, `city_city_code`),
  INDEX `fk_property_host1_idx` (`hostid` ASC),
  INDEX `fk_property_city1_idx` (`city_city_code` ASC),
  CONSTRAINT `fk_property_host1`
    FOREIGN KEY (`hostid`)
    REFERENCES `airbnb`.`host` (`hostid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_property_city1`
    FOREIGN KEY (`city_city_code`)
    REFERENCES `airbnb`.`city` (`city_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`weblogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`weblogs` (
  `weblogsid` INT NOT NULL,
  `device_details` VARCHAR(45) NULL,
  `login_duration` INT(11) NULL,
  `search` TINYINT(1) NULL,
  `search_query` VARCHAR(100) NULL,
  `pages_viewed` INT(11) NULL,
  `creation_timestamp` DATETIME NULL,
  `guest_guestId` INT NOT NULL,
  PRIMARY KEY (`weblogsid`, `guest_guestId`),
  INDEX `fk_weblogs_guest1_idx` (`guest_guestId` ASC),
  CONSTRAINT `fk_weblogs_guest1`
    FOREIGN KEY (`guest_guestId`)
    REFERENCES `airbnb`.`guest` (`guestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`review` (
  `rieviewid` INT NOT NULL,
  `rating` INT(11) NULL,
  `review` VARCHAR(100) NULL,
  `review_date` VARCHAR(45) NULL,
  `property_propertyid` INT NOT NULL,
  `guest_guestId` INT NOT NULL,
  PRIMARY KEY (`rieviewid`, `property_propertyid`, `guest_guestId`),
  INDEX `fk_review_property1_idx` (`property_propertyid` ASC),
  INDEX `fk_review_guest1_idx` (`guest_guestId` ASC),
  CONSTRAINT `fk_review_property1`
    FOREIGN KEY (`property_propertyid`)
    REFERENCES `airbnb`.`property` (`propertyid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_guest1`
    FOREIGN KEY (`guest_guestId`)
    REFERENCES `airbnb`.`guest` (`guestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`reservation_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`reservation_request` (
  `reservation_requestid` INT NOT NULL,
  `checkin_date` DATE NULL,
  `checkout_date` DATE NULL,
  `no_of_guests` INT(11) NULL,
  `guestId` INT NOT NULL,
  `creation_date` DATE NULL,
  `status` VARCHAR(60) NULL,
  `property_propertyid` INT NOT NULL,
  PRIMARY KEY (`reservation_requestid`, `guestId`, `property_propertyid`),
  INDEX `fk_reservation_request_guest1_idx` (`guestId` ASC),
  INDEX `fk_reservation_request_property1_idx` (`property_propertyid` ASC),
  CONSTRAINT `fk_reservation_request_guest1`
    FOREIGN KEY (`guestId`)
    REFERENCES `airbnb`.`guest` (`guestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_request_property1`
    FOREIGN KEY (`property_propertyid`)
    REFERENCES `airbnb`.`property` (`propertyid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`city_wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`city_wishlist` (
  `city_wishlistid` INT NOT NULL,
  `city_code` VARCHAR(10) NOT NULL,
  `guest_guestId` INT NOT NULL,
  PRIMARY KEY (`city_wishlistid`, `city_code`, `guest_guestId`),
  INDEX `fk_city_wishlist_city1_idx` (`city_code` ASC),
  INDEX `fk_city_wishlist_guest1_idx` (`guest_guestId` ASC),
  CONSTRAINT `fk_city_wishlist_city1`
    FOREIGN KEY (`city_code`)
    REFERENCES `airbnb`.`city` (`city_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_city_wishlist_guest1`
    FOREIGN KEY (`guest_guestId`)
    REFERENCES `airbnb`.`guest` (`guestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `airbnb`.`amenities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `airbnb`.`amenities` (
  `amenitiesid` INT NOT NULL,
  `type` VARCHAR(30) NULL,
  `description` VARCHAR(60) NULL,
  `property_propertyid` INT NOT NULL,
  PRIMARY KEY (`amenitiesid`, `property_propertyid`),
  INDEX `fk_amenities_property1_idx` (`property_propertyid` ASC),
  CONSTRAINT `fk_amenities_property1`
    FOREIGN KEY (`property_propertyid`)
    REFERENCES `airbnb`.`property` (`propertyid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema event_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema event_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `event_db` DEFAULT CHARACTER SET utf8 ;
USE `event_db` ;

-- -----------------------------------------------------
-- Table `event_db`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  `zip_code` INT(5) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `house_number` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_address`),
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`company` (
  `id_company` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `nip` VARCHAR(10) NOT NULL,
  `id_address` INT NOT NULL,
  PRIMARY KEY (`id_company`),
  UNIQUE INDEX `id_company_UNIQUE` (`id_company` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `nip_UNIQUE` (`nip` ASC),
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC),
  CONSTRAINT `fk_company_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `event_db`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`event_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`event_type` (
  `id_event_type` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id_event_type`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `id_type_UNIQUE` (`id_event_type` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`status_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`status_event` (
  `id_status_event` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id_status_event`),
  UNIQUE INDEX `id_status_UNIQUE` (`id_status_event` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`department` (
  `id_department` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `id_address` INT NOT NULL,
  PRIMARY KEY (`id_department`),
  UNIQUE INDEX `id_address_UNIQUE` (`id_address` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `id_department_UNIQUE` (`id_department` ASC),
  CONSTRAINT `fk_department_address1`
    FOREIGN KEY (`id_address`)
    REFERENCES `event_db`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`event` (
  `id_event` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date_start_time` DATETIME NOT NULL,
  `date_end_time` DATETIME NOT NULL,
  `id_event_type` INT NOT NULL,
  `id_department` INT NOT NULL,
  `id_status_event` INT NOT NULL,
  `event_id_event` INT NULL,
  `max_number_of_contestant` INT NULL,
  PRIMARY KEY (`id_event`),
  INDEX `fk_event_event_type_idx` (`id_event_type` ASC),
  INDEX `fk_event_status_event1_idx` (`id_status_event` ASC),
  INDEX `fk_event_event1_idx` (`event_id_event` ASC),
  INDEX `fk_event_department1_idx` (`id_department` ASC),
  CONSTRAINT `fk_event_event_type`
    FOREIGN KEY (`id_event_type`)
    REFERENCES `event_db`.`event_type` (`id_event_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_status_event1`
    FOREIGN KEY (`id_status_event`)
    REFERENCES `event_db`.`status_event` (`id_status_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_event1`
    FOREIGN KEY (`event_id_event`)
    REFERENCES `event_db`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_department1`
    FOREIGN KEY (`id_department`)
    REFERENCES `event_db`.`department` (`id_department`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`user_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`user_type` (
  `id_user_type` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id_user_type`),
  UNIQUE INDEX `id_user_type_UNIQUE` (`id_user_type` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(9) NULL,
  `id_department` INT NULL,
  `id_company` INT NULL,
  `id_user_type` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_student_UNIQUE` (`id_user` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  INDEX `fk_user_department1_idx` (`id_department` ASC),
  INDEX `fk_user_company1_idx` (`id_company` ASC),
  INDEX `fk_user_user_type1_idx` (`id_user_type` ASC),
  CONSTRAINT `fk_user_department1`
    FOREIGN KEY (`id_department`)
    REFERENCES `event_db`.`department` (`id_department`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_company1`
    FOREIGN KEY (`id_company`)
    REFERENCES `event_db`.`company` (`id_company`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_user_type1`
    FOREIGN KEY (`id_user_type`)
    REFERENCES `event_db`.`user_type` (`id_user_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`status_in_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`status_in_event` (
  `id_status_in_event` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL,
  UNIQUE INDEX `id_status_in_event_UNIQUE` (`id_status_in_event` ASC),
  PRIMARY KEY (`id_status_in_event`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`user_in_event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`user_in_event` (
  `id_user_in_event` INT NOT NULL AUTO_INCREMENT,
  `id_event` INT NOT NULL,
  `id_user` INT NOT NULL,
  `rate` TINYINT NULL,
  `id_status_in_event` INT NOT NULL,
  PRIMARY KEY (`id_user_in_event`),
  UNIQUE INDEX `id_student_in_event_UNIQUE` (`id_user_in_event` ASC),
  INDEX `fk_user_in_event_user1_idx` (`id_user` ASC),
  INDEX `fk_user_in_event_event1_idx` (`id_event` ASC),
  INDEX `fk_user_in_event_status_in_event1_idx` (`id_status_in_event` ASC),
  CONSTRAINT `fk_user_in_event_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `event_db`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_in_event_event1`
    FOREIGN KEY (`id_event`)
    REFERENCES `event_db`.`event` (`id_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_in_event_status_in_event1`
    FOREIGN KEY (`id_status_in_event`)
    REFERENCES `event_db`.`status_in_event` (`id_status_in_event`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`post` (
  `id_post` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(35) NULL,
  `message` VARCHAR(200) NOT NULL,
  `datetime` VARCHAR(45) NOT NULL,
  `receiper` INT NOT NULL,
  `sender` INT NOT NULL,
  PRIMARY KEY (`id_post`),
  UNIQUE INDEX `id_post_UNIQUE` (`id_post` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_db`.`user_in_post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_db`.`user_in_post` (
  `id_user_in_post` INT NOT NULL,
  `id_post` INT NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_user_in_post`),
  INDEX `fk_post_has_user_user1_idx` (`id_user` ASC),
  CONSTRAINT `fk_post_has_user_post1`
    FOREIGN KEY (`id_post`)
    REFERENCES `event_db`.`post` (`id_post`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_user_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `event_db`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




insert into address values (null, 20250, "Lublin", "Diamentowa", "42B");
insert into address values (null, 20250, "Lublin", "Nadbystrzycka", "18C");
insert into company values (null, "XYZ", "1234567890", 2);
insert into department values (null, "Elektrotechnika i Informatyka", 2);
insert into user_type(id_user_type,name) values (null, "Student");
insert into user(id_user,firstname,lastname,login,password,email,phone,id_department,id_user_type) values
(null, "Krzysztof", "Jażyna", "krzys1234", "strongPasswd9", "krzysztof.jazyna@pollub.edu.pl", "999888777",1,1);
insert into status_in_event values(null,"uczestnik","opis");
insert into event_type values(null, "szkolenie");
insert into status_event values(null, "zaakceptowano", "zgloszenie zostalo zaakceptowane");
insert into post values(null,"przykładowy tytuł","przykładowa wiadomość","przykładowa data",1,2);
insert into event values(null,"przykładowe wydarzenie",'2021-03-23 16:30:00','2021-03-23 16:30:01',1,1,1,1,30);
insert into user_in_event values(null,1,1,4,1);
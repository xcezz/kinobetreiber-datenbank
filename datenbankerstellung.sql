--
-- Script date 11.06.2019 14:44:28
-- Server version: 5.5.5-10.3.15-MariaDB
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE `kinobetreiber-datenbank`;

--
-- Drop table `sitzplatz_reserviert`
--
DROP TABLE IF EXISTS sitzplatz_reserviert;

--
-- Drop table `reservierung`
--
DROP TABLE IF EXISTS reservierung;

--
-- Drop table `kunden`
--
DROP TABLE IF EXISTS kunden;

--
-- Drop table `vorstellungen`
--
DROP TABLE IF EXISTS vorstellungen;

--
-- Drop table `filme`
--
DROP TABLE IF EXISTS filme;

--
-- Drop table `sitzplaetze`
--
DROP TABLE IF EXISTS sitzplaetze;

--
-- Drop table `saele`
--
DROP TABLE IF EXISTS saele;

--
-- Drop table `kinos`
--
DROP TABLE IF EXISTS kinos;

--
-- Drop table `mandanten`
--
DROP TABLE IF EXISTS mandanten;

--
-- Set default database
--
USE `kinobetreiber-datenbank`;

--
-- Create table `mandanten`
--
CREATE TABLE mandanten (
  mandant_id int(11) NOT NULL,
  mandant_name varchar(256) NOT NULL,
  PRIMARY KEY (mandant_id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create table `kinos`
--
CREATE TABLE kinos (
  kino_id int(11) NOT NULL,
  kino_name varchar(256) NOT NULL,
  kino_kapazitaet int(11) NOT NULL,
  mandant_id int(11) NOT NULL,
  PRIMARY KEY (kino_id)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create foreign key
--
ALTER TABLE kinos
ADD CONSTRAINT Kinos_Mandanten FOREIGN KEY (mandant_id)
REFERENCES mandanten (mandant_id);

--
-- Create table `saele`
--
CREATE TABLE saele (
  saal_id int(11) NOT NULL AUTO_INCREMENT,
  saal_name varchar(32) NOT NULL,
  saal_kapazitaet int(11) NOT NULL,
  kino_id int(11) NOT NULL,
  PRIMARY KEY (saal_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create foreign key
--
ALTER TABLE saele
ADD CONSTRAINT Saele_Kinos FOREIGN KEY (kino_id)
REFERENCES kinos (kino_id);

--
-- Create table `sitzplaetze`
--
CREATE TABLE sitzplaetze (
  platz_id int(11) NOT NULL AUTO_INCREMENT,
  platz_reihe varchar(1) NOT NULL,
  platz_nummer int(11) NOT NULL,
  saal_id int(11) NOT NULL,
  PRIMARY KEY (platz_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 32,
AVG_ROW_LENGTH = 546,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create foreign key
--
ALTER TABLE sitzplaetze
ADD CONSTRAINT Sitzplaetze_Saal FOREIGN KEY (saal_id)
REFERENCES saele (saal_id);

--
-- Create table `filme`
--
CREATE TABLE filme (
  film_id int(11) NOT NULL AUTO_INCREMENT,
  film_name varchar(256) NOT NULL,
  film_beschreibung text DEFAULT NULL,
  film_dauer int(11) DEFAULT NULL,
  PRIMARY KEY (film_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 9,
AVG_ROW_LENGTH = 2340,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create table `vorstellungen`
--
CREATE TABLE vorstellungen (
  vorstellung_id int(11) NOT NULL AUTO_INCREMENT,
  film_id int(11) NOT NULL,
  saal_id int(11) NOT NULL,
  vorstellung_start timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (vorstellung_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 8814,
AVG_ROW_LENGTH = 1489,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create index `Projection_ak_1` on table `vorstellungen`
--
ALTER TABLE vorstellungen
ADD UNIQUE INDEX Projection_ak_1 (saal_id, vorstellung_start);

--
-- Create foreign key
--
ALTER TABLE vorstellungen
ADD CONSTRAINT Vorstellung_Film FOREIGN KEY (film_id)
REFERENCES filme (film_id);

--
-- Create foreign key
--
ALTER TABLE vorstellungen
ADD CONSTRAINT Vorstellung_Saal FOREIGN KEY (saal_id)
REFERENCES saele (saal_id);

--
-- Create table `kunden`
--
CREATE TABLE kunden (
  kunde_id int(11) NOT NULL,
  kunde_name varchar(256) NOT NULL,
  kunde_passwort varchar(256) NOT NULL,
  PRIMARY KEY (kunde_id)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create table `reservierung`
--
CREATE TABLE reservierung (
  reservierung_id int(11) NOT NULL AUTO_INCREMENT,
  vorstellung_id int(11) NOT NULL,
  kunde_id int(11) NOT NULL,
  reservierung_anzahl int(11) NOT NULL,
  PRIMARY KEY (reservierung_id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 26,
AVG_ROW_LENGTH = 655,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create foreign key
--
ALTER TABLE reservierung
ADD CONSTRAINT Reservierung_Kunden FOREIGN KEY (kunde_id)
REFERENCES kunden (kunde_id);

--
-- Create foreign key
--
ALTER TABLE reservierung
ADD CONSTRAINT Reservierung_Vorstellung FOREIGN KEY (vorstellung_id)
REFERENCES vorstellungen (vorstellung_id);

--
-- Create table `sitzplatz_reserviert`
--
CREATE TABLE sitzplatz_reserviert (
  id int(11) NOT NULL AUTO_INCREMENT,
  platz_id int(11) NOT NULL DEFAULT 1,
  reservierung_id int(11) NOT NULL DEFAULT 1,
  vorstellung_id int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 21,
AVG_ROW_LENGTH = 910,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Create foreign key
--
ALTER TABLE sitzplatz_reserviert
ADD CONSTRAINT Sitzplatz_reserviert_Reservierung FOREIGN KEY (reservierung_id)
REFERENCES reservierung (reservierung_id);

--
-- Create foreign key
--
ALTER TABLE sitzplatz_reserviert
ADD CONSTRAINT Sitzplatz_reserviert_Sitzplaetze FOREIGN KEY (platz_id)
REFERENCES sitzplaetze (platz_id);

--
-- Create foreign key
--
ALTER TABLE sitzplatz_reserviert
ADD CONSTRAINT Sitzplatz_reserviert_Vorstellungen FOREIGN KEY (vorstellung_id)
REFERENCES vorstellungen (vorstellung_id);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
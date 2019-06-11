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
-- Dumping data for table mandanten
--
INSERT INTO mandanten VALUES
(1, 'CorinLo');

-- 
-- Dumping data for table kinos
--
INSERT INTO kinos VALUES
(1, 'Cinemaxx Regensburg', 2052, 1),
(2, 'Cinemaxx München', 1501, 1);

-- 
-- Dumping data for table filme
--
INSERT INTO filme VALUES
(1, 'X-Men: Dark Phoenix', 'Viertes Action-Spektakel zur Vorgeschichte der Supermutanten, in dem Jean Grey (Sophie Turner) durch ihre Ängste zum "Dark Phoenix" wird und damit die Feindschaft zwischen Xaviers X-Men und Magneto auslöst.', 114),
(2, 'Godzilla 2: King of the Monsters', 'Godzilla und andere Monster liefern sich erbitterte Kämpfe auf der Erde.', 132),
(3, 'Rocketman', 'Bildgewaltige Filmbiografie über die Popmusik-Ikone Sir Elton John mit Taron Egerton ("Kingsman") in der Hauptrolle.', 121),
(4, 'Pokemon Meisterdetektiv Pickachu', 'Erstes Live-Action-Pokémon-Abenteuer, in dem Pikachu einen kniffligen Fall lösen muss. Menschliche Unterstützung erhält er von Justice Smith, Bill Nighy und Rita Ora.\r\n\r\n', 105),
(5, 'John Wick: Kapitel 3', 'Der dritte Teil der Action-Kultreihe mit Keanu Reeves macht da weiter, wo Teil 2 mit dem Eklat im Hotel Continental endete. Das heißt: John gegen den Rest der Welt!\r\n\r\n', 132),
(6, 'Avengers: Endgame', 'Episches Finale der Marvel-Saga rund um die Avengers-Helden Thor (Chris Hemsworth), Iron Man (Robert Downey Jr.), Captain America (Chris Evans), Black Widow (Scarlett Johansson), Hulk (Mark Ruffalo) und Hawkeye (Jeremy Renner).\r\n\r\n', 181),
(7, 'Alladin', 'EIN TRAUM WIRD WAHR! Voller Action, Romantik und ganz viel Humor! Erlebe die einzigartige Magie von Disneys Aladdin auf völlig neue Weise, denn die opulente Realverfilmung lässt keine Wünsche offen.', 128),
(8, 'TKKG', 'Ein Fall für TKKG: Die legendäre Ermittler-Bande ist zurück und darf einen Fall auf der Kinoleinwand lösen!', 96);

-- 
-- Dumping data for table saele
--
INSERT INTO saele VALUES
(1, '1', 306, 1),
(2, '2', 295, 1),
(3, '1', 301, 2);

-- 
-- Dumping data for table kunden
--
INSERT INTO kunden VALUES
(1, 'Müllner', 'bier123'),
(2, 'Schmidt', 'hallo'),
(3, 'Schneider', 'das'),
(4, 'Fischer', 'ist_nur'),
(5, 'Meyer', 'ein_Test'),
(6, 'Weber', 'qwertz');

-- 
-- Dumping data for table vorstellungen
--
INSERT INTO vorstellungen VALUES
(1, 1, 1, '2019-07-01 20:00:00'),
(2, 2, 1, '2019-07-02 20:00:00'),
(3, 3, 1, '2019-07-03 20:00:00'),
(4, 4, 1, '2019-07-04 20:00:00'),
(5, 5, 1, '2019-07-05 20:00:00'),
(6, 6, 1, '2019-07-06 20:00:00'),
(7, 7, 1, '2019-07-07 20:00:00'),
(8, 8, 1, '2019-07-08 20:00:00'),
(9, 1, 3, '2019-07-09 20:00:00'),
(10, 5, 3, '2019-07-09 22:00:00'),
(8813, 5, 2, '2019-07-05 22:00:00');

-- 
-- Dumping data for table sitzplaetze
--
INSERT INTO sitzplaetze VALUES
(1, 'A', 1, 1),
(3, 'A', 2, 1),
(4, 'A', 3, 1),
(5, 'A', 4, 1),
(6, 'A', 5, 1),
(7, 'B', 1, 1),
(8, 'B', 2, 1),
(9, 'B', 3, 1),
(10, 'B', 4, 1),
(11, 'B', 5, 1),
(12, 'A', 1, 2),
(13, 'A', 2, 2),
(14, 'A', 3, 2),
(15, 'A', 4, 2),
(16, 'A', 5, 2),
(17, 'B', 1, 2),
(18, 'B', 2, 2),
(19, 'B', 3, 2),
(20, 'B', 4, 2),
(21, 'B', 5, 2),
(22, 'A', 1, 3),
(23, 'A', 2, 3),
(24, 'A', 3, 3),
(25, 'A', 4, 3),
(26, 'A', 5, 3),
(27, 'B', 1, 3),
(28, 'B', 2, 3),
(29, 'B', 3, 3),
(30, 'B', 4, 3),
(31, 'B', 5, 3);

-- 
-- Dumping data for table reservierung
--
INSERT INTO reservierung VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 1, 3, 3),
(4, 2, 4, 2),
(5, 2, 5, 2),
(6, 2, 6, 4),
(7, 3, 1, 3),
(8, 4, 2, 4),
(9, 5, 3, 2),
(10, 5, 4, 1),
(11, 6, 5, 2),
(12, 6, 6, 2),
(13, 6, 1, 1),
(14, 7, 2, 1),
(15, 9, 3, 4),
(16, 9, 4, 2),
(17, 9, 5, 1),
(18, 8, 6, 2),
(19, 8, 1, 4),
(20, 10, 2, 1),
(21, 10, 3, 3),
(22, 10, 4, 3),
(23, 10, 5, 1),
(24, 10, 6, 3),
(25, 10, 1, 2);

-- 
-- Dumping data for table sitzplatz_reserviert
--
INSERT INTO sitzplatz_reserviert VALUES
(1, 1, 1, 1),
(4, 3, 2, 1),
(5, 4, 2, 1),
(6, 5, 3, 1),
(7, 6, 3, 1),
(8, 7, 3, 1),
(9, 7, 4, 2),
(10, 8, 4, 2),
(11, 9, 5, 2),
(12, 10, 5, 2),
(13, 11, 6, 2),
(14, 12, 6, 2),
(15, 13, 6, 2),
(16, 14, 6, 2),
(17, 1, 7, 3),
(18, 3, 7, 3),
(19, 4, 7, 3),
(20, 7, 8, 4);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
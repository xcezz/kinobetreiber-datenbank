--
-- Script date 11.06.2019 14:41:54
-- Server version: 5.5.5-10.3.15-MariaDB
-- Client version: 4.1
--


SET NAMES 'utf8';

INSERT INTO `kinobetreiber-datenbank`.filme(film_id, film_name, film_beschreibung, film_dauer) VALUES
(1, 'X-Men: Dark Phoenix', 'Viertes Action-Spektakel zur Vorgeschichte der Supermutanten, in dem Jean Grey (Sophie Turner) durch ihre Ängste zum "Dark Phoenix" wird und damit die Feindschaft zwischen Xaviers X-Men und Magneto auslöst.', 114),
(2, 'Godzilla 2: King of the Monsters', 'Godzilla und andere Monster liefern sich erbitterte Kämpfe auf der Erde.', 132),
(3, 'Rocketman', 'Bildgewaltige Filmbiografie über die Popmusik-Ikone Sir Elton John mit Taron Egerton ("Kingsman") in der Hauptrolle.', 121),
(4, 'Pokemon Meisterdetektiv Pickachu', 'Erstes Live-Action-Pokémon-Abenteuer, in dem Pikachu einen kniffligen Fall lösen muss. Menschliche Unterstützung erhält er von Justice Smith, Bill Nighy und Rita Ora.\r\n\r\n', 105),
(5, 'John Wick: Kapitel 3', 'Der dritte Teil der Action-Kultreihe mit Keanu Reeves macht da weiter, wo Teil 2 mit dem Eklat im Hotel Continental endete. Das heißt: John gegen den Rest der Welt!\r\n\r\n', 132),
(6, 'Avengers: Endgame', 'Episches Finale der Marvel-Saga rund um die Avengers-Helden Thor (Chris Hemsworth), Iron Man (Robert Downey Jr.), Captain America (Chris Evans), Black Widow (Scarlett Johansson), Hulk (Mark Ruffalo) und Hawkeye (Jeremy Renner).\r\n\r\n', 181),
(7, 'Alladin', 'EIN TRAUM WIRD WAHR! Voller Action, Romantik und ganz viel Humor! Erlebe die einzigartige Magie von Disneys Aladdin auf völlig neue Weise, denn die opulente Realverfilmung lässt keine Wünsche offen.', 128),
(8, 'TKKG', 'Ein Fall für TKKG: Die legendäre Ermittler-Bande ist zurück und darf einen Fall auf der Kinoleinwand lösen!', 96);


INSERT INTO `kinobetreiber-datenbank`.kinos(kino_id, kino_name, kino_kapazitaet, mandant_id) VALUES
(1, 'Cinemaxx Regensburg', 2052, 1),
(2, 'Cinemaxx München', 1501, 1);


INSERT INTO `kinobetreiber-datenbank`.kunden(kunde_id, kunde_name, kunde_passwort) VALUES
(1, 'Müllner', 'bier123'),
(2, 'Schmidt', 'hallo'),
(3, 'Schneider', 'das'),
(4, 'Fischer', 'ist_nur'),
(5, 'Meyer', 'ein_Test'),
(6, 'Weber', 'qwertz');


INSERT INTO `kinobetreiber-datenbank`.mandanten(mandant_id, mandant_name) VALUES
(1, 'CorinLo');


INSERT INTO `kinobetreiber-datenbank`.reservierung(reservierung_id, vorstellung_id, kunde_id, reservierung_anzahl) VALUES
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


INSERT INTO `kinobetreiber-datenbank`.saele(saal_id, saal_name, saal_kapazitaet, kino_id) VALUES
(1, '1', 306, 1),
(2, '2', 295, 1),
(3, '1', 301, 2);


INSERT INTO `kinobetreiber-datenbank`.sitzplaetze(platz_id, platz_reihe, platz_nummer, saal_id) VALUES
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


INSERT INTO `kinobetreiber-datenbank`.sitzplatz_reserviert(id, platz_id, reservierung_id, vorstellung_id) VALUES
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


INSERT INTO `kinobetreiber-datenbank`.vorstellungen(vorstellung_id, film_id, saal_id, vorstellung_start) VALUES
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
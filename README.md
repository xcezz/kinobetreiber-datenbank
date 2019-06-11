# Kinobetreiber-Datenbank

`datenbank_backup.sql` - die komplette Datenbank inkl. Beispieldaten
`datenbankerstellung.sql` - das Skript zur Datenbankerstellung
`daten.sql` - die Beispieldaten
`schema.jpg` - das Datenbankschema



## Welche Filme laufen in einem gegebenen Zeitraum?

**SQL:**

    SELECT
      filme.film_name,
      vorstellungen.vorstellung_start
    FROM vorstellungen
      INNER JOIN filme
        ON vorstellungen.film_id = filme.film_id
    WHERE vorstellungen.vorstellung_start BETWEEN '2019-07-01 00:00:01' AND '2019-07-03 23:59:59'

**Returns:**

        film_name                         vorstellung_start
    ----------------------------------------------------------
    X-Men: Dark Phoenix                   01.07.2019 20:00:00
    Godzilla 2: King of the Monsters      02.07.2019 20:00:00
    Rocketman                             03.07.2019 20:00:00


## Alle Vorstellungen eines Films in einem bestimmten Kino an einem bestimmten Tag

**SQL:**

    SELECT
      filme.film_name,
      vorstellungen.vorstellung_start,
      kinos.kino_name
    FROM kinos,
         vorstellungen
           INNER JOIN filme
             ON vorstellungen.film_id = filme.film_id
    WHERE vorstellungen.vorstellung_start BETWEEN '2019-07-05 00:00:01' AND '2019-07-05 23:59:59'
    AND filme.film_name = 'John Wick: Kapitel 3'
    AND kinos.kino_name = 'Cinemaxx Regensburg'

**Returns:**

        film_name           vorstellung_start         kino_name
    -----------------------------------------------------------------
    John Wick: Kapitel 3	05.07.2019 20:00:00   Cinemaxx Regensburg
    John Wick: Kapitel 3	05.07.2019 22:00:00   Cinemaxx Regensburg

## Freie Sitzplätze bei einer gegebenen Veranstaltung

Sitzplätze gesamt - Reservierte Sitzplätze = freie Sitzplätze

**SQL:**

    SELECT
          (SELECT
            saele.saal_kapazitaet
          FROM vorstellungen
            INNER JOIN saele
              ON vorstellungen.saal_id = saele.saal_id
          WHERE vorstellungen.vorstellung_id = 2)
      
      
       - (SELECT COUNT(*) AS reservierungen_gesamt
          FROM vorstellungen
            INNER JOIN filme
              ON vorstellungen.film_id = filme.film_id
            INNER JOIN sitzplatz_reserviert
              ON sitzplatz_reserviert.vorstellung_id = vorstellungen.vorstellung_id
           WHERE vorstellungen.vorstellung_id = 2) AS freie_plätze

**Returns:**

    freie_plätze
    ------------
     298
   (306 gesamt - 8 reserviert = 298 frei)

## Meiste Reservierungen pro Film

**SQL:**

    SELECT
      filme.film_name,
      COUNT(sitzplatz_reserviert.platz_id) AS reservierungen_gesamt
    FROM sitzplatz_reserviert
      INNER JOIN vorstellungen
        ON sitzplatz_reserviert.vorstellung_id = vorstellungen.vorstellung_id
      INNER JOIN filme
        ON vorstellungen.film_id = filme.film_id
    GROUP BY filme.film_name
    ORDER BY reservierungen_gesamt DESC
    LIMIT 1

**Returns:**

    film_name                       reservierungen_gesamt
    ------------------------------------------------------
    Godzilla 2: King of the Monsters          8

-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 07_import_csv.sql
-- Beschreibung: CSV-Import der Originaldaten (UTF-8 kodiert)
-- Voraussetzung: CSV-Dateien aus backpacker_lb3.csv.zip entpackt
--               Pfade in den LOAD DATA Statements anpassen!
-- Ausführen als: root
-- Hinweis: LOCAL INFILE muss aktiviert sein:
--   SET GLOBAL local_infile = 1;
-- Wichtig: CSV-Dateien sind UTF-8 kodiert (trotz urspr. latin1 in Access)
-- Bekannte Datenprobleme (werden durch 08_bereinigung.sql behoben):
--   - Land_ID 212 und 220 je 2x vorhanden (Duplikat-PKs) → 83 statt 85 Zeilen
--   - Benutzername 'mueller' 2x (IDs 2 + 25) → ID=25 wird umbenannt
--   - 441 ungültige Land_FS in tbl_buchung → wird auf NULL gesetzt
--   - 19 Buchungen mit Abreise < Ankunft → Abreise wird auf NULL gesetzt
-- ============================================================

USE backpacker_lb3;

-- Sicherstellen dass FK-Checks beim Import deaktiviert sind
SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- tbl_land (85 Datensätze erwartet)
-- ------------------------------------------------------------
LOAD DATA LOCAL INFILE 'tbl_land.csv'
INTO TABLE tbl_land

FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Land_ID, Land);

-- ------------------------------------------------------------
-- tbl_leistung (7 Datensätze erwartet)
-- ------------------------------------------------------------
LOAD DATA LOCAL INFILE 'tbl_leistung.csv'
INTO TABLE tbl_leistung

FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(LeistungID, Beschreibung);

-- ------------------------------------------------------------
-- tbl_personen (2035 Datensätze erwartet)
-- ------------------------------------------------------------
LOAD DATA LOCAL INFILE 'tbl_personen.csv'
INTO TABLE tbl_personen

FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Personen_ID, Titel, Vorname, Name, Strasse, PLZ, Ort, Anrede, Telefon, erfasst, Sprache);

-- ------------------------------------------------------------
-- tbl_benutzer (11 Datensätze erwartet)
-- Hinweis: Passwörter sind im Original Klartext – nicht produktiv verwenden!
-- ------------------------------------------------------------
LOAD DATA LOCAL INFILE 'tbl_benutzer.csv'
INTO TABLE tbl_benutzer

FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Benutzer_ID, Benutzername, Password, Vorname, Name, Benutzergruppe, erfasst, deaktiviert, aktiv);

-- ------------------------------------------------------------
-- tbl_buchung (1005 Datensätze erwartet)
-- ------------------------------------------------------------
LOAD DATA LOCAL INFILE 'tbl_buchung.csv'
INTO TABLE tbl_buchung

FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Buchungs_ID, Personen_FS, Ankunft, Abreise, Land_FS);

-- ------------------------------------------------------------
-- tbl_positionen (1745 Datensätze erwartet)
-- ------------------------------------------------------------
LOAD DATA LOCAL INFILE 'tbl_positionen.csv'
INTO TABLE tbl_positionen

FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Positions_ID, Buchungs_FS, Konto, Anzahl, Preis, Rabatt, Benutzer_FS, erfasst, Leistung_Text, Leistung_FS);

-- FK-Checks wieder aktivieren
SET FOREIGN_KEY_CHECKS = 1;

-- Verifikation: Datensätze pro Tabelle
SELECT 'tbl_land'       AS Tabelle, COUNT(*) AS Anzahl, 85   AS Erwartet FROM tbl_land
UNION ALL SELECT 'tbl_leistung',    COUNT(*), 7                           FROM tbl_leistung
UNION ALL SELECT 'tbl_personen',    COUNT(*), 2035                        FROM tbl_personen
UNION ALL SELECT 'tbl_benutzer',    COUNT(*), 11                          FROM tbl_benutzer
UNION ALL SELECT 'tbl_buchung',     COUNT(*), 1005                        FROM tbl_buchung
UNION ALL SELECT 'tbl_positionen',  COUNT(*), 1745                        FROM tbl_positionen;

SELECT 'CSV-Import abgeschlossen. Bereinigung mit 08_bereinigung.sql durchführen!' AS Hinweis;

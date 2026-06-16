-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: test_berechtigungen.sql
-- Beschreibung: Tests der Zugriffsberechtigungen gemäss Zugriffsmatrix
-- Ausführen: je als entsprechender Benutzer (bp_benutzer / bp_management)
-- ============================================================

-- ============================================================
-- TESTS als bp_benutzer
-- ============================================================

-- T01: SELECT tbl_personen → ERLAUBT
SELECT 'T01 - SELECT tbl_personen (Benutzer)' AS Test;
SELECT Personen_ID, Vorname, Name FROM tbl_personen LIMIT 3;

-- T02: INSERT tbl_personen → NICHT ERLAUBT (soll Fehler geben)
-- SELECT 'T02 - INSERT tbl_personen (Benutzer) → soll FEHLER geben' AS Test;
-- INSERT INTO tbl_personen (Vorname, Name) VALUES ('Test', 'Negativ');

-- T03: SELECT tbl_benutzer (ohne Password) → ERLAUBT
SELECT 'T03 - SELECT tbl_benutzer ohne Password (Benutzer)' AS Test;
SELECT Benutzer_ID, Benutzername, Vorname, Name, deaktiviert FROM tbl_benutzer LIMIT 3;

-- T04: SELECT Password → NICHT ERLAUBT (soll Fehler geben)
-- SELECT 'T04 - SELECT Password (Benutzer) → soll FEHLER geben' AS Test;
-- SELECT Password FROM tbl_benutzer;

-- T05: SELECT, INSERT, UPDATE, DELETE tbl_buchung → ERLAUBT
SELECT 'T05 - SELECT tbl_buchung (Benutzer)' AS Test;
SELECT Buchungs_ID, Personen_FS, Ankunft, Abreise FROM tbl_buchung LIMIT 3;

-- T06: SELECT tbl_land → ERLAUBT
SELECT 'T06 - SELECT tbl_land (Benutzer)' AS Test;
SELECT * FROM tbl_land LIMIT 5;

-- T07: INSERT tbl_land → NICHT ERLAUBT (soll Fehler geben)
-- SELECT 'T07 - INSERT tbl_land (Benutzer) → soll FEHLER geben' AS Test;
-- INSERT INTO tbl_land (Land_ID, Land) VALUES (999, 'TestLand');


-- ============================================================
-- TESTS als bp_management
-- ============================================================

-- T08: SELECT tbl_buchung (Management) → ERLAUBT (nur SELECT)
SELECT 'T08 - SELECT tbl_buchung (Management)' AS Test;
SELECT Buchungs_ID, Personen_FS, Ankunft FROM tbl_buchung LIMIT 3;

-- T09: INSERT tbl_buchung (Management) → NICHT ERLAUBT (soll Fehler geben)
-- SELECT 'T09 - INSERT tbl_buchung (Management) → soll FEHLER geben' AS Test;
-- INSERT INTO tbl_buchung (Personen_FS, Ankunft) VALUES (1, NOW());

-- T10: SELECT, INSERT, UPDATE, DELETE tbl_personen (Management) → ERLAUBT
SELECT 'T10 - SELECT tbl_personen (Management)' AS Test;
SELECT Personen_ID, Vorname, Name FROM tbl_personen LIMIT 3;

SELECT 'Alle erlaubten Tests abgeschlossen. Negative Tests auskommentiert.' AS Zusammenfassung;

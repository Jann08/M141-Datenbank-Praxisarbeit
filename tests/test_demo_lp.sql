-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: test_demo_lp.sql
-- Beschreibung: Demo-Testskript (Live-Präsentation)
--              Zeigt Zugriffsmatrix, FK-Constraints und Migration
-- Ausführen als: root (für Übersicht), dann als jeweiliger User
-- ============================================================

-- ============================================================
-- SCHRITT 1: Systemübersicht (als root)
-- ============================================================
SELECT '=== SYSTEM-ÜBERSICHT ===' AS Demo;
SELECT VERSION() AS MariaDB_Version, @@hostname AS Host, @@datadir AS Datenverzeichnis;

SELECT '=== DATENBANKINHALT ===' AS Demo;
SELECT TABLE_NAME, TABLE_ROWS, ENGINE, TABLE_COLLATION
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'backpacker_lb3'
ORDER BY TABLE_NAME;

-- ============================================================
-- SCHRITT 2: Benutzer und Rechte zeigen
-- ============================================================
SELECT '=== DATENBANK-BENUTZER ===' AS Demo;
SELECT User, Host FROM mysql.user
WHERE User IN ('bp_benutzer', 'bp_management', 'bp_readonly')
ORDER BY User;

-- ============================================================
-- SCHRITT 3: FK-Constraints zeigen
-- ============================================================
SELECT '=== FREMDSCHLÜSSEL-CONSTRAINTS ===' AS Demo;
SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME,
       REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'backpacker_lb3'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

-- ============================================================
-- SCHRITT 4: Positivtests (als bp_benutzer ausführen)
-- ============================================================
-- mysql -u bp_benutzer -p backpacker_lb3

SELECT '=== T01: SELECT tbl_personen (bp_benutzer) → ERLAUBT ===' AS Test;
SELECT Personen_ID, Vorname, Name, Ort FROM tbl_personen LIMIT 5;

SELECT '=== T03: SELECT tbl_benutzer ohne Password (bp_benutzer) → ERLAUBT ===' AS Test;
SELECT Benutzer_ID, Benutzername, Vorname, Name, deaktiviert FROM tbl_benutzer LIMIT 5;

SELECT '=== T05: SELECT tbl_buchung (bp_benutzer) → ERLAUBT ===' AS Test;
SELECT Buchungs_ID, Personen_FS, Ankunft, Abreise FROM tbl_buchung LIMIT 5;

SELECT '=== T07: SELECT tbl_land (bp_benutzer) → ERLAUBT ===' AS Test;
SELECT * FROM tbl_land LIMIT 5;

-- ============================================================
-- SCHRITT 5: Negativtests – Kommentare entfernen zum Zeigen
-- (als bp_benutzer) → soll ACCESS DENIED ergeben
-- ============================================================
SELECT '=== NEGATIVTESTS (auskommentiert – Kommentare entfernen für Demo) ===' AS Info;

-- SELECT 'T02: INSERT tbl_personen (bp_benutzer) → ACCESS DENIED' AS Test;
-- INSERT INTO tbl_personen (Vorname, Name) VALUES ('Demo', 'Test');

-- SELECT 'T04: SELECT Password (bp_benutzer) → ACCESS DENIED' AS Test;
-- SELECT Password FROM tbl_benutzer LIMIT 1;

-- SELECT 'T08: INSERT tbl_land (bp_benutzer) → ACCESS DENIED' AS Test;
-- INSERT INTO tbl_land (Land_ID, Land) VALUES (999, 'TestLand');

-- ============================================================
-- SCHRITT 6: Management-Tests (als bp_management ausführen)
-- mysql -u bp_management -p backpacker_lb3
-- ============================================================
SELECT '=== T09: SELECT tbl_buchung (bp_management) → ERLAUBT ===' AS Test;
SELECT Buchungs_ID, Personen_FS, Ankunft FROM tbl_buchung LIMIT 5;

-- SELECT 'T10: INSERT tbl_buchung (bp_management) → ACCESS DENIED' AS Test;
-- INSERT INTO tbl_buchung (Personen_FS, Ankunft) VALUES (1, NOW());

SELECT '=== T11: SELECT tbl_personen (bp_management) → ERLAUBT ===' AS Test;
SELECT Personen_ID, Vorname, Name FROM tbl_personen LIMIT 5;

-- ============================================================
-- SCHRITT 7: Constraint-Demo (FK-Verletzung provozieren)
-- ============================================================
SELECT '=== CONSTRAINT-DEMO: FK-Verletzung ==='  AS Demo;
SELECT 'Versuch: Buchung mit nicht existierendem Personen_FS=99999' AS Info;
-- INSERT INTO tbl_buchung (Personen_FS, Ankunft) VALUES (99999, NOW());
-- Erwartet: ERROR 1452 (FOREIGN KEY constraint fails)

SELECT '=== DEMO ABGESCHLOSSEN ===' AS Ende;
SELECT CONCAT('Testzeit: ', NOW()) AS Zeitstempel;

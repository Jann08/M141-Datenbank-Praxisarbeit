-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: test_migration.sql
-- Beschreibung: Migrationsprüfung (Vergleich lokal vs. Cloud)
-- Ausführen als: root (auf Cloud-DBMS nach Migration)
-- ============================================================

USE backpacker_lb3;

-- T30: Datensatzanzahl (soll identisch zu lokal sein)
SELECT 'T30 - Datensatzanzahl nach Migration' AS Test;
SELECT 'tbl_land'       AS Tabelle, COUNT(*) AS Anzahl FROM tbl_land
UNION ALL SELECT 'tbl_leistung',    COUNT(*) FROM tbl_leistung
UNION ALL SELECT 'tbl_personen',    COUNT(*) FROM tbl_personen
UNION ALL SELECT 'tbl_benutzer',    COUNT(*) FROM tbl_benutzer
UNION ALL SELECT 'tbl_buchung',     COUNT(*) FROM tbl_buchung
UNION ALL SELECT 'tbl_positionen',  COUNT(*) FROM tbl_positionen;

-- T31: Engine-Prüfung (soll InnoDB sein)
SELECT 'T31 - Storage Engine der Tabellen' AS Test;
SELECT TABLE_NAME, ENGINE, TABLE_COLLATION
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'backpacker_lb3'
ORDER BY TABLE_NAME;

-- T32: FK-Constraints aktiv?
SELECT 'T32 - Fremdschlüssel-Constraints' AS Test;
SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'backpacker_lb3'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

-- T33: Benutzer vorhanden?
SELECT 'T33 - DB-Benutzer auf Cloud' AS Test;
SELECT User, Host FROM mysql.user
WHERE User IN ('bp_benutzer', 'bp_management', 'bp_readonly');

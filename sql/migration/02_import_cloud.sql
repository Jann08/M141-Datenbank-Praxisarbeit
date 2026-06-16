-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 02_import_cloud.sql
-- Beschreibung: Import auf Cloud-DBMS nach Dump
-- Ausführen als: Cloud-Admin
-- ============================================================

-- ============================================================
-- Import-Befehl (in Terminal ausführen):
-- mysql -h <cloud-host> -u <admin-user> -p backpacker_lb3 < backup/backpacker_lb3_lokal.sql
-- ============================================================

-- Nach dem Import: Anzahl Datensätze prüfen (identisch zu lokal?)
USE backpacker_lb3;

SELECT 'tbl_land'       AS Tabelle, COUNT(*) AS Anzahl FROM tbl_land
UNION ALL
SELECT 'tbl_leistung',              COUNT(*)           FROM tbl_leistung
UNION ALL
SELECT 'tbl_personen',              COUNT(*)           FROM tbl_personen
UNION ALL
SELECT 'tbl_benutzer',              COUNT(*)           FROM tbl_benutzer
UNION ALL
SELECT 'tbl_buchung',               COUNT(*)           FROM tbl_buchung
UNION ALL
SELECT 'tbl_positionen',            COUNT(*)           FROM tbl_positionen;

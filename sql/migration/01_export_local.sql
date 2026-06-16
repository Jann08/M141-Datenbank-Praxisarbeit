-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 01_export_local.sql
-- Beschreibung: Export-Vorbereitung / Konsistenzprüfung vor Migration
-- Ausführen als: root (lokal), vor mysqldump
-- ============================================================

USE backpacker_lb3;

-- Anzahl Datensätze pro Tabelle prüfen (für Vergleich nach Migration)
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

-- Waisendatensätze prüfen (verwaiste FK)
SELECT COUNT(*) AS Buchungen_ohne_Person
FROM tbl_buchung b
LEFT JOIN tbl_personen p ON b.Personen_FS = p.Personen_ID
WHERE b.Personen_FS IS NOT NULL AND p.Personen_ID IS NULL;

SELECT COUNT(*) AS Positionen_ohne_Buchung
FROM tbl_positionen pos
LEFT JOIN tbl_buchung b ON pos.Buchungs_FS = b.Buchungs_ID
WHERE pos.Buchungs_FS IS NOT NULL AND b.Buchungs_ID IS NULL;

-- ============================================================
-- Dump-Befehl (in Terminal ausführen, NICHT in SQL):
-- mysqldump -u root -p backpacker_lb3 > backup/backpacker_lb3_lokal.sql
-- ============================================================

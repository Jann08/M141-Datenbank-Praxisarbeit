-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: test_datenkonsistenz.sql
-- Beschreibung: Datenkonsistenz und FK-Integrität prüfen
-- Ausführen als: root
-- ============================================================

USE backpacker_lb3;

-- T20: FK-Konsistenz tbl_buchung → tbl_personen
SELECT 'T20 - Buchungen ohne gültige Person (FK)' AS Test;
SELECT COUNT(*) AS Fehler_Buchung_Person
FROM tbl_buchung b
LEFT JOIN tbl_personen p ON b.Personen_FS = p.Personen_ID
WHERE b.Personen_FS IS NOT NULL AND p.Personen_ID IS NULL;

-- T21: FK-Konsistenz tbl_buchung → tbl_land
SELECT 'T21 - Buchungen ohne gültiges Land (FK)' AS Test;
SELECT COUNT(*) AS Fehler_Buchung_Land
FROM tbl_buchung b
LEFT JOIN tbl_land l ON b.Land_FS = l.Land_ID
WHERE b.Land_FS IS NOT NULL AND l.Land_ID IS NULL;

-- T22: FK-Konsistenz tbl_positionen → tbl_buchung
SELECT 'T22 - Positionen ohne gültige Buchung (FK)' AS Test;
SELECT COUNT(*) AS Fehler_Position_Buchung
FROM tbl_positionen p
LEFT JOIN tbl_buchung b ON p.Buchungs_FS = b.Buchungs_ID
WHERE p.Buchungs_FS IS NOT NULL AND b.Buchungs_ID IS NULL;

-- T23: Negative Preise
SELECT 'T23 - Positionen mit negativem Preis' AS Test;
SELECT COUNT(*) AS Fehler_Preis_Negativ
FROM tbl_positionen
WHERE Preis < 0;

-- T24: Ungültige Buchungsdaten (Abreise vor Ankunft)
SELECT 'T24 - Buchungen mit Abreise vor Ankunft' AS Test;
SELECT COUNT(*) AS Fehler_Datum
FROM tbl_buchung
WHERE Abreise IS NOT NULL AND Ankunft IS NOT NULL AND Abreise < Ankunft;

-- T25: Leere Benutzernamen
SELECT 'T25 - Benutzer mit leerem Benutzernamen' AS Test;
SELECT COUNT(*) AS Fehler_Benutzername
FROM tbl_benutzer
WHERE Benutzername IS NULL OR Benutzername = '';

-- T26: Gesamtübersicht Datensätze
SELECT 'T26 - Datensätze pro Tabelle' AS Test;
SELECT 'tbl_land'       AS Tabelle, COUNT(*) AS Anzahl FROM tbl_land
UNION ALL SELECT 'tbl_leistung',    COUNT(*) FROM tbl_leistung
UNION ALL SELECT 'tbl_personen',    COUNT(*) FROM tbl_personen
UNION ALL SELECT 'tbl_benutzer',    COUNT(*) FROM tbl_benutzer
UNION ALL SELECT 'tbl_buchung',     COUNT(*) FROM tbl_buchung
UNION ALL SELECT 'tbl_positionen',  COUNT(*) FROM tbl_positionen;

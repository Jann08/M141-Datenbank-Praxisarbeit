-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 08_bereinigung.sql
-- Beschreibung: Datenbereinigung nach CSV-Import
--              (FK-Konsistenz, Datumslogik, Access-Dummywerte)
-- Ausführen als: root, nach 07_import_csv.sql
-- ============================================================

USE backpacker_lb3;

SELECT '=== Bereinigung Start ===' AS Info;

-- ============================================================
-- PROBLEM 1: tbl_buchung.Land_FS – ungültige FK-Werte
-- Analyse: 438x Land_FS=0, 3x Land_FS=176 → nicht in tbl_land
-- Lösung:  Auf NULL setzen (Herkunftsland unbekannt)
-- ============================================================
SELECT CONCAT('Vor Bereinigung: ', COUNT(*), ' Buchungen mit ungültigem Land_FS') AS Info
FROM tbl_buchung WHERE Land_FS NOT IN (SELECT Land_ID FROM tbl_land) AND Land_FS IS NOT NULL;

UPDATE tbl_buchung
SET Land_FS = NULL
WHERE Land_FS IS NOT NULL
  AND Land_FS NOT IN (SELECT Land_ID FROM tbl_land);

SELECT CONCAT('Nach Bereinigung: ', COUNT(*), ' Buchungen mit ungültigem Land_FS (soll 0 sein)') AS Info
FROM tbl_buchung WHERE Land_FS NOT IN (SELECT Land_ID FROM tbl_land) AND Land_FS IS NOT NULL;

-- ============================================================
-- PROBLEM 2: tbl_buchung – Abreise vor Ankunft (19 Fälle)
-- Lösung:  Abreise auf NULL setzen (Check-Out-Datum unbekannt)
-- ============================================================
SELECT CONCAT('Vor Bereinigung: ', COUNT(*), ' Buchungen mit Abreise < Ankunft') AS Info
FROM tbl_buchung WHERE Abreise IS NOT NULL AND Ankunft IS NOT NULL AND Abreise < Ankunft;

UPDATE tbl_buchung
SET Abreise = NULL
WHERE Abreise IS NOT NULL AND Ankunft IS NOT NULL AND Abreise < Ankunft;

SELECT CONCAT('Nach Bereinigung: ', COUNT(*), ' Buchungen mit Abreise < Ankunft (soll 0 sein)') AS Info
FROM tbl_buchung WHERE Abreise IS NOT NULL AND Ankunft IS NOT NULL AND Abreise < Ankunft;

-- ============================================================
-- PROBLEM 3: tbl_benutzer.deaktiviert = '1000-01-01'
-- Analyse: Access-Dummy-Datum, bedeutet "nicht deaktiviert" (8 Fälle)
-- Lösung:  Auf NULL setzen
-- ============================================================
SELECT CONCAT('Vor Bereinigung: ', COUNT(*), ' Benutzer mit deaktiviert=1000-01-01') AS Info
FROM tbl_benutzer WHERE deaktiviert = '1000-01-01';

UPDATE tbl_benutzer
SET deaktiviert = NULL
WHERE deaktiviert = '1000-01-01';

SELECT CONCAT('Nach Bereinigung: ', COUNT(*), ' Benutzer mit deaktiviert=1000-01-01 (soll 0 sein)') AS Info
FROM tbl_benutzer WHERE deaktiviert = '1000-01-01';

-- ============================================================
-- PROBLEM 4: Passwörter im Klartext
-- Lösung: SHA2-Hash der bestehenden Passwörter (für Produktion
--         müssten echte Passwörter vergeben werden)
-- ============================================================
UPDATE tbl_benutzer
SET Password = SHA2(Password, 256)
WHERE Password IS NOT NULL AND Password != '';

SELECT 'Passwörter gehasht (SHA2-256).' AS Info;

-- ============================================================
-- Schluss-Verifikation: FK-Konsistenz prüfen
-- ============================================================
SELECT '=== FK-Konsistenz nach Bereinigung ===' AS Info;

SELECT 'Buchung→Personen Fehler:' AS Test, COUNT(*) AS Anzahl
FROM tbl_buchung b LEFT JOIN tbl_personen p ON b.Personen_FS = p.Personen_ID
WHERE b.Personen_FS IS NOT NULL AND p.Personen_ID IS NULL
UNION ALL
SELECT 'Buchung→Land Fehler:', COUNT(*)
FROM tbl_buchung b LEFT JOIN tbl_land l ON b.Land_FS = l.Land_ID
WHERE b.Land_FS IS NOT NULL AND l.Land_ID IS NULL
UNION ALL
SELECT 'Positionen→Buchung Fehler:', COUNT(*)
FROM tbl_positionen pos LEFT JOIN tbl_buchung b ON pos.Buchungs_FS = b.Buchungs_ID
WHERE pos.Buchungs_FS IS NOT NULL AND b.Buchungs_ID IS NULL
UNION ALL
SELECT 'Positionen→Leistung Fehler:', COUNT(*)
FROM tbl_positionen pos LEFT JOIN tbl_leistung l ON pos.Leistung_FS = l.LeistungID
WHERE pos.Leistung_FS IS NOT NULL AND l.LeistungID IS NULL
UNION ALL
SELECT 'Positionen→Benutzer Fehler:', COUNT(*)
FROM tbl_positionen pos LEFT JOIN tbl_benutzer b ON pos.Benutzer_FS = b.Benutzer_ID
WHERE pos.Benutzer_FS IS NOT NULL AND b.Benutzer_ID IS NULL;

SELECT '=== Bereinigung abgeschlossen ===' AS Info;
SELECT 'Nächster Schritt: test_datenkonsistenz.sql ausführen' AS Hinweis;

-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 05_testdata.sql
-- Beschreibung: Testdaten für lokale Tests und Migrationstests
-- Ausführen als: root oder bp_benutzer, nach Import der CSV-Daten
-- ============================================================

USE backpacker_lb3;

-- Testdaten für tbl_land (falls leer)
INSERT IGNORE INTO tbl_land (Land_ID, Land) VALUES
    (1,  'Schweiz'),
    (2,  'Deutschland'),
    (3,  'Österreich'),
    (4,  'Frankreich'),
    (5,  'Italien');

-- Testdaten für tbl_leistung (falls leer)
INSERT IGNORE INTO tbl_leistung (LeistungID, Beschreibung) VALUES
    (1, 'Übernachtung'),
    (2, 'Frühstück'),
    (3, 'Abendessen'),
    (4, 'Wäsche'),
    (5, 'Fahrradverleih');

-- Testperson (für FK-Tests)
INSERT INTO tbl_personen (Titel, Vorname, Name, Strasse, PLZ, Ort, Anrede, Telefon, erfasst, Sprache)
VALUES
    (NULL, 'Max', 'Mustermann', 'Teststrasse 1', '8000', 'Zürich', 'Herr', '044 000 00 00', NOW(), 'DE'),
    (NULL, 'Anna', 'Muster', 'Musterweg 5', '3000', 'Bern', 'Frau', '031 000 00 00', NOW(), 'DE');

-- Testbenutzer (Mitarbeiter)
INSERT INTO tbl_benutzer (Benutzername, Password, Vorname, Name, Benutzergruppe, aktiv)
VALUES
    ('mitarbeiter1', SHA2('Test1234!', 256), 'Hans', 'Meier', 1, 1),
    ('manager1',     SHA2('Admin5678!', 256), 'Lisa', 'Huber', 2, 1);

-- Testbuchung
INSERT INTO tbl_buchung (Personen_FS, Ankunft, Abreise, Land_FS)
VALUES
    (1, '2026-07-01 14:00:00', '2026-07-03 11:00:00', 1),
    (2, '2026-07-05 15:00:00', '2026-07-07 10:00:00', 2);

-- Testpositionen
INSERT INTO tbl_positionen (Buchungs_FS, Konto, Anzahl, Preis, Rabatt, Benutzer_FS, erfasst, Leistung_Text, Leistung_FS)
VALUES
    (1, 100, 2, 35.00, 0.00, 1, NOW(), 'Übernachtung 2 Nächte', 1),
    (1, 200, 2, 12.00, 0.00, 1, NOW(), 'Frühstück 2x', 2),
    (2, 100, 2, 35.00, 5.00, 1, NOW(), 'Übernachtung 2 Nächte', 1);

SELECT 'Testdaten erfolgreich eingefügt.' AS Status;

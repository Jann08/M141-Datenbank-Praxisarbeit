-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 04_dcl_berechtigungen.sql
-- Beschreibung: Benutzer und Berechtigungen gemäss Zugriffsmatrix
-- Ausführen als: root
-- ============================================================

-- ZUGRIFFSMATRIX:
-- Gruppe "Benutzer":
--   tbl_personen             → SELECT, UPDATE
--   tbl_benutzer (Passwort)  → KEIN Zugriff
--   tbl_benutzer (deaktiviert) → SELECT
--   tbl_benutzer (rest)      → SELECT, INSERT, UPDATE
--   tbl_buchung, tbl_positionen → SELECT, INSERT, UPDATE, DELETE
--   tbl_land, tbl_leistung   → SELECT
--
-- Gruppe "Management":
--   tbl_positionen, tbl_buchung → SELECT
--   restliche Tabellen          → SELECT, INSERT, UPDATE, DELETE

USE backpacker_lb3;

-- ------------------------------------------------------------
-- Benutzer anlegen (Passwörter anpassen!)
-- ------------------------------------------------------------

-- Benutzer-Gruppe: normaler Mitarbeiter
CREATE USER IF NOT EXISTS 'bp_benutzer'@'localhost' IDENTIFIED BY 'Benutzer@Sicher123!';
CREATE USER IF NOT EXISTS 'bp_benutzer'@'%'         IDENTIFIED BY 'Benutzer@Sicher123!';

-- Management-Gruppe: Führungsperson
CREATE USER IF NOT EXISTS 'bp_management'@'localhost' IDENTIFIED BY 'Management@Sicher456!';
CREATE USER IF NOT EXISTS 'bp_management'@'%'         IDENTIFIED BY 'Management@Sicher456!';

-- Read-Only Monitoring (optional, für Demo)
CREATE USER IF NOT EXISTS 'bp_readonly'@'localhost' IDENTIFIED BY 'Readonly@Sicher789!';

-- ------------------------------------------------------------
-- Berechtigungen: Gruppe "Benutzer"
-- ------------------------------------------------------------

-- tbl_personen: SELECT, UPDATE (kein INSERT, kein DELETE)
GRANT SELECT, UPDATE ON backpacker_lb3.tbl_personen TO 'bp_benutzer'@'localhost';
GRANT SELECT, UPDATE ON backpacker_lb3.tbl_personen TO 'bp_benutzer'@'%';

-- tbl_benutzer: nur bestimmte Spalten
-- deaktiviert: nur SELECT
-- restliche Attribute (ohne Password): SELECT, INSERT, UPDATE
GRANT SELECT (Benutzer_ID, Benutzername, Vorname, Name, Benutzergruppe, erfasst, deaktiviert, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'localhost';
GRANT INSERT (Benutzername, Vorname, Name, Benutzergruppe, erfasst, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'localhost';
GRANT UPDATE (Benutzername, Vorname, Name, Benutzergruppe, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'localhost';
GRANT SELECT (Benutzer_ID, Benutzername, Vorname, Name, Benutzergruppe, erfasst, deaktiviert, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'%';
GRANT INSERT (Benutzername, Vorname, Name, Benutzergruppe, erfasst, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'%';
GRANT UPDATE (Benutzername, Vorname, Name, Benutzergruppe, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'%';

-- tbl_buchung, tbl_positionen: Vollzugriff (S/I/U/D)
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_buchung    TO 'bp_benutzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_positionen TO 'bp_benutzer'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_buchung    TO 'bp_benutzer'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_positionen TO 'bp_benutzer'@'%';

-- tbl_land, tbl_leistung: nur SELECT
GRANT SELECT ON backpacker_lb3.tbl_land     TO 'bp_benutzer'@'localhost';
GRANT SELECT ON backpacker_lb3.tbl_leistung TO 'bp_benutzer'@'localhost';
GRANT SELECT ON backpacker_lb3.tbl_land     TO 'bp_benutzer'@'%';
GRANT SELECT ON backpacker_lb3.tbl_leistung TO 'bp_benutzer'@'%';

-- ------------------------------------------------------------
-- Berechtigungen: Gruppe "Management"
-- ------------------------------------------------------------

-- tbl_buchung, tbl_positionen: nur SELECT
GRANT SELECT ON backpacker_lb3.tbl_buchung    TO 'bp_management'@'localhost';
GRANT SELECT ON backpacker_lb3.tbl_positionen TO 'bp_management'@'localhost';
GRANT SELECT ON backpacker_lb3.tbl_buchung    TO 'bp_management'@'%';
GRANT SELECT ON backpacker_lb3.tbl_positionen TO 'bp_management'@'%';

-- restliche Tabellen: Vollzugriff (S/I/U/D)
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_personen  TO 'bp_management'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_benutzer  TO 'bp_management'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_land      TO 'bp_management'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_leistung  TO 'bp_management'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_personen  TO 'bp_management'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_benutzer  TO 'bp_management'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_land      TO 'bp_management'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_leistung  TO 'bp_management'@'%';

-- ------------------------------------------------------------
-- Read-Only (Monitoring / LP-Demo)
-- ------------------------------------------------------------
GRANT SELECT ON backpacker_lb3.* TO 'bp_readonly'@'localhost';

-- ------------------------------------------------------------
FLUSH PRIVILEGES;

SELECT 'Berechtigungen erfolgreich gesetzt.' AS Status;

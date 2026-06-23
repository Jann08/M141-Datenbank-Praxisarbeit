-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 02_cloud_dcl.sql
-- Beschreibung: Benutzer und Berechtigungen auf Cloud-DBMS
-- Anpassen: Passwörter und Host-Einträge vor Ausführung prüfen!
-- Ausführen als: Cloud-Admin-User
-- ============================================================

-- ANNAHME: Cloud-Host ist z.B. RDS-Endpoint oder EC2-IP
-- '%' erlaubt Verbindung von aussen (in Prod einschränken!)

CREATE USER IF NOT EXISTS 'bp_benutzer'@'%'   IDENTIFIED BY 'Benutzer@Cloud123!';
CREATE USER IF NOT EXISTS 'bp_management'@'%' IDENTIFIED BY 'Management@Cloud456!';
CREATE USER IF NOT EXISTS 'bp_readonly'@'%'   IDENTIFIED BY 'Readonly@Cloud789!';

-- Berechtigungen (identisch zur lokalen Konfiguration)
-- Benutzer-Gruppe
GRANT SELECT, UPDATE                          ON backpacker_lb3.tbl_personen  TO 'bp_benutzer'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE          ON backpacker_lb3.tbl_buchung   TO 'bp_benutzer'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE          ON backpacker_lb3.tbl_positionen TO 'bp_benutzer'@'%';
GRANT SELECT                                  ON backpacker_lb3.tbl_land      TO 'bp_benutzer'@'%';
GRANT SELECT                                  ON backpacker_lb3.tbl_leistung  TO 'bp_benutzer'@'%';
GRANT SELECT (Benutzer_ID, Benutzername, Vorname, Name, Benutzergruppe, erfasst, deaktiviert, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'%';
GRANT INSERT (Benutzername, Vorname, Name, Benutzergruppe, erfasst, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'%';
GRANT UPDATE (Benutzername, Vorname, Name, Benutzergruppe, aktiv)
    ON backpacker_lb3.tbl_benutzer TO 'bp_benutzer'@'%';

-- Management-Gruppe
GRANT SELECT ON backpacker_lb3.tbl_buchung    TO 'bp_management'@'%';
GRANT SELECT ON backpacker_lb3.tbl_positionen TO 'bp_management'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_personen  TO 'bp_management'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_benutzer  TO 'bp_management'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_land      TO 'bp_management'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON backpacker_lb3.tbl_leistung  TO 'bp_management'@'%';

-- Read-Only
GRANT SELECT ON backpacker_lb3.* TO 'bp_readonly'@'%';

FLUSH PRIVILEGES;

SELECT 'Cloud-Berechtigungen gesetzt.' AS Status;

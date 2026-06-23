-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 06_drop.sql
-- Beschreibung: Alles löschen (Reset / Neustart)
-- ACHTUNG: Alle Daten werden unwiderruflich gelöscht!
-- Ausführen als: root
-- ============================================================

DROP DATABASE IF EXISTS backpacker_lb3;

DROP USER IF EXISTS 'bp_benutzer'@'localhost';
DROP USER IF EXISTS 'bp_benutzer'@'%';
DROP USER IF EXISTS 'bp_management'@'localhost';
DROP USER IF EXISTS 'bp_management'@'%';
DROP USER IF EXISTS 'bp_readonly'@'localhost';

FLUSH PRIVILEGES;

SELECT 'Datenbank und Benutzer vollständig gelöscht.' AS Status;

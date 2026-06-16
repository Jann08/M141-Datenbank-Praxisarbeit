-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 01_cloud_setup.sql
-- Beschreibung: Cloud-DBMS einrichten (z.B. AWS MariaDB)
-- Ausführen als: Cloud-Admin-User
-- ============================================================

-- Datenbank auf Cloud anlegen
CREATE DATABASE IF NOT EXISTS backpacker_lb3
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE backpacker_lb3;

-- Hinweis: Tabellen werden via Migration importiert (06_drop → Import Dump)
-- Siehe: migration/02_import_cloud.sql

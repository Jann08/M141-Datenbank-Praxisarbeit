# Arbeitsprotokoll – M141 Praxisarbeit Backpacker_LB3

**Team**: Jann, Rocco, Janis  
**Modul**: M141 – Datenbanksysteme in Betrieb nehmen

---

## Protokoll

| Datum | Person | Arbeitspaket | MS | Dauer | Beschreibung |
|---|---|---|---|---|---|
| 2026-06-23 | Jann | MS A | A | 1.5h | Anforderungsdefinition (SMART), Cloud-Evaluation AWS RDS vs Azure, GitHub-Repo erstellt |
| 2026-06-23 | Jann | 1.1 | B | 1.0h | ERD 2NF erstellt (Textform + Mermaid-Diagramm), Beziehungen dokumentiert |
| 2026-06-23 | Rocco | 1.2 | B | 0.5h | Zugriffsmatrix dokumentiert und auf Vollständigkeit geprüft |
| 2026-06-23 | Jann | 1.3 | B | 1.0h | DCL-Skript erstellt (04_dcl_berechtigungen.sql), Spalten-Berechtigungen für tbl_benutzer implementiert |
| 2026-06-23 | Jann | 1.4 | B | 2.0h | CSV-Analyse: 441 FK-Fehler, 19 Datumsfehler, 8 Access-Dummydaten gefunden. Import-Skript (07) und Bereinigungsskript (08) erstellt |
| 2026-06-23 | Rocco | 1.4 | B | 1.0h | CSV-Import durchgeführt, Bereinigung ausgeführt (08_bereinigung.sql), mysqldump-Backup erstellt |
| 2026-06-23 | Rocco | 1.5 | B | 1.0h | Berechtigungstests und Konsistenztests lokal ausgeführt (test_berechtigungen.sql, test_datenkonsistenz.sql), Testprotokoll_Lokal ausgefüllt |
| 2026-06-23 | Janis | 2.1 | C | 1.5h | AWS RDS Instanz erstellt (db.t3.micro, MariaDB 10.11, eu-north-1), Public-Access konfiguriert |
| 2026-06-23 | Janis | 2.2 | C | 0.5h | Security Group eingerichtet (Port 3306), Verbindung getestet, my_cloud.cnf dokumentiert |
| 2026-06-23 | Jann | 3.1 | D | 0.5h | Cloud-Berechtigungen via 02_cloud_dcl.sql eingerichtet (bp_benutzer, bp_management, bp_readonly) |
| 2026-06-23 | Janis | 3.2 | D | 0.5h | Struktur und Daten via mysqldump auf Cloud migriert (4885 Datensätze) |
| 2026-06-23 | Rocco | 3.3 | D | 1.0h | Migrationstests durchgeführt (T30–T34), Testprotokoll_Cloud ausgefüllt |
| 2026-06-23 | Jann | Demo | D | 1.0h | Demo-Vorbereitung: 3 User auf Cloud getestet, LP-Testskript (test_demo_lp.sql) durchgespielt |

---

## Zeitübersicht

| Person | Geplant | Tatsächlich |
|---|---|---|
| Jann | 9–12 h | 6.0h |
| Rocco | 9–12 h | 3.5h |
| Janis | 9–12 h | 2.5h |

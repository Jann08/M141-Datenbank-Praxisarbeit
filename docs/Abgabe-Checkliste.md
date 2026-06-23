# Abgabe-Checkliste – M141 Praxisarbeit Backpacker_LB3

**Stand**: 2026-06-23  
**Max. Punkte**: 40 | **Note** = Punkte × 4 / 40 + 2

---

## MS A – Anforderungsdefinition (Tag 8) — 4 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | Anforderungsdefinition SMART ausformuliert | docs/Projektübersicht.md |
| ✅ | Cloud-DBMS evaluiert (AWS RDS vs Azure) | docs/Projektübersicht.md |
| ✅ | Entscheidung begründet (AWS RDS for MariaDB) | docs/Projektübersicht.md |
| ✅ | GitHub-Repo-Link vorhanden | README.md |
| ✅ | Team-Namen eingetragen (Jann, Rocco, Janis) | alle Dokumente |

---

## MS B – Lokales DBMS (Tag 9) — 13 Punkte

### 1.1 ERD 2NF

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | ERD in 2. Normalform vorhanden | diagrams/ERD_backpacker_lb3.md (Mermaid, GitHub-gerendert) |
| ✅ | Alle Tabellen, PK/FK, Kardinalitäten | diagrams/ERD_backpacker_lb3.md |

### 1.2 Zugriffsmatrix

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | Zugriffsmatrix dokumentiert | docs/Datenbankkonzept.md |
| ✅ | Vollständig (alle Tabellen/Spalten inkl. Password) | docs/Datenbankkonzept.md |

### 1.3 Zugriffsberechtigungen — 3 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | DCL-Skript vorhanden | sql/local/04_dcl_berechtigungen.sql |
| ✅ | Mindestens 1 User pro Gruppe | bp_benutzer, bp_management, bp_readonly |
| ✅ | Spalten-Berechtigungen tbl_benutzer.Password | sql/local/04_dcl_berechtigungen.sql |
| ✅ | Auf DB ausgeführt (Screenshot) | docs/screenshots/01_lokal_verbindung.png |

### 1.4 Daten importieren & bereinigen — 6 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | CSV-Import durchgeführt | sql/local/07_import_csv.sql |
| ✅ | FK-Probleme identifiziert (441 Datensätze) | docs/Datenbankkonzept.md |
| ✅ | Bereinigung durchgeführt | sql/local/08_bereinigung.sql |
| ✅ | InnoDB, utf8mb4 gesetzt | sql/local/02_create_tables.sql |
| ✅ | DB-Dump erstellt | backup/backpacker_lb3_2026-06-23.sql |
| ✅ | Datenbankkonzept mit Bereinigungstabelle | docs/Datenbankkonzept.md |

### 1.5 Tests lokal — 3+1 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | Testprotokoll lokal ausgefüllt (echte Ergebnisse) | tests/Testprotokoll_Lokal.md |
| ✅ | test_berechtigungen.sql ausgeführt | tests/Testprotokoll_Lokal.md |
| ✅ | test_datenkonsistenz.sql ausgeführt | tests/Testprotokoll_Lokal.md |
| ✅ | Positiv- UND Negativtests (12/12 bestanden) | tests/Testprotokoll_Lokal.md |

---

## MS C – Cloud-DBMS (Tag 10) — 6 Punkte

### 2.1 Cloud-DBMS Setup — 3 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | AWS RDS Instanz erstellt (db.t3.micro, eu-north-1) | tests/Testprotokoll_Cloud.md |
| ✅ | MariaDB-Version dokumentiert (11.8.6-MariaDB-log) | tests/Testprotokoll_Cloud.md |
| ✅ | Verbindung nachgewiesen (Screenshot) | docs/screenshots/02_cloud_verbindung.png |

### 2.2 Cloud gesichert — 3 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | Security Group konfiguriert (Port 3306) | docs/Sicherheitskonzept.md |
| ✅ | my_cloud.cnf Parameter dokumentiert | config/my_cloud.cnf + docs/Datenbankkonzept.md |
| ✅ | Netzwerksicherheit beschrieben | docs/Sicherheitskonzept.md |

---

## MS D – Migration (Tag 10) — 8 Punkte + Demo 4 Punkte

### 3.1 Berechtigungen migriert — 2 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | Cloud-DCL-Skript ausgeführt | sql/cloud/02_cloud_dcl.sql |
| ✅ | Alle 3 User auf Cloud vorhanden | tests/Testprotokoll_Cloud.md (T33) |

### 3.2 Daten migriert — 2 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | mysqldump lokal erstellt (848 KB) | backup/backpacker_lb3_2026-06-23.sql |
| ✅ | Import auf Cloud durchgeführt (4885 Datensätze) | tests/Testprotokoll_Cloud.md (T30) |
| ✅ | Migrationsskripte dokumentiert | sql/migration/ |

### 3.3 Migrationstests — 4 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | Testprotokoll Cloud ausgefüllt (echte Ergebnisse) | tests/Testprotokoll_Cloud.md |
| ✅ | Datensatzanzahl lokal = Cloud (alle 6 Tabellen) | tests/Testprotokoll_Cloud.md (T30) |
| ✅ | InnoDB + utf8mb4 auf Cloud | tests/Testprotokoll_Cloud.md (T31) |
| ✅ | FK-Constraints auf Cloud (5/5) | tests/Testprotokoll_Cloud.md (T32) |
| ✅ | Berechtigungen auf Cloud getestet inkl. ERROR 1143 | tests/Testprotokoll_Cloud.md (T34) |

### Demo — 4 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | 3 User auf Cloud-DBMS eingerichtet | sql/cloud/02_cloud_dcl.sql |
| ✅ | Zugriffsmatrix live demonstrierbar | tests/test_demo_lp.sql |
| ✅ | Demo-Ablauf dokumentiert | docs/Demo-Ablauf.md |
| ✅ | Negativtest PASSWORD (ERROR 1143) | docs/screenshots/03_negativtest_password.png |

---

## Dokumentation & Protokollierung — 4+1+1 Punkte

| Status | Anforderung | Nachweis |
|---|---|---|
| ✅ | Alle Meilensteine im Repo abgelegt | alle docs/ |
| ✅ | Arbeitsprotokoll vollständig | docs/Arbeitsprotokoll.md |
| ✅ | DB-Namen personalisiert (Screenshots) | docs/screenshots/ |
| ✅ | Markdown-Dokumentation vollständig | docs/ |
| ✅ | DB-Dump im Repo | backup/backpacker_lb3_2026-06-23.sql |
| ✅ | my.cnf / my_cloud.cnf abgegeben | config/ |

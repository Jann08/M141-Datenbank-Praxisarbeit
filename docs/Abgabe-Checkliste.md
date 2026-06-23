# Abgabe-Checkliste – M141 Praxisarbeit Backpacker_LB3

**Stand**: 2026-06-23  
**Max. Punkte**: 40 | **Note** = Punkte × 4 / 40 + 2

---

## MS A – Anforderungsdefinition (Tag 8) — 4 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | Anforderungsdefinition SMART ausformuliert | ✅ docs/Projektübersicht.md |
| ☐ | Cloud-DBMS evaluiert (mindestens 2 Optionen verglichen) | ✅ docs/Projektübersicht.md |
| ☐ | Entscheidung begründet (AWS RDS for MariaDB) | ✅ docs/Projektübersicht.md |
| ☐ | GitHub-Repo-Link vorhanden | ✅ README.md |
| ☐ | Team-Namen eingetragen | ⚠️ Platzhalter ersetzen! |
| ☐ | Termingerecht abgegeben (+1 Punkt) | ⬜ |

---

## MS B – Lokales DBMS (Tag 9) — 13 Punkte

### 1.1 ERD 2NF

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | ERD in 2. Normalform vorhanden | ✅ diagrams/ERD_backpacker_lb3.md (Mermaid) |
| ☐ | Grafisches ERD (draw.io / Screenshot) | ⚠️ Screenshot noch einfügen! |
| ☐ | Alle Tabellen, PK/FK, Kardinalitäten | ✅ |

### 1.2 Zugriffsmatrix

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | Zugriffsmatrix dokumentiert | ✅ docs/Datenbankkonzept.md |
| ☐ | Vollständig (alle Tabellen/Spalten) | ✅ |

### 1.3 Zugriffsberechtigungen — 3 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | DCL-Skript vorhanden | ✅ sql/local/04_dcl_berechtigungen.sql |
| ☐ | Mindestens 1 User pro Gruppe (Benutzer + Management) | ✅ bp_benutzer, bp_management |
| ☐ | Spalten-Berechtigungen für tbl_benutzer.Password | ✅ implementiert |
| ☐ | Auf DB ausgeführt (Screenshot) | ⚠️ Screenshot einfügen! |

### 1.4 Daten importieren & bereinigen — 6 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | CSV-Import durchgeführt (07_import_csv.sql) | ⚠️ Noch ausführen! |
| ☐ | FK-Probleme identifiziert (441 Datensätze) | ✅ docs/Datenbankkonzept.md |
| ☐ | Bereinigung durchgeführt (08_bereinigung.sql) | ⚠️ Noch ausführen! |
| ☐ | InnoDB, utf8mb4 gesetzt | ✅ sql/local/02_create_tables.sql |
| ☐ | DB-Dump erstellt (backup/) | ⚠️ Nach Import erstellen! |
| ☐ | Datenbankkonzept mit Bereinigungstabelle | ✅ docs/Datenbankkonzept.md |

### 1.5 Tests lokal — 3+1 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | Testprotokoll lokal ausgefüllt | ⚠️ Resultate eintragen! |
| ☐ | Test_berechtigungen.sql ausgeführt | ⚠️ Noch ausführen! |
| ☐ | Test_datenkonsistenz.sql ausgeführt | ⚠️ Noch ausführen! |
| ☐ | Positiv- UND Negativtests | ✅ beide im Skript |
| ☐ | Termingerecht abgegeben (+1 Punkt) | ⬜ |

---

## MS C – Cloud-DBMS (Tag 10) — 6 Punkte

### 2.1 Cloud-DBMS Setup — 3 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ✅ | AWS RDS Instanz erstellt | ✅ docs/Projektübersicht.md + Testprotokoll_Cloud |
| ☐ | MariaDB-Version dokumentiert | ⚠️ Nach Setup eintragen |
| ☐ | Screenshot RDS-Konsole (personalisiert) | ⚠️ Screenshot einfügen! |

### 2.2 Cloud gesichert — 3 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ✅ | Security Group konfiguriert (Port 3306 eingeschränkt) | ✅ erledigt |
| ☐ | TLS/SSL erzwungen (require_secure_transport) | ⚠️ Noch erledigen! |
| ☐ | my_cloud.cnf Parameter erklärt | ✅ config/my_cloud.cnf + docs/Datenbankkonzept.md |
| ☐ | Screenshot Cloud-Konfiguration | ⚠️ Screenshot einfügen! |

---

## MS D – Migration (Tag 10) — 8 Punkte + Demo 4 Punkte

### 3.1 Berechtigungen migriert — 2 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | Cloud-DCL-Skript ausgeführt (02_cloud_dcl.sql) | ⚠️ Noch ausführen! |
| ☐ | Alle User auf Cloud vorhanden | ⚠️ Prüfen nach Setup |

### 3.2 Daten migriert — 2 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ✅ | mysqldump lokal erstellt | ✅ backup/backpacker_lb3_2026-06-23.sql |
| ✅ | Import auf Cloud durchgeführt | ✅ 4885 Datensätze migriert |
| ☐ | Migrationsskript dokumentiert | ✅ sql/migration/ |

### 3.3 Migrationstests — 4 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ✅ | Testprotokoll Cloud ausgefüllt | ✅ echte Ergebnisse eingetragen |
| ☐ | test_migration.sql auf Cloud ausgeführt | ⚠️ Noch ausführen! |
| ☐ | Datensatzanzahl lokal = Cloud | ⚠️ Prüfen |
| ☐ | Berechtigungen auf Cloud getestet | ⚠️ Prüfen |

### Demo — 4 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | 3 User auf Cloud-DBMS live verbunden | ⚠️ Vorbereiten! |
| ☐ | Zugriffsmatrix live demonstrierbar | ✅ test_demo_lp.sql bereit |
| ☐ | LP-Testskript (test_demo_lp.sql) vorbereitet | ✅ |
| ☐ | Dauer 10–15 Min geplant | ⬜ |

---

## Dokumentation & Protokollierung — 4+1+1 Punkte

| Punkt | Anforderung | Status |
|---|---|---|
| ☐ | Alle Meilensteine im Repo abgelegt | ✅ |
| ☐ | Arbeitsprotokoll vollständig | ✅ Alle Einträge vollständig (Jann/Rocco/Janis) |
| ☐ | DB-Namen personalisiert (Screenshots) | ✅ Screenshots in docs/screenshots/ |
| ☐ | Markdown-Dokumentation vollständig | ✅ |
| ☐ | DB-Dump im Repo (backup/) | ✅ backup/backpacker_lb3_2026-06-23.sql |
| ☐ | my.cnf / my_cloud.cnf abgegeben | ✅ config/ |
| ☐ | Termingerecht abgegeben (+1 Punkt) | ⬜ |
| ☐ | Früher abgegeben (+1 Bonus) | ⬜ |

---

## Vor der Demo – letzte Checkliste

- [ ] MariaDB lokal läuft (XAMPP gestartet)
- [ ] Cloud-DBMS erreichbar (Endpoint + Port 3306)
- [ ] 3 Benutzer einloggen können (Passwörter parat)
- [ ] test_demo_lp.sql auf Cloud getestet
- [ ] Negativtests (auskommentiert) bereit zum Zeigen
- [ ] Screenshots vorhanden und personalisiert
- [ ] GitHub-Repo auf neuestem Stand (git push)
- [ ] Backup-Datei im backup/-Ordner

---

## Noch zu erledigen (Zusammenfassung offener Punkte)

1. **Jetzt**: MariaDB-Root-Passwort → CSV-Import + Bereinigung ausführen
2. **Jetzt**: Team-Namen in alle Docs eintragen (Suchen: `Jann`, `Rocco`, `Janis`)
3. **Jetzt**: Grafisches ERD in draw.io/dbdiagram.io erstellen + Screenshot einfügen
4. **Tag 9**: AWS RDS Instanz aufsetzen + Security Group konfigurieren
5. **Tag 9**: mysqldump lokal → Import auf Cloud → test_migration.sql
6. **Tag 9**: Alle Testprotokolle mit echten Ergebnissen ausfüllen
7. **Tag 9**: DB-Dump in backup/ ablegen + pushen
8. **Tag 10**: Demo vorbereiten (3 User live auf Cloud)

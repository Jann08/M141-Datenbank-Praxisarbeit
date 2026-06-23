# M141 Praxisarbeit – Backpacker_LB3 Migration

**Modul**: M141 – Datenbanksysteme in Betrieb nehmen  
**Schule**: TBZ Zürich  
**Team**: 3 Lernende EFZ Plattformentwicklung  
**Version**: 1.0 | Stand: 2026

---

## Projektbeschreibung

Eine Jugendherberge (Backpacker) verwaltet ihre Übernachtungsdaten und Mitarbeiterzugänge in einer veralteten Access-Datenbank. Diese wird auf ein modernes MySQL/MariaDB-System migriert.

**Aufgabe**: Die bestehende Datenbank `backpacker_lb3` wird:
1. lokal in MariaDB (XAMPP) bereinigt und optimiert
2. auf ein gesichertes Cloud-DBMS (z.B. MariaDB auf AWS) migriert
3. vollständig getestet und dokumentiert

---

## Technologien

| Technologie | Einsatz |
|---|---|
| MariaDB / MySQL | Lokales DBMS (XAMPP) |
| MariaDB (AWS/Cloud) | Produktives Cloud-DBMS |
| SQL (DDL, DML, DCL, DQL) | Datenbankskripte |
| Markdown | Dokumentation |
| Git / GitLab | Versionsverwaltung |

---

## Projektziel

- Migration der Backpacker-Datenbank von Access auf MariaDB/MySQL
- Bereinigung der Daten (FK, Index, Constraints)
- Korrekte Zugriffsberechtigungen gemäss Zugriffsmatrix
- Gesicherter Cloud-Betrieb
- Vollständige, nachvollziehbare Dokumentation und Testprotokolle

---

## Meilensteine

| MS | Inhalt | Abgabe |
|---|---|---|
| **MS A** | Anforderungsdefinition, Cloud-Evaluation, GitLab-Link | Tag 8 |
| **MS B** | Lokales DBMS: ERD, Berechtigungen, Datenimport, Tests | Tag 9 |
| **MS C** | Cloud-DBMS: Setup, Konfiguration, Sicherheit | Tag 10 |
| **MS D** | Migration: Daten + Berechtigungen + Tests + Demo | Tag 10 |

---

## Projektstruktur

```
M141-Datenbank-Praxisarbeit/
│
├── README.md                   # Diese Datei
│
├── docs/                       # Dokumentation
│   ├── Projektübersicht.md
│   ├── Datenbankkonzept.md
│   ├── Testkonzept.md
│   ├── Sicherheitskonzept.md
│   └── Arbeitsprotokoll.md
│
├── sql/
│   ├── local/                  # Skripte für lokales DBMS
│   │   ├── 01_create_database.sql
│   │   ├── 02_create_tables.sql
│   │   ├── 03_constraints_fk.sql
│   │   ├── 04_dcl_berechtigungen.sql
│   │   ├── 05_testdata.sql
│   │   └── 06_drop.sql
│   ├── cloud/                  # Skripte für Cloud-DBMS
│   │   ├── 01_cloud_setup.sql
│   │   └── 02_cloud_dcl.sql
│   └── migration/              # Migrationsskripte
│       ├── 01_export_local.sql
│       └── 02_import_cloud.sql
│
├── tests/                      # Testprotokolle und Testskripte
│   ├── test_berechtigungen.sql
│   ├── test_datenkonsistenz.sql
│   ├── test_migration.sql
│   ├── Testprotokoll_Lokal.md
│   └── Testprotokoll_Cloud.md
│
├── config/                     # Konfigurationsdateien
│   ├── my.cnf                  # MariaDB Konfiguration (lokal)
│   └── my_cloud.cnf            # MariaDB Konfiguration (Cloud/Prod)
│
├── diagrams/                   # ERD und Datenbankmodelle
│   └── ERD_backpacker_lb3.md
│
├── backup/                     # DB-Dumps und Backups
│   └── .gitkeep
│
└── Requerments/                # Originalaufgabenstellung (gegeben)
```

---

## Setup & Installation

### Voraussetzungen
- XAMPP mit MariaDB (lokal)
- MySQL-Client oder phpMyAdmin
- Git

### Lokale Datenbank einrichten

```bash
# 1. Repository klonen
git clone <repo-url>
cd M141-Datenbank-Praxisarbeit

# 2. MariaDB starten (XAMPP)
# XAMPP Control Panel → MySQL → Start

# 3. Datenbank erstellen
mysql -u root -p < sql/local/01_create_database.sql

# 4. Tabellen erstellen
mysql -u root -p backpacker_lb3 < sql/local/02_create_tables.sql

# 5. FK und Constraints setzen
mysql -u root -p backpacker_lb3 < sql/local/03_constraints_fk.sql

# 6. Berechtigungen setzen
mysql -u root -p < sql/local/04_dcl_berechtigungen.sql

# 7. CSV-Daten importieren (via phpMyAdmin oder mysql CLI)
```

### Datenbank zurücksetzen

```bash
mysql -u root -p < sql/local/06_drop.sql
```

---

## SQL-Skripte Übersicht

| Datei | Beschreibung |
|---|---|
| `sql/local/01_create_database.sql` | Datenbank anlegen |
| `sql/local/02_create_tables.sql` | Tabellen mit InnoDB + UTF8 |
| `sql/local/03_constraints_fk.sql` | Fremdschlüssel und Constraints |
| `sql/local/04_dcl_berechtigungen.sql` | User und Rollen (Benutzer, Management) |
| `sql/local/05_testdata.sql` | Testdaten für Migrationstests |
| `sql/local/06_drop.sql` | Alles löschen (Reset) |

---

## Tests

Testprotokolle befinden sich in `/tests/`:
- **Testprotokoll_Lokal.md**: Tests auf lokalem DBMS
- **Testprotokoll_Cloud.md**: Tests nach Migration auf Cloud

Testskripte als SQL:
- `test_berechtigungen.sql`: Rollentests gemäss Zugriffsmatrix
- `test_datenkonsistenz.sql`: FK-Integrität, Datenqualität
- `test_migration.sql`: Vergleich lokal vs. Cloud

---

## Dokumentation

Alle Dokumente unter `/docs/`.

---

## Zugriffsmatrix (Zusammenfassung)

| Tabelle | Benutzer (S/I/U/D) | Management (S/I/U/D) |
|---|---|---|
| tbl_personen | S, U | S, I, U, D |
| tbl_benutzer (ohne Passwort) | S (deaktiviert), S/I/U (rest) | S, I, U, D |
| tbl_buchung, tbl_positionen | S, I, U, D | S |
| tbl_land, tbl_leistung | S | S, I, U, D |

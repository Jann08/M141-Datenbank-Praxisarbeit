# M141 Praxisarbeit – Backpacker_LB3 Migration

**Modul**: M141 – Datenbanksysteme in Betrieb nehmen  
**Schule**: TBZ Zürich  
**Team**: Jann, Rocco, Janis  
**Version**: 1.0 | Stand: 2026-06-30

---

## Projektbeschreibung

Eine Jugendherberge (Backpacker) verwaltet ihre Übernachtungsdaten und Mitarbeiterzugänge in einer veralteten Access-Datenbank. Diese wird auf ein modernes MariaDB-System migriert.

**Aufgabe**: Die bestehende Datenbank `backpacker_lb3` wird:
1. lokal in MariaDB bereinigt und optimiert
2. auf ein gesichertes Cloud-DBMS (AWS RDS for MariaDB) migriert
3. vollständig getestet und dokumentiert

---

## Technologien

| Technologie | Einsatz |
|---|---|
| MariaDB 12.2 (lokal) | Lokales DBMS |
| MariaDB 11.8 (AWS RDS) | Cloud-DBMS |
| SQL (DDL, DML, DCL, DQL) | Datenbankskripte |
| Markdown | Dokumentation |
| Git / GitHub | Versionsverwaltung |

---

## Projektziel

- Migration der Backpacker-Datenbank von Access auf MariaDB
- Bereinigung der Daten (FK, Constraints, Encoding)
- Korrekte Zugriffsberechtigungen gemäss Zugriffsmatrix
- Gesicherter Cloud-Betrieb auf AWS RDS
- Vollständige, nachvollziehbare Dokumentation und Testprotokolle

---

## Meilensteine

| MS | Inhalt | Abgabe | Status |
|---|---|---|---|
| **MS A** | Anforderungsdefinition, Cloud-Evaluation, Repo-Link | Tag 8 | ✅ |
| **MS B** | Lokales DBMS: ERD, Berechtigungen, Datenimport, Tests | Tag 9 | ✅ |
| **MS C** | Cloud-DBMS: Setup, Konfiguration, Sicherheit | Tag 10 | ✅ |
| **MS D** | Migration: Daten + Berechtigungen + Tests + Demo | Tag 10 | ✅ |

---

## Projektstruktur

```
M141-Datenbank-Praxisarbeit/
│
├── README.md
│
├── docs/
│   ├── Projektübersicht.md
│   ├── Datenbankkonzept.md
│   ├── Testkonzept.md
│   ├── Sicherheitskonzept.md
│   ├── Arbeitsprotokoll.md
│   ├── Demo-Ablauf.md
│   ├── Abgabe-Checkliste.md
│   └── screenshots/
│       ├── 01_lokal_verbindung.png
│       ├── 02_cloud_verbindung.png
│       └── 03_negativtest_password.png
│
├── sql/
│   ├── local/
│   │   ├── 01_create_database.sql
│   │   ├── 02_create_tables.sql
│   │   ├── 03_constraints_fk.sql
│   │   ├── 04_dcl_berechtigungen.sql
│   │   ├── 05_testdata.sql
│   │   ├── 06_drop.sql
│   │   ├── 07_import_csv.sql
│   │   └── 08_bereinigung.sql
│   ├── cloud/
│   │   ├── 01_cloud_setup.sql
│   │   └── 02_cloud_dcl.sql
│   └── migration/
│       ├── 01_export_local.sql
│       └── 02_import_cloud.sql
│
├── tests/
│   ├── test_berechtigungen.sql
│   ├── test_datenkonsistenz.sql
│   ├── test_migration.sql
│   ├── test_demo_lp.sql
│   ├── Testprotokoll_Lokal.md
│   └── Testprotokoll_Cloud.md
│
├── config/
│   ├── my.cnf
│   └── my_cloud.cnf
│
├── diagrams/
│   └── ERD_backpacker_lb3.md
│
├── backup/
│   └── backpacker_lb3_2026-06-23.sql
│
└── Requerments/
```

---

## SQL-Skripte Übersicht

| Datei | Beschreibung |
|---|---|
| `sql/local/01_create_database.sql` | Datenbank anlegen |
| `sql/local/02_create_tables.sql` | Tabellen mit InnoDB + utf8mb4 |
| `sql/local/03_constraints_fk.sql` | Fremdschlüssel und CHECK-Constraints |
| `sql/local/04_dcl_berechtigungen.sql` | User und Berechtigungen (lokal) |
| `sql/local/07_import_csv.sql` | CSV-Datenimport (4885 Datensätze) |
| `sql/local/08_bereinigung.sql` | Datenbereinigung (FK, Datumslogik, SHA2) |
| `sql/cloud/02_cloud_dcl.sql` | User und Berechtigungen (Cloud) |
| `sql/migration/01_export_local.sql` | mysqldump lokal |
| `sql/migration/02_import_cloud.sql` | Import auf Cloud |

---

## Tests

| Datei | Beschreibung |
|---|---|
| `tests/test_berechtigungen.sql` | Rollentests gemäss Zugriffsmatrix |
| `tests/test_datenkonsistenz.sql` | FK-Integrität, Datenqualität |
| `tests/test_migration.sql` | Vergleich lokal vs. Cloud |
| `tests/test_demo_lp.sql` | Demo-Skript für Live-Präsentation |

Testprotokolle mit echten Ergebnissen: `tests/Testprotokoll_Lokal.md` und `tests/Testprotokoll_Cloud.md`

---

## Zugriffsmatrix (Zusammenfassung)

| Tabelle | bp_benutzer (S/I/U/D) | bp_management (S/I/U/D) |
|---|---|---|
| tbl_personen | S, U | S, I, U, D |
| tbl_benutzer – Password | kein Zugriff | S, I, U, D |
| tbl_benutzer – Rest | S, I, U | S, I, U, D |
| tbl_buchung, tbl_positionen | S, I, U, D | S |
| tbl_land, tbl_leistung | S | S, I, U, D |

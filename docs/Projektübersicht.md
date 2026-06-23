# Projektübersicht – M141 Praxisarbeit Backpacker_LB3

**Modul**: M141 – Datenbanksysteme in Betrieb nehmen  
**Schule**: TBZ Zürich  
**Autor/Team**: Jann, Rocco, Janis  
**Datum**: 2026-06-23

---

## Ausgangslage

Eine Jugendherberge (Backpacker) betreibt ihre Datenbank in Microsoft Access. Diese soll auf MariaDB/MySQL migriert werden. Die bestehende Struktur und Daten liegen als DDL-Skript (`backpacker_ddl_lb3.sql`) und CSV-Dateien vor. Die Datenbasis ist inkonsistent und muss bereinigt werden.

---

## Projektziel (SMART)

**Spezifisch**: Migration der Datenbank `backpacker_lb3` von Microsoft Access auf MariaDB – zuerst lokal (XAMPP) bereinigt und optimiert, danach auf ein gesichertes AWS-Cloud-DBMS (RDS for MariaDB) migriert. Zugriffsberechtigungen gemäss Zugriffsmatrix implementiert.

**Messbar**: Alle 4'881 Datensätze vollständig importiert, 441 FK-Fehler und 19 Datumsfehler bereinigt, Fremdschlüssel-Constraints gesetzt, Berechtigungen für 2 Gruppen korrekt implementiert, alle Migrationstests bestanden.

**Akzeptiert**: Abnahme durch Lehrperson (Kellenberger) mit 10–15 minütiger Live-Demo auf Cloud-DBMS mit 3 Benutzern.

**Realistisch**: Umsetzbar in 9–12 Lektionen plus Heimarbeit innerhalb von 2 Wochen.

**Terminiert**:
- MS A → Tag 8
- MS B → Tag 9
- MS C & D & Demo → Tag 10

---

## Meilensteine

| MS | Beschreibung | Abgabe | Status |
|---|---|---|---|
| MS A | Anforderungsdefinition, Cloud-Evaluation, Repo-Link | Tag 8 | ✅ |
| MS B | Lokales DBMS: ERD, Berechtigungen, Import, Bereinigung, Tests | Tag 9 | ✅ |
| MS C | Cloud-DBMS: Setup, Konfiguration, Absicherung | Tag 10 | ✅ |
| MS D | Migration automatisiert, Berechtigungen, Tests, Demo | Tag 10 | ✅ |

---

## Cloud-Evaluation (MS A)

### Verglichene Optionen: AWS RDS vs. Azure Database for MySQL

| Kriterium | AWS RDS for MariaDB | Azure Database for MySQL | Gewichtung |
|---|---|---|---|
| **MariaDB-Unterstützung** | Vollständig (10.6, 10.11) | Nur MySQL 5.7 / 8.0 – kein natives MariaDB | Hoch |
| **Preis (kleinste Instanz)** | ~0.016 USD/h (db.t3.micro, Free Tier verfügbar) | ~0.018 USD/h (Burstable B1ms) | Mittel |
| **Einfachheit Setup** | Gut (RDS-Wizard, viele Tutorials) | Gut (Azure Portal) | Mittel |
| **Backup** | Automatisch, bis 35 Tage, S3-Export möglich | Automatisch, bis 35 Tage | Mittel |
| **Sicherheit** | VPC, Security Groups, IAM, TLS erzwingbar | VNet, Firewall Rules, Azure AD, TLS | Hoch |
| **Dokumentation** | Sehr gut, viele Schulbeispiele verfügbar | Gut | Tief |
| **Free Tier** | 12 Monate (750 h/Monat db.t3.micro) | Begrenzte Credits, 12 Monate | Hoch |
| **Kompatibilität mit Aufgabe** | Direkte MariaDB-Unterstützung | MySQL-kompatibel, kein natives MariaDB | Entscheidend |

### Entscheidung: **AWS RDS for MariaDB**

**Begründung**: AWS RDS unterstützt MariaDB nativ – im Gegensatz zu Azure, das nur MySQL anbietet. Das Free-Tier ermöglicht kostenlosen Betrieb während der Projektdauer. Die Aufgabenstellung nennt AWS explizit als Beispiel, und die verfügbare Dokumentation eignet sich besser für Schulprojekte.

**Gewählte Instanz**: `db.t3.micro` – 2 vCPU, 1 GB RAM, MariaDB 10.11, Multi-AZ deaktiviert (Schulprojekt, kein HA erforderlich)

---

## Team & Rollen

| Name | Rolle | Verantwortlichkeit |
|---|---|---|
| Jann | Projektleiter / DB-Entwickler | Gesamtkoordination, SQL-Skripte, Cloud |
| Rocco | Tester / Dokumentation | Testprotokolle, Sicherheitskonzept |
| Janis | Migration / Cloud | Cloud-Setup, Migration, Demo |

---

## GitHub-Repository

**Link**: https://github.com/Jann08/M141-Datenbank-Praxisarbeit

---

## Verwendete Technologien

| Technologie | Einsatz |
|---|---|
| MariaDB 10.4 (XAMPP) | Lokales DBMS |
| AWS RDS for MariaDB 10.11 | Cloud-DBMS (produktiv) |
| SQL (DDL, DML, DCL, DQL) | Datenbankskripte |
| Markdown / GitHub | Dokumentation und Versionsverwaltung |

---


# Datenbankkonzept – Backpacker_LB3

**Dokument**: Datenbankkonzept  
**Version**: 1.0  
**Datum**: _________  
**Autor**: _________

---

## 1. Datenmodell

### 1.1 ERD (2. Normalform)

> _[Grafisches ERD hier einfügen – erstellt mit draw.io / dbdiagram.io]_  
> Textdarstellung: siehe `diagrams/ERD_backpacker_lb3.md`

### 1.2 Tabellen

| Tabelle | Beschreibung | Datensätze (ca.) |
|---|---|---|
| tbl_land | Ländercodes der Gäste | _________ |
| tbl_leistung | Serviceangebote / Leistungskategorien | _________ |
| tbl_personen | Gästedaten | _________ |
| tbl_benutzer | Mitarbeiter / Systembenutzer | _________ |
| tbl_buchung | Buchungskopf | _________ |
| tbl_positionen | Einzelne Buchungspositionen | _________ |

---

## 2. Zugriffsmatrix

| Tabelle / Attribut | Benutzer (S/I/U/D) | Management (S/I/U/D) |
|---|---|---|
| tbl_personen | S, U | S, I, U, D |
| tbl_benutzer – Password | — | S, I, U, D |
| tbl_benutzer – deaktiviert | S | S, I, U, D |
| tbl_benutzer – restliche | S, I, U | S, I, U, D |
| tbl_buchung | S, I, U, D | S |
| tbl_positionen | S, I, U, D | S |
| tbl_land | S | S, I, U, D |
| tbl_leistung | S | S, I, U, D |

---

## 3. Bereinigungsmassnahmen (MS B 1.4)

| Problem | Lösung | Skript |
|---|---|---|
| Engine MyISAM → InnoDB | ALTER TABLE ENGINE=InnoDB | 02_create_tables.sql |
| Charset latin1 → utf8mb4 | CONVERT TO CHARACTER SET utf8mb4 | 02_create_tables.sql |
| Fehlende FK-Constraints | FK explizit definiert | 02_create_tables.sql |
| Fehlender PK tbl_land | Land_ID als PRIMARY KEY | 02_create_tables.sql |
| deaktiviert DEFAULT '1000-01-01' | Auf NULL gesetzt | 02_create_tables.sql |
| _________ | _________ | _________ |

---

## 4. DB-Benutzer

| DB-Benutzer | Gruppe | Zweck |
|---|---|---|
| bp_benutzer | Benutzer | Normaler Mitarbeiter |
| bp_management | Management | Führungsperson |
| bp_readonly | Monitoring | LP-Demo / Read-Only |

---

## 5. Konfiguration (my.cnf)

> Wichtige Parameter und Begründung:

| Parameter | Wert | Begründung |
|---|---|---|
| character-set-server | utf8mb4 | Volle Unicode-Unterstützung |
| default-storage-engine | InnoDB | FK-Unterstützung |
| innodb_buffer_pool_size | 256M (Cloud) | Performance |
| require_secure_transport | ON (Cloud) | Verschlüsselte Verbindungen |
| slow_query_log | 1 | Optimierungspotenzial erkennen |

---

*KI-Prompts für dieses Dokument:*

> _[Prompts eintragen]_

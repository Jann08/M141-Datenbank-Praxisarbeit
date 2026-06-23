# Datenbankkonzept – Backpacker_LB3

**Dokument**: Datenbankkonzept  
**Version**: 1.1  
**Datum**: 2026-06-23  
**Autor**: Jann, Rocco, Janis

---

## 1. Datenmodell

### 1.1 ERD (2. Normalform)

Textdarstellung und Mermaid-Diagramm: siehe `diagrams/ERD_backpacker_lb3.md`

Mermaid-ERD (GitHub-gerendert): siehe [`diagrams/ERD_backpacker_lb3.md`](../diagrams/ERD_backpacker_lb3.md)

### 1.2 Tabellen und Datensätze

| Tabelle | Beschreibung | Datensätze (nach Import) |
|---|---|---|
| tbl_land | Ländercodes der Gäste | 83 |
| tbl_leistung | Serviceangebote / Leistungskategorien | 7 |
| tbl_personen | Gästedaten | 2'035 |
| tbl_benutzer | Mitarbeiter / Systembenutzer | 10 |
| tbl_buchung | Buchungskopf | 1'005 |
| tbl_positionen | Einzelne Buchungspositionen | 1'745 |
| **Total** | | **4'885** |

---

## 2. Zugriffsmatrix

| Tabelle / Attribut | Benutzer (S/I/U/D) | Management (S/I/U/D) |
|---|---|---|
| tbl_personen | S, U | S, I, U, D |
| tbl_benutzer – Password | — (kein Zugriff) | S, I, U, D |
| tbl_benutzer – deaktiviert | S | S, I, U, D |
| tbl_benutzer – restliche Attribute | S, I, U | S, I, U, D |
| tbl_buchung | S, I, U, D | S |
| tbl_positionen | S, I, U, D | S |
| tbl_land | S | S, I, U, D |
| tbl_leistung | S | S, I, U, D |

*S=Select, I=Insert, U=Update, D=Delete, —=kein Zugriff*

---

## 3. Bereinigungsmassnahmen nach CSV-Import (MS B 1.4)

Die CSV-Analyse ergab folgende Inkonsistenzen, die mit `08_bereinigung.sql` behoben werden:

| Problem | Anzahl betroffene Datensätze | Ursache | Lösung | Skript |
|---|---|---|---|---|
| MyISAM → InnoDB | alle 6 Tabellen | Access/phpMyAdmin-Export | ENGINE=InnoDB beim CREATE | 02_create_tables.sql |
| latin1 → utf8mb4 | alle Tabellen | Altes Access-Charset | CHARACTER SET latin1 beim Import | 07_import_csv.sql |
| Land_FS = 0 | 438 Buchungen | Access-Dummy für «unbekannt» | UPDATE SET Land_FS = NULL | 08_bereinigung.sql |
| Land_FS = 176 | 3 Buchungen | Nicht existierender Ländercode | UPDATE SET Land_FS = NULL | 08_bereinigung.sql |
| Abreise < Ankunft | 19 Buchungen | Fehlerhafte Eingabe in Access | UPDATE SET Abreise = NULL | 08_bereinigung.sql |
| deaktiviert = '1000-01-01' | 8 Benutzer | Access-Dummy für «aktiv» | UPDATE SET deaktiviert = NULL | 08_bereinigung.sql |
| Passwörter im Klartext | 11 Benutzer | Access-Export | UPDATE SET Password = SHA2(...) | 08_bereinigung.sql |
| Fehlender PK tbl_land | 1 Tabelle | Kein PRIMARY KEY im Original | Land_ID als PK definiert | 02_create_tables.sql |

---

## 4. Fremdschlüssel-Beziehungen

| FK-Constraint | Von | Zu | Typ |
|---|---|---|---|
| fk_buchung_personen | tbl_buchung.Personen_FS | tbl_personen.Personen_ID | N:1 |
| fk_buchung_land | tbl_buchung.Land_FS | tbl_land.Land_ID | N:1 |
| fk_positionen_buchung | tbl_positionen.Buchungs_FS | tbl_buchung.Buchungs_ID | N:1 |
| fk_positionen_leistung | tbl_positionen.Leistung_FS | tbl_leistung.LeistungID | N:1 |
| fk_positionen_benutzer | tbl_positionen.Benutzer_FS | tbl_benutzer.Benutzer_ID | N:1 |

---

## 5. DB-Benutzer

| DB-Benutzer | Gruppe | Zweck | Host |
|---|---|---|---|
| bp_benutzer | Benutzer | Normaler Mitarbeiter | localhost + % |
| bp_management | Management | Führungsperson | localhost + % |
| bp_readonly | Monitoring | LP-Demo / Read-Only | localhost |

---

## 6. Konfiguration (my.cnf)

| Parameter | Wert | Begründung |
|---|---|---|
| character-set-server | utf8mb4 | Volle Unicode-Unterstützung inkl. Emojis |
| collation-server | utf8mb4_unicode_ci | Sprachkorrekte Sortierung |
| default-storage-engine | InnoDB | FK-Unterstützung, ACID-Transaktionen |
| bind-address | 127.0.0.1 (lokal) | Kein Remote-Zugriff auf Entwicklungs-DB |
| slow_query_log | 1 | Optimierungspotenzial erkennen |
| general_log | 1 (lokal) | Debugging während Entwicklung |
| innodb_buffer_pool_size | 256M (Cloud) | Performance für Produktionsbetrieb |
| require_secure_transport | ON (Cloud) | TLS-Pflicht für verschlüsselte Verbindungen |

Vollständige Konfiguration: `config/my.cnf` (lokal) und `config/my_cloud.cnf` (Cloud/Prod)

---


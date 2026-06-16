# Testprotokoll – Cloud-DBMS nach Migration (MS C & D)

**Datenbank**: backpacker_lb3  
**DBMS**: MariaDB (Cloud / AWS)  
**Datum**: _________  
**Durchgeführt von**: _________

---

## 1. Testumgebung

| Parameter | Wert |
|---|---|
| DBMS | MariaDB (Cloud) |
| Version | _________ |
| Cloud-Anbieter | _________ (z.B. AWS RDS) |
| Host / Endpoint | _________ |
| Testskript | `tests/test_migration.sql`, `tests/test_berechtigungen.sql` |

---

## 2. Migrationsprüfung (Datensatzanzahl Vergleich)

| Tabelle | Lokal | Cloud | Identisch? |
|---|---|---|---|
| tbl_land | _________ | _________ | ☐ |
| tbl_leistung | _________ | _________ | ☐ |
| tbl_personen | _________ | _________ | ☐ |
| tbl_benutzer | _________ | _________ | ☐ |
| tbl_buchung | _________ | _________ | ☐ |
| tbl_positionen | _________ | _________ | ☐ |

---

## 3. Technische Prüfung Cloud

| Test-ID | Beschreibung | Erwartet | Ergebnis | OK? |
|---|---|---|---|---|
| T30 | Datensatzanzahl identisch | Ja | _________ | ☐ |
| T31 | Storage Engine = InnoDB | InnoDB | _________ | ☐ |
| T32 | FK-Constraints aktiv | Ja | _________ | ☐ |
| T33 | Benutzer vorhanden | 3 User | _________ | ☐ |

---

## 4. Tests Zugriffsberechtigungen (Cloud)

| Test-ID | Beschreibung | Benutzer | Erwartet | Ergebnis | OK? |
|---|---|---|---|---|---|
| T01 | SELECT tbl_personen | bp_benutzer | Erlaubt | _________ | ☐ |
| T04 | SELECT Password | bp_benutzer | Fehler | _________ | ☐ |
| T08 | SELECT tbl_buchung | bp_management | Erlaubt | _________ | ☐ |
| T09 | INSERT tbl_buchung | bp_management | Fehler | _________ | ☐ |

---

## 5. Demo-Vorbereitung (LP)

- [ ] 3 Benutzer auf Cloud-DBMS verbunden
- [ ] Zugriffsmatrix live demonstrierbar
- [ ] Testskript für LP vorbereitet

---

## 6. Fazit / Bemerkungen

_________________________________________________________________________

---

*KI-Prompts verwendet:*

> _[Hier verwendete KI-Prompts eintragen – Anforderung Urheberbeweis]_

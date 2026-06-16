# Testprotokoll – Lokales DBMS (MS B)

**Datenbank**: backpacker_lb3  
**DBMS**: MariaDB (XAMPP)  
**Datum**: _________  
**Durchgeführt von**: _________

---

## 1. Testumgebung

| Parameter | Wert |
|---|---|
| DBMS | MariaDB (XAMPP) |
| Version | _________ |
| Host | localhost |
| Testskript | `tests/test_berechtigungen.sql`, `tests/test_datenkonsistenz.sql` |

---

## 2. Tests Zugriffsberechtigungen (Zugriffsmatrix)

| Test-ID | Beschreibung | Benutzer | Erwartet | Ergebnis | OK? |
|---|---|---|---|---|---|
| T01 | SELECT tbl_personen | bp_benutzer | Erlaubt | _________ | ☐ |
| T02 | INSERT tbl_personen | bp_benutzer | Fehler (ACCESS DENIED) | _________ | ☐ |
| T03 | SELECT tbl_benutzer (ohne Password) | bp_benutzer | Erlaubt | _________ | ☐ |
| T04 | SELECT Password aus tbl_benutzer | bp_benutzer | Fehler (ACCESS DENIED) | _________ | ☐ |
| T05 | SELECT tbl_buchung | bp_benutzer | Erlaubt | _________ | ☐ |
| T06 | SELECT tbl_land | bp_benutzer | Erlaubt | _________ | ☐ |
| T07 | INSERT tbl_land | bp_benutzer | Fehler (ACCESS DENIED) | _________ | ☐ |
| T08 | SELECT tbl_buchung | bp_management | Erlaubt | _________ | ☐ |
| T09 | INSERT tbl_buchung | bp_management | Fehler (ACCESS DENIED) | _________ | ☐ |
| T10 | SELECT tbl_personen | bp_management | Erlaubt | _________ | ☐ |

---

## 3. Tests Datenkonsistenz (Import / Bereinigung)

| Test-ID | Beschreibung | Erwartet | Ergebnis | OK? |
|---|---|---|---|---|
| T20 | FK Buchung → Person (Waisen) | 0 Fehler | _________ | ☐ |
| T21 | FK Buchung → Land (Waisen) | 0 Fehler | _________ | ☐ |
| T22 | FK Positionen → Buchung (Waisen) | 0 Fehler | _________ | ☐ |
| T23 | Negative Preise | 0 Fehler | _________ | ☐ |
| T24 | Abreise vor Ankunft | 0 Fehler | _________ | ☐ |
| T25 | Leere Benutzernamen | 0 Fehler | _________ | ☐ |

---

## 4. Datensätze nach Import

| Tabelle | Erwartet | Tatsächlich | OK? |
|---|---|---|---|
| tbl_land | _________ | _________ | ☐ |
| tbl_leistung | _________ | _________ | ☐ |
| tbl_personen | _________ | _________ | ☐ |
| tbl_benutzer | _________ | _________ | ☐ |
| tbl_buchung | _________ | _________ | ☐ |
| tbl_positionen | _________ | _________ | ☐ |

---

## 5. Fazit / Bemerkungen

_________________________________________________________________________

---

*KI-Prompts verwendet für diesen Test:*

> _[Hier verwendete KI-Prompts eintragen – Anforderung Urheberbeweis]_

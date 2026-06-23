# Testkonzept – Backpacker_LB3

**Dokument**: Testkonzept  
**Version**: 1.1  
**Datum**: 2026-06-23  
**Autor**: Jann, Rocco, Janis

---

## 1. Testziele

- Zugriffsberechtigungen korrekt gemäss Zugriffsmatrix (positiv & negativ)
- Datenkonsistenz nach CSV-Import und Bereinigung (FK, Constraints, Datumslogik)
- Vollständige und korrekte Migration lokal → Cloud (Datensatzanzahl, Engine, FK, Benutzer)

---

## 2. Testarten

| Testart | Beschreibung | Skript |
|---|---|---|
| Berechtigungstest | Rollen und Rechte gemäss Zugriffsmatrix | `tests/test_berechtigungen.sql` |
| Konsistenztest | FK-Integrität, Datenqualität, Constraints | `tests/test_datenkonsistenz.sql` |
| Migrationstest | Vergleich lokal vs. Cloud | `tests/test_migration.sql` |

---

## 3. Positiv- und Negativtests (Zugriffsberechtigungen)

| Test-ID | Typ | Benutzer | Aktion | Tabelle / Spalte | Erwartet |
|---|---|---|---|---|---|
| T01 | ✅ Positiv | bp_benutzer | SELECT | tbl_personen | Daten zurück |
| T02 | ❌ Negativ | bp_benutzer | INSERT | tbl_personen | ERROR 1142 (ACCESS DENIED) |
| T03 | ✅ Positiv | bp_benutzer | SELECT (ohne Password) | tbl_benutzer | Daten zurück |
| T04 | ❌ Negativ | bp_benutzer | SELECT Password | tbl_benutzer.Password | ERROR 1143 (Column access denied) |
| T05 | ✅ Positiv | bp_benutzer | SELECT | tbl_buchung | Daten zurück |
| T06 | ✅ Positiv | bp_benutzer | INSERT | tbl_buchung | OK |
| T07 | ✅ Positiv | bp_benutzer | SELECT | tbl_land | Daten zurück |
| T08 | ❌ Negativ | bp_benutzer | INSERT | tbl_land | ERROR 1142 (ACCESS DENIED) |
| T09 | ✅ Positiv | bp_management | SELECT | tbl_buchung | Daten zurück |
| T10 | ❌ Negativ | bp_management | INSERT | tbl_buchung | ERROR 1142 (ACCESS DENIED) |
| T11 | ✅ Positiv | bp_management | SELECT, I, U, D | tbl_personen | OK |
| T12 | ❌ Negativ | bp_benutzer | DELETE | tbl_personen | ERROR 1142 (ACCESS DENIED) |

---

## 4. Datenkonsistenz-Tests (nach CSV-Import und Bereinigung)

| Test-ID | Beschreibung | Erwartet nach Bereinigung |
|---|---|---|
| T20 | FK: Buchungen ohne gültige Person | 0 Fehler |
| T21 | FK: Buchungen ohne gültiges Land | 0 Fehler (nach Land_FS=NULL Bereinigung) |
| T22 | FK: Positionen ohne gültige Buchung | 0 Fehler |
| T23 | FK: Positionen ohne gültigen Benutzer | 0 Fehler |
| T24 | FK: Positionen ohne gültige Leistung | 0 Fehler |
| T25 | Negative Preise in tbl_positionen | 0 Fehler |
| T26 | Abreise vor Ankunft | 0 Fehler (nach Abreise=NULL Bereinigung) |
| T27 | Leere Benutzernamen | 0 Fehler |
| T28 | deaktiviert = '1000-01-01' noch vorhanden | 0 Fehler (nach NULL Bereinigung) |
| T29 | Datensatzanzahl stimmt mit CSV überein | land:85, leistung:7, personen:2035, benutzer:11, buchung:1005, positionen:1745 |

---

## 5. Grenzfall-Tests

| Test-ID | Beschreibung | Erwartet |
|---|---|---|
| T40 | Buchung mit Land_FS = NULL (Grenzfall) | Zulässig (nullable FK) |
| T41 | INSERT tbl_buchung mit Abreise < Ankunft | CHECK constraint-Fehler |
| T42 | INSERT tbl_positionen mit Preis = 0.00 | OK (Grenzwert, nicht negativ) |
| T43 | INSERT tbl_positionen mit Rabatt = 100.00 | OK (Grenzwert) |
| T44 | INSERT tbl_positionen mit Rabatt = 100.01 | CHECK constraint-Fehler |
| T45 | INSERT tbl_benutzer mit leerem Benutzername | CHECK constraint-Fehler |

---

## 6. Migrationstests (nach Cloud-Import)

| Test-ID | Beschreibung | Erwartet |
|---|---|---|
| T30 | Datensatzanzahl lokal = Cloud | Identisch pro Tabelle |
| T31 | Storage Engine auf Cloud = InnoDB | InnoDB für alle Tabellen |
| T32 | FK-Constraints aktiv auf Cloud | Alle 5 FK-Constraints vorhanden |
| T33 | Benutzer auf Cloud vorhanden | bp_benutzer, bp_management, bp_readonly |
| T34 | Berechtigungen auf Cloud identisch zu lokal | Zugriffsmatrix erfüllt |

---

## 7. Demo-Testskript

Datei: `tests/test_demo_lp.sql` – führt alle Positivtests durch.  
Negativtests sind auskommentiert und werden bei der Live-Demo manuell aktiviert, um zu zeigen, dass ACCESS DENIED korrekt zurückgegeben wird.

**Ablauf Demo**:
1. Als `bp_readonly` einloggen → gesamte DB lesbar
2. Als `bp_benutzer` einloggen → T01–T08 live demonstrieren
3. Als `bp_management` einloggen → T09–T12 live demonstrieren
4. FK-Verletzung provozieren → Constraint-Fehler zeigen

---


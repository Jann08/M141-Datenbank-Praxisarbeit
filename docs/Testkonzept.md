# Testkonzept – Backpacker_LB3

**Dokument**: Testkonzept  
**Version**: 1.0  
**Datum**: _________  
**Autor**: _________

---

## 1. Testziele

- Zugriffsberechtigungen korrekt gemäss Zugriffsmatrix (positiv & negativ)
- Datenkonsistenz nach CSV-Import (FK, Constraints)
- Vollständige und korrekte Migration lokal → Cloud

---

## 2. Testarten

| Testart | Beschreibung | Skript |
|---|---|---|
| Berechtigungstest | Rolle und Rechte gemäss Zugriffsmatrix | `tests/test_berechtigungen.sql` |
| Konsistenztest | FK-Integrität, Datenqualität | `tests/test_datenkonsistenz.sql` |
| Migrationstest | Vergleich lokal vs. Cloud | `tests/test_migration.sql` |

---

## 3. Positiv- und Negativtests

### Positivtest (P): Aktion soll erlaubt sein → Ergebnis: Daten zurück
### Negativtest (N): Aktion soll verweigert werden → Ergebnis: ACCESS DENIED

| Test-ID | Typ | Benutzer | Aktion | Tabelle | Erwartet |
|---|---|---|---|---|---|
| T01 | P | bp_benutzer | SELECT | tbl_personen | Daten |
| T02 | N | bp_benutzer | INSERT | tbl_personen | Fehler |
| T03 | P | bp_benutzer | SELECT (ohne Password) | tbl_benutzer | Daten |
| T04 | N | bp_benutzer | SELECT Password | tbl_benutzer | Fehler |
| T05 | P | bp_benutzer | SELECT, I, U, D | tbl_buchung | Daten / OK |
| T06 | P | bp_benutzer | SELECT | tbl_land | Daten |
| T07 | N | bp_benutzer | INSERT | tbl_land | Fehler |
| T08 | P | bp_management | SELECT | tbl_buchung | Daten |
| T09 | N | bp_management | INSERT | tbl_buchung | Fehler |
| T10 | P | bp_management | S/I/U/D | tbl_personen | OK |

---

## 4. Testprotokolle

- Lokal: `tests/Testprotokoll_Lokal.md`
- Cloud: `tests/Testprotokoll_Cloud.md`

---

*KI-Prompts für dieses Dokument:*

> _[Prompts eintragen]_

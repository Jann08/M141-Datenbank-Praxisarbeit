# ERD – Backpacker_LB3 (2. Normalform)

**Diagramm-Typ**: Entity-Relationship-Diagramm  
**Normalform**: 2NF (Zweite Normalform)  
**Stand**: Basis aus Original-DDL, bereinigt auf InnoDB/FK

---

## Entitäten und Beziehungen (Textdarstellung)

```
tbl_land                    tbl_leistung
-----------                 ------------
Land_ID (PK)                LeistungID (PK)
Land                        Beschreibung


tbl_personen
------------
Personen_ID (PK)
Titel
Vorname
Name
Strasse
PLZ
Ort
Anrede
Telefon
erfasst
Sprache


tbl_benutzer
------------
Benutzer_ID (PK)
Benutzername (UNIQUE)
Password
Vorname
Name
Benutzergruppe
erfasst
deaktiviert
aktiv


tbl_buchung
-----------
Buchungs_ID (PK)
Personen_FS (FK → tbl_personen.Personen_ID)
Ankunft
Abreise
Land_FS (FK → tbl_land.Land_ID)


tbl_positionen
--------------
Positions_ID (PK)
Buchungs_FS  (FK → tbl_buchung.Buchungs_ID)
Konto
Anzahl
Preis
Rabatt
Benutzer_FS  (FK → tbl_benutzer.Benutzer_ID)
erfasst
Leistung_Text
Leistung_FS  (FK → tbl_leistung.LeistungID)
```

---

## Beziehungen

| Von | Zu | Typ | Beschreibung |
|---|---|---|---|
| tbl_buchung.Personen_FS | tbl_personen.Personen_ID | N:1 | Buchung gehört zu einem Gast |
| tbl_buchung.Land_FS | tbl_land.Land_ID | N:1 | Buchung hat ein Herkunftsland |
| tbl_positionen.Buchungs_FS | tbl_buchung.Buchungs_ID | N:1 | Position gehört zu einer Buchung |
| tbl_positionen.Leistung_FS | tbl_leistung.LeistungID | N:1 | Position referenziert eine Leistung |
| tbl_positionen.Benutzer_FS | tbl_benutzer.Benutzer_ID | N:1 | Position erfasst von Mitarbeiter |

---

## Anmerkungen zur Bereinigung

- **Engine**: Original MyISAM → migriert zu **InnoDB** (FK-Unterstützung)
- **Charset**: Original latin1_general_ci → migriert zu **utf8mb4_unicode_ci**
- **FULLTEXT**: Original FULLTEXT KEY auf Leistung_Text entfernt (MyISAM-spezifisch, InnoDB unterstützt es ebenfalls, aber für FK nötig)
- **tbl_land**: Kein PRIMARY KEY im Original → `Land_ID` als PK definiert
- **deaktiviert**: Originalwert `'1000-01-01'` als Default → auf `NULL` geändert (sauberer)

---

*Grafisches ERD-Bild: siehe `diagrams/` Ordner (manuell erstellen mit draw.io oder dbdiagram.io)*

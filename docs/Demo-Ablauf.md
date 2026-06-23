# Demo-Ablauf – M141 Praxisarbeit Backpacker_LB3

**Dauer**: ca. 10–15 Minuten  
**System**: AWS RDS Cloud-DBMS (eu-north-1)  
**Endpoint**: `backpacker-lb3.ctyew6siuvwz.eu-north-1.rds.amazonaws.com`

---

## Vorbereitung (vor der Demo)

- Drei CMD/Terminal-Fenster öffnen
- In jedem Fenster ins Repo-Verzeichnis wechseln:
  ```
  cd C:\Users\admin\AppData\Local\Temp\claude\m141\repo
  ```
- Passwörter bereithalten (unten aufgelistet)

---

## Schritt 1 – Systemübersicht (ca. 3 Min)

**Verbindung als Admin:**
```
mysql -h backpacker-lb3.ctyew6siuvwz.eu-north-1.rds.amazonaws.com -u admin -pBP_Cloud2026! backpacker_lb3
```

**Demo-Skript ausführen:**
```sql
source tests/test_demo_lp.sql
```

**Was gezeigt wird:**
- MariaDB-Version auf AWS RDS
- Alle 6 Tabellen mit Zeilenanzahl (4885 Datensätze total)
- 3 Datenbankbenutzer vorhanden
- 5 Fremdschlüssel-Constraints aktiv

---

## Schritt 2 – Berechtigungen: bp_benutzer (ca. 5 Min)

**Verbindung als bp_benutzer (Terminal 2):**
```
mysql -h backpacker-lb3.ctyew6siuvwz.eu-north-1.rds.amazonaws.com -u bp_benutzer -pBenutzer@Cloud123! backpacker_lb3
```

**Positivtests (funktionieren):**
```sql
-- T01: Gäste lesen
SELECT Personen_ID, Vorname, Name, Ort FROM tbl_personen LIMIT 5;

-- T03: Benutzer lesen (ohne Passwort)
SELECT Benutzer_ID, Benutzername, Vorname, Name FROM tbl_benutzer LIMIT 5;

-- T05: Buchungen lesen
SELECT Buchungs_ID, Personen_FS, Ankunft, Abreise FROM tbl_buchung LIMIT 5;
```

**Negativtest T04 – Passwort-Spalte gesperrt:**
```sql
SELECT Password FROM tbl_benutzer LIMIT 1;
-- Erwartet: ERROR 1143 (SELECT command denied for column 'Password')
```

**Negativtest T02 – Kein INSERT auf tbl_personen:**
```sql
INSERT INTO tbl_personen (Vorname, Name) VALUES ('Demo', 'Test');
-- Erwartet: ERROR 1142 (INSERT command denied)
```

---

## Schritt 3 – Berechtigungen: bp_management (ca. 3 Min)

**Verbindung als bp_management (Terminal 3):**
```
mysql -h backpacker-lb3.ctyew6siuvwz.eu-north-1.rds.amazonaws.com -u bp_management -pManagement@Sicher456! backpacker_lb3
```

**Tests:**
```sql
-- T11: Vollzugriff auf Personen (SELECT, INSERT, UPDATE, DELETE)
SELECT Personen_ID, Vorname, Name FROM tbl_personen LIMIT 3;

-- T10: Kein INSERT auf Buchung (Management ist read-only auf tbl_buchung)
INSERT INTO tbl_buchung (Personen_FS, Ankunft) VALUES (1, NOW());
-- Erwartet: ERROR 1142
```

---

## Schritt 4 – Constraint-Demo (ca. 2 Min)

**Als bp_benutzer (Terminal 2):**
```sql
-- FK-Verletzung: Buchung mit nicht existierender Person
INSERT INTO tbl_buchung (Personen_FS, Ankunft) VALUES (99999, NOW());
-- Erwartet: ERROR 1452 (FOREIGN KEY constraint fails)

-- CHECK-Constraint: Abreise vor Ankunft
INSERT INTO tbl_buchung (Personen_FS, Ankunft, Abreise) VALUES (1, '2026-06-10', '2026-06-01');
-- Erwartet: ERROR 4025 (CHECK constraint chk_buchung_datum failed)
```

---

## Passwörter (für die Demo)

| Benutzer | Passwort |
|---|---|
| admin | BP_Cloud2026! |
| bp_benutzer | Benutzer@Cloud123! |
| bp_management | Management@Sicher456! |
| bp_readonly | ReadOnly@View789! |

---

## Datenbankstruktur (Kurzübersicht)

| Tabelle | Datensätze | Beschreibung |
|---|---|---|
| tbl_land | 83 | Ländercodes |
| tbl_leistung | 7 | Serviceangebote |
| tbl_personen | 2'035 | Gästedaten |
| tbl_benutzer | 10 | Mitarbeiter |
| tbl_buchung | 1'005 | Buchungsköpfe |
| tbl_positionen | 1'745 | Buchungspositionen |
| **Total** | **4'885** | |

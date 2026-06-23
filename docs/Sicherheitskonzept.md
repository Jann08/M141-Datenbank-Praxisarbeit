# Sicherheitskonzept – Backpacker_LB3

**Dokument**: Sicherheitskonzept  
**Version**: 1.1  
**Datum**: 2026-06-23  
**Autor**: Jann, Rocco, Janis

---

## 1. Zugriffsschutz

### 1.1 Datenbankbenutzer und Rechte

| Benutzer | Rechte | Passwort-Policy |
|---|---|---|
| root | Vollzugriff (nur lokal, kein Remote-Login) | Sicheres Passwort, bind-address=127.0.0.1 |
| bp_benutzer | Gemäss Zugriffsmatrix (Spalten-Level) | Min. 12 Zeichen, Gross-/Klein-/Zahl/Sonderzeichen |
| bp_management | Gemäss Zugriffsmatrix | Min. 12 Zeichen, Gross-/Klein-/Zahl/Sonderzeichen |
| bp_readonly | SELECT auf gesamte DB | Min. 12 Zeichen |

### 1.2 Sicherheitsmassnahmen (lokal)

| Massnahme | Beschreibung | Status |
|---|---|---|
| Root Remote-Login deaktiviert | `bind-address = 127.0.0.1` in my.cnf | ✅ |
| Anonyme Benutzer entfernt | Keine anonymen Accounts in DB | ✅ |
| Spalten-Level-Berechtigungen | `tbl_benutzer.Password` für bp_benutzer nicht zugänglich | ✅ |
| Passwörter gehasht | SHA2-256 nach Import (08_bereinigung.sql) | ✅ |
| Principle of Least Privilege | Jede Rolle hat nur nötige Rechte gemäss Matrix | ✅ |

### 1.3 Spalten-Berechtigungen tbl_benutzer (Detail)

Die Spalte `Password` ist für `bp_benutzer` vollständig gesperrt – weder SELECT noch UPDATE.  
Für `bp_benutzer` gilt auf `tbl_benutzer`:
- **SELECT**: Benutzer_ID, Benutzername, Vorname, Name, Benutzergruppe, erfasst, deaktiviert, aktiv
- **INSERT**: Benutzername, Vorname, Name, Benutzergruppe, erfasst, aktiv
- **UPDATE**: Benutzername, Vorname, Name, Benutzergruppe, aktiv
- **Password-Spalte**: kein Zugriff (wird über GRANT nur auf explizit genannte Spalten erteilt)

---

## 2. Netzwerksicherheit (Cloud – AWS RDS)

| Massnahme | Beschreibung | Status |
|---|---|---|
| TLS/SSL erzwingen | `require_secure_transport = ON` in RDS Parameter Group | ⬜ nach Cloud-Setup |
| Security Group | Port 3306 nur für definierte IPs/IP-Ranges (eigene IPs) | ⬜ nach Cloud-Setup |
| Kein Public Endpoint | DB nicht öffentlich erreichbar (Private Subnet oder IP-Einschränkung) | ⬜ nach Cloud-Setup |
| IAM-Authentifizierung | RDS IAM-Authentifizierung aktiviert | ⬜ optional |
| Backup verschlüsselt | RDS-Backups automatisch verschlüsselt (AWS-Key) | ✅ (Standard AWS) |

![Cloud-Verbindung mit Benutzernachweis](../docs/screenshots/02_cloud_verbindung.png)
*AWS RDS Verbindung bestätigt – Endpoint, Version und Datensätze sichtbar*

---

## 3. Backup-Konzept

| Typ | Häufigkeit | Speicherort | Aufbewahrung |
|---|---|---|---|
| Vollbackup lokal (mysqldump) | Vor Migration (einmalig) | `backup/backpacker_lb3_lokal.sql` | Projektdauer |
| Cloud-Backup (AWS RDS) | Automatisch täglich | AWS S3 (automatisch) | 7 Tage |

**Backup-Befehl lokal** (vor Migration ausführen):
```bash
mysqldump -u root -p --single-transaction --routines --triggers \
  backpacker_lb3 > backup/backpacker_lb3_YYYY-MM-DD.sql
```

**Restore-Befehl lokal**:
```bash
mysql -u root -p backpacker_lb3 < backup/backpacker_lb3_YYYY-MM-DD.sql
```

---

## 4. Bedrohungsanalyse

| Bedrohung | Risiko | Massnahme |
|---|---|---|
| SQL-Injection | Hoch | Benutzerrechte minimal, Prepared Statements auf App-Ebene |
| Unberechtigter Datenzugriff | Mittel | Zugriffsmatrix, Spalten-Berechtigungen, Rollen |
| Datenverlust | Mittel | Regelmässige Backups (mysqldump + AWS automatisch) |
| Unverschlüsselte Übertragung | Hoch (Cloud) | TLS erzwingen (`require_secure_transport = ON`) |
| Schwache Passwörter | Mittel | Passwort-Policy, SHA2-Hash im Import |
| Root-Zugriff von aussen | Hoch | `bind-address = 127.0.0.1`, kein Root-Remote-Login |
| Klartext-Passwörter im CSV | Hoch | Nach Import sofort SHA2-hashen (08_bereinigung.sql) |

---

## 5. Konfigurationsparameter Sicherheit (my_cloud.cnf)

| Parameter | Wert | Sicherheitsbegründung |
|---|---|---|
| `require_secure_transport` | ON | Alle Verbindungen müssen TLS verwenden |
| `bind-address` | 0.0.0.0 | Cloud: AWS Security Group steuert Zugriff |
| `max_connections` | 100 | DoS-Schutz, begrenzt Verbindungsanzahl |
| `connect_timeout` | 10 | Verhindert hängende Verbindungen |
| `innodb_flush_log_at_trx_commit` | 1 | ACID: jede Transaktion sofort auf Disk |
| `sync_binlog` | 1 | Crash-sicherer Binlog für Restore |

---


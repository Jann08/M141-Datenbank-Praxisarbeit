# Sicherheitskonzept – Backpacker_LB3

**Dokument**: Sicherheitskonzept  
**Version**: 1.0  
**Datum**: _________  
**Autor**: _________

---

## 1. Zugriffsschutz

### 1.1 Datenbankbenutzer

| Benutzer | Rechte | Passwort-Policy |
|---|---|---|
| root | Vollzugriff (nur lokal) | Sicheres Passwort, kein Remote-Login |
| bp_benutzer | Gemäss Zugriffsmatrix | Min. 12 Zeichen, Gross/Klein/Zahl |
| bp_management | Gemäss Zugriffsmatrix | Min. 12 Zeichen, Gross/Klein/Zahl |
| bp_readonly | SELECT * | Min. 12 Zeichen |

### 1.2 Massnahmen

- [ ] Root-Login von Remote deaktiviert (`bind-address = 127.0.0.1` lokal)
- [ ] Anonyme Benutzer entfernt (`DELETE FROM mysql.user WHERE User=''`)
- [ ] Passwort-Policy aktiv (simple_password_check Plugin)
- [ ] Spalten-Level-Berechtigungen für `tbl_benutzer.Password`

---

## 2. Netzwerksicherheit (Cloud)

| Massnahme | Beschreibung | Status |
|---|---|---|
| TLS/SSL | Verschlüsselte Verbindungen (`require_secure_transport = ON`) | ☐ |
| Firewall / Security Group | Port 3306 nur für definierte IPs offen | ☐ |
| VPC / Private Subnet | DB nicht öffentlich erreichbar | ☐ |
| Backup verschlüsselt | Cloud-Backup verschlüsselt | ☐ |

---

## 3. Backup-Konzept

| Typ | Häufigkeit | Speicherort | Aufbewahrung |
|---|---|---|---|
| Vollbackup (mysqldump) | Täglich | Cloud-Storage (S3 o.ä.) | 7 Tage |
| Lokal (für Migration) | Einmalig | `backup/` im Repo | Projektdauer |

Backup-Befehl lokal:
```bash
mysqldump -u root -p backpacker_lb3 > backup/backpacker_lb3_YYYY-MM-DD.sql
```

---

## 4. Bedrohungsanalyse

| Bedrohung | Massnahme |
|---|---|
| SQL-Injection | Prepared Statements (App-Level), Benutzerrechte minimal |
| Unberechtigter Zugriff | Zugriffsmatrix, Spalten-Berechtigungen |
| Datenverlust | Regelmässige Backups |
| Unverschlüsselte Übertragung | TLS erzwingen (Cloud) |
| Schwache Passwörter | Passwort-Policy |

---

*KI-Prompts für dieses Dokument:*

> _[Prompts eintragen]_

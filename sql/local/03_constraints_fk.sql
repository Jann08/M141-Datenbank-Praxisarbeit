-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 03_constraints_fk.sql
-- Beschreibung: Zusätzliche Constraints und Indizes
-- Ausführen als: root, nach 02_create_tables.sql
-- ============================================================

USE backpacker_lb3;

-- Indizes für Performance (häufig genutzte Suchfelder)
CREATE INDEX idx_personen_name     ON tbl_personen  (Name, Vorname);
CREATE INDEX idx_buchung_ankunft   ON tbl_buchung   (Ankunft);
CREATE INDEX idx_buchung_abreise   ON tbl_buchung   (Abreise);
CREATE INDEX idx_positionen_konto  ON tbl_positionen (Konto);
CREATE INDEX idx_positionen_erfasst ON tbl_positionen (erfasst);

-- Sicherstellen dass Benutzername nicht leer ist
ALTER TABLE tbl_benutzer
    ADD CONSTRAINT chk_benutzername CHECK (Benutzername <> '');

-- Buchungsdaten: Abreise muss nach Ankunft liegen
ALTER TABLE tbl_buchung
    ADD CONSTRAINT chk_buchung_datum CHECK (Abreise IS NULL OR Ankunft IS NULL OR Abreise >= Ankunft);

-- Preis und Rabatt dürfen nicht negativ sein
ALTER TABLE tbl_positionen
    ADD CONSTRAINT chk_preis   CHECK (Preis  >= 0),
    ADD CONSTRAINT chk_rabatt  CHECK (Rabatt >= 0 AND Rabatt <= 100);

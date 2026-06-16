-- ============================================================
-- M141 Praxisarbeit – Backpacker_LB3
-- Skript: 02_create_tables.sql
-- Beschreibung: Tabellen erstellen (InnoDB, UTF8MB4)
-- Ausführen als: root, nach 01_create_database.sql
-- ============================================================

USE backpacker_lb3;

-- ------------------------------------------------------------
-- tbl_land: Ländercodes
-- ------------------------------------------------------------
CREATE TABLE tbl_land (
    Land_ID     INT          NOT NULL,
    Land        VARCHAR(100) NOT NULL,
    PRIMARY KEY (Land_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Ländercodes der Gäste';


-- ------------------------------------------------------------
-- tbl_leistung: Servicekategorien
-- ------------------------------------------------------------
CREATE TABLE tbl_leistung (
    LeistungID   INT         NOT NULL,
    Beschreibung VARCHAR(70) DEFAULT NULL,
    PRIMARY KEY (LeistungID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Leistungskategorien / Serviceangebote';


-- ------------------------------------------------------------
-- tbl_personen: Gäste
-- ------------------------------------------------------------
CREATE TABLE tbl_personen (
    Personen_ID INT           NOT NULL AUTO_INCREMENT,
    Titel       VARCHAR(20)   DEFAULT NULL,
    Vorname     VARCHAR(50)   DEFAULT NULL,
    Name        VARCHAR(50)   DEFAULT NULL,
    Strasse     VARCHAR(100)  DEFAULT NULL,
    PLZ         VARCHAR(10)   DEFAULT NULL,
    Ort         VARCHAR(50)   DEFAULT NULL,
    Anrede      VARCHAR(10)   DEFAULT NULL,
    Telefon     VARCHAR(30)   DEFAULT NULL,
    erfasst     DATETIME      DEFAULT NULL,
    Sprache     VARCHAR(10)   DEFAULT NULL,
    PRIMARY KEY (Personen_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Gästedaten';


-- ------------------------------------------------------------
-- tbl_benutzer: Mitarbeiter / System-Benutzer
-- ------------------------------------------------------------
CREATE TABLE tbl_benutzer (
    Benutzer_ID    INT          NOT NULL AUTO_INCREMENT,
    Benutzername   VARCHAR(20)  NOT NULL,
    Password       VARCHAR(255) DEFAULT NULL,
    Vorname        VARCHAR(20)  DEFAULT NULL,
    Name           VARCHAR(50)  DEFAULT NULL,
    Benutzergruppe TINYINT(4)   DEFAULT 1,
    erfasst        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deaktiviert    DATE         DEFAULT NULL,
    aktiv          TINYINT(4)   DEFAULT 1,
    PRIMARY KEY (Benutzer_ID),
    UNIQUE KEY uk_benutzername (Benutzername)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Mitarbeiter / Systembenutzer';


-- ------------------------------------------------------------
-- tbl_buchung: Buchungskopf
-- ------------------------------------------------------------
CREATE TABLE tbl_buchung (
    Buchungs_ID INT      NOT NULL AUTO_INCREMENT,
    Personen_FS INT      DEFAULT NULL,
    Ankunft     DATETIME DEFAULT NULL,
    Abreise     DATETIME DEFAULT NULL,
    Land_FS     INT      DEFAULT NULL,
    PRIMARY KEY (Buchungs_ID),
    CONSTRAINT fk_buchung_personen FOREIGN KEY (Personen_FS) REFERENCES tbl_personen (Personen_ID),
    CONSTRAINT fk_buchung_land     FOREIGN KEY (Land_FS)     REFERENCES tbl_land (Land_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Buchungskopfdaten';


-- ------------------------------------------------------------
-- tbl_positionen: Buchungspositionen (Einzelleistungen)
-- ------------------------------------------------------------
CREATE TABLE tbl_positionen (
    Positions_ID  INT           NOT NULL AUTO_INCREMENT,
    Buchungs_FS   INT           DEFAULT NULL,
    Konto         INT           NOT NULL DEFAULT 0,
    Anzahl        INT           NOT NULL DEFAULT 0,
    Preis         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Rabatt        DECIMAL(4,2)  NOT NULL DEFAULT 0.00,
    Benutzer_FS   INT           NOT NULL DEFAULT 0,
    erfasst       DATETIME      NOT NULL DEFAULT '2000-01-01 00:00:00',
    Leistung_Text VARCHAR(255)  NOT NULL DEFAULT '',
    Leistung_FS   INT           DEFAULT NULL,
    PRIMARY KEY (Positions_ID),
    CONSTRAINT fk_positionen_buchung   FOREIGN KEY (Buchungs_FS) REFERENCES tbl_buchung  (Buchungs_ID),
    CONSTRAINT fk_positionen_leistung  FOREIGN KEY (Leistung_FS) REFERENCES tbl_leistung (LeistungID),
    CONSTRAINT fk_positionen_benutzer  FOREIGN KEY (Benutzer_FS) REFERENCES tbl_benutzer (Benutzer_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Einzelne Buchungspositionen / Leistungen';

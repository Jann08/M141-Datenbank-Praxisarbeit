-- phpMyAdmin SQL Dump
-- version 2.9.1.1
-- http://www.phpmyadmin.net
-- 
-- 
-- Datenbank: `backpacker_lb3`
-- 
-- --------------------------------------------------------
-- 
-- Tabellenstruktur für Tabelle `tbl_benutzer`
-- 

CREATE TABLE `tbl_benutzer` (
  `Benutzer_ID` int(11) NOT NULL auto_increment,
  `Benutzername` varchar(20) collate latin1_general_ci NOT NULL default '',
  `Password` text collate latin1_general_ci,
  `Vorname` varchar(20) collate latin1_general_ci default NULL,
  `Name` text collate latin1_general_ci,
  `Benutzergruppe` tinyint(4) default '1',
  `erfasst` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `deaktiviert` date default '1000-01-01',
  `aktiv` tinyint(4) default '1',
  PRIMARY KEY  (`Benutzer_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Mitarbeiter' AUTO_INCREMENT=28 ;



-- 
-- Tabellenstruktur für Tabelle `tbl_buchung`
-- 

CREATE TABLE `tbl_buchung` (
  `Buchungs_ID` int(11) NOT NULL auto_increment,
  `Personen_FS` int(11) default NULL,
  `Ankunft` datetime default NULL,
  `Abreise` datetime default NULL,
  `Land_FS` int(11) default NULL,
  PRIMARY KEY  (`Buchungs_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Buchungszeilen' AUTO_INCREMENT=1087 ;



-- 
-- Tabellenstruktur für Tabelle `tbl_land`
-- 

CREATE TABLE `tbl_land` (
  `Land_ID` int(11) NOT NULL default '0',
  `Land` text collate latin1_general_ci NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält die Ländercodes';


-- 
-- Tabellenstruktur für Tabelle `tbl_leistung`
-- 

CREATE TABLE `tbl_leistung` (
  `LeistungID` int(11) NOT NULL default '0',
  `Beschreibung` varchar(70) collate latin1_general_ci default NULL,
  PRIMARY KEY  (`LeistungID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;



-- 
-- Tabellenstruktur für Tabelle `tbl_personen`
-- 

CREATE TABLE `tbl_personen` (
  `Personen_ID` int(11) NOT NULL auto_increment,
  `Titel` text collate latin1_general_ci,
  `Vorname` text collate latin1_general_ci,
  `Name` text collate latin1_general_ci,
  `Strasse` text collate latin1_general_ci,
  `PLZ` text collate latin1_general_ci,
  `Ort` text collate latin1_general_ci,
  `Anrede` text collate latin1_general_ci,
  `Telefon` text collate latin1_general_ci,
  `erfasst` datetime default NULL,
  `Sprache` text collate latin1_general_ci,
  PRIMARY KEY  (`Personen_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält alle Gäste' AUTO_INCREMENT=2042 ;

-- 
-- Tabellenstruktur für Tabelle `tbl_positionen`
-- 

CREATE TABLE `tbl_positionen` (
  `Positions_ID` int(11) NOT NULL auto_increment,
  `Buchungs_FS` int(11) default NULL,
  `Konto` int(11) NOT NULL default '0',
  `Anzahl` int(11) NOT NULL default '0',
  `Preis` decimal(10,2) NOT NULL default '0.00',
  `Rabatt` decimal(4,2) NOT NULL default '0.00',
  `Benutzer_FS` int(11) NOT NULL default '0',
  `erfasst` datetime NOT NULL default '2000-01-01 00:00:00',
  `Leistung_Text` text collate latin1_general_ci NOT NULL,
  `Leistung_FS` INT (11),  
  PRIMARY KEY  (`Positions_ID`),
  FULLTEXT KEY `Leistung_Text` (`Leistung_Text`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält einzelne Buchungspositionen' AUTO_INCREMENT=4055 ;





-- créer nouvelle table

CREATE TABLE "persovd_nettoyage" (
	Numero INTEGER  PRIMARY KEY AUTOINCREMENT,
	Nom VARCHAR(50),
	Prenom VARCHAR(50),
	Autre_nom VARCHAR(50),
	Autre_prenom VARCHAR(50),
	Sexe VARCHAR(50),
	Dates_vie NVARCHAR(50),
	Lieu_naiss VARCHAR(50),
	Date_naiss INTEGER,
	Date_naiss_complete NVARCHAR(50),
	Date_mort INTEGER,
	Date_mort_complete NVARCHAR(50),
	Vivant INTEGER,
	Profession VARCHAR(256),
	Domaine VARCHAR(256),
	Valdensia1 VARCHAR(50),
	Valdensia2 NVARCHAR(50),
	Date_creation NVARCHAR(50),
	Date_modification NVARCHAR(50),
	Signature VARCHAR(50),
	Wikipedia INTEGER,
	ArchiveBN INTEGER
);


/*
 * Importer les données de la table d'origine
 * ATTENTION : skip les colonnes non retenues

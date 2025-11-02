
-- Création de nouvelle table des lieux

CREATE TABLE "geoplace" (
	pk_geoplace INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT,
	canton_region TEXT,
	country TEXT,
	continent TEXT,
	notes TEXT,
	class TEXT,
	long_lat TEXT -- valeur WKT: POINT(long lat), long lat étant des nombres avec '.' comme séparateur des décimales
);


-- modification sur la base nettoyée: cf. novuelle_table_donnees.sql
update persovd_nettoyage set Lieu_naiss = trim(Lieu_naiss);

-- lieux et nombre de mention
SELECT p.Lieu_naiss, count(*) as number
FROM "persovd_nettoyage" p
Group by Lieu_naiss
order by number desc;

-- lieux et nombre de mention
SELECT p.Lieu_naiss, count(*) as number
FROM "persovd_nettoyage" p
Group by Lieu_naiss
order by Lieu_naiss;


SELECT p.Lieu_naiss, count(*) as number
FROM "persovd_nettoyage" p
Group by Lieu_naiss
having Lieu_naiss like 'Frib%';



SELECT p.Lieu_naiss, p.Numero 
FROM "persovd_nettoyage" p
where Lieu_naiss like 'Frib%';





/*
 * Traitement des lieux de naissance
 * 
 * Lieux traités: Genève (2), Fribourg (1)
 */

SELECT p.Lieu_naiss, p.Numero, p.Nom , p.Prenom , p.fk_birth_place 
FROM "persovd_nettoyage" p
where Lieu_naiss
like 'Frib%';

UPDATE "persovd_nettoyage" set fk_birth_place = --1
where Lieu_naiss
like 'Frib%';


--- Exploration
SELECT g.name, g.pk_geoplace, g.long_lat 
FROM persovd_nettoyage pn
   join geoplace g on g.pk_geoplace = pn.fk_birth_place 
where g.long_lat is not null;   


--- Exploration
SELECT g.name, g.canton_region, g.country, 
	g.long_lat, count(*) as number
FROM persovd_nettoyage pn
   join geoplace g on g.pk_geoplace = pn.fk_birth_place 
where g.long_lat is not null
group by g.name;   

drop view v_birth_place_number ;
create view v_birth_place_number AS
SELECT g.name, g.canton_region, g.country, 
	g.long_lat, count(*) as number
FROM persovd_nettoyage pn
   join geoplace g on g.pk_geoplace = pn.fk_birth_place 
where g.long_lat is not null
group by g.name; 


/*
 * Affichage regroupé sur la carte:
 * sélectionner la colonne avec la valeur WKT - POINT(long lat)
 * 
 * Recherche moteur de recherche indique que probablement il n'y a pas 
 * de possibilité d'afficher le diamètre de points en fonction de l'effectîf
 * Un logiciel de GIS est nécessaire
 */

select *
from v_birth_place_number ;




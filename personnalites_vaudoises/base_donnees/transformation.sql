
/*
 * Traiter les lieux de naissance 
 * 
 *
 */

-- lieux et nombre de mention
SELECT p.Lieu_naiss, count(*) as number
FROM "20170907_persovd" p
Group by Lieu_naiss
order by number desc;

-- lieux et nombre de mention
SELECT p.Lieu_naiss, count(*) as number
FROM "20170907_persovd" p
Group by Lieu_naiss
order by Lieu_naiss;


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
having Lieu_naiss like 'Gen%';



SELECT p.Lieu_naiss, p.Numero 
FROM "persovd_nettoyage" p
where Lieu_naiss like 'Gene%';











/*
 * Décomposer les occupations
 * Documentation:
 * https://www.geeksforgeeks.org/sqlite/how-to-split-a-delimited-string-to-access-individual-items-in-sqlite/
 */

SELECT
    p.Numero, Nom, 
    SUBSTR(p.Profession , 1, INSTR(p.Profession , '/') - 1) AS part,
    SUBSTR(p.Profession , INSTR(p.Profession , '/') + 1) AS remainder
FROM "20170907_persovd" p ;




SELECT
    p.Numero, Nom,
    CASE
	    WHEN INSTR(Profession, '/') > 0 THEN SUBSTR(p.Profession , 1, INSTR(p.Profession , '/') - 1)
		ELSE
			Profession
	END part
FROM "20170907_persovd" p ;




-- traitement des cas sans '/' pour éviter la boule infinie du récursif
SELECT
    p.Numero, Nom,
    CASE 
	    WHEN (INSTR(Profession, '/')) > 0 THEN SUBSTR(p.Profession , 1, INSTR(p.Profession , '/') - 1)
		ELSE
			Profession
	END part,
	CASE 
	    WHEN INSTR(Profession, '/') > 0 THEN SUBSTR(p.Profession , INSTR(p.Profession , '/') + 1)
		ELSE
			''
	END remainder
FROM "20170907_persovd" p ;


-- en ajoutant la récursivité
WITH RECURSIVE Splitter AS (
	    SELECT
	    p.Numero, Nom,
	    CASE 
	    WHEN (INSTR(Profession, '/')) > 0 THEN SUBSTR(p.Profession , 1, INSTR(p.Profession , '/') - 1)
		ELSE
			Profession
	END part,
	CASE 
	    WHEN INSTR(Profession, '/') > 0 THEN SUBSTR(p.Profession , INSTR(p.Profession , '/') + 1)
		ELSE
			''
	END remainder
		FROM "20170907_persovd" p 
    UNION ALL
		SELECT
		    Numero, nom,
		    CASE 
	    WHEN (INSTR(remainder, '/')) > 0 THEN SUBSTR(remainder , 1, INSTR(remainder , '/') - 1)
		ELSE
			remainder
	END part,
	CASE 
	    WHEN INSTR(remainder, '/') > 0 THEN SUBSTR(remainder , INSTR(remainder , '/') + 1)
		ELSE
			''
	END remainder
		FROM
        Splitter
    WHERE
        remainder != ''
)
SELECT
    Numero, nom, TRIM(part), remainder
FROM
    Splitter
order by Numero ;



-- crééer une table pour le résultat
-- DROP TABLE t_person_occupation;
CREATE TABLE t_person_occupation AS
WITH RECURSIVE Splitter AS (
	    SELECT
	    p.Numero, Nom,
	    CASE 
	    WHEN (INSTR(Profession, '/')) > 0 THEN SUBSTR(p.Profession , 1, INSTR(p.Profession , '/') - 1)
		ELSE
			Profession
	END part,
	CASE 
	    WHEN INSTR(Profession, '/') > 0 THEN SUBSTR(p.Profession , INSTR(p.Profession , '/') + 1)
		ELSE
			''
	END remainder
		FROM "20170907_persovd" p 
    UNION ALL
		SELECT
		    Numero, nom,
		    CASE 
	    WHEN (INSTR(remainder, '/')) > 0 THEN SUBSTR(remainder , 1, INSTR(remainder , '/') - 1)
		ELSE
			remainder
	END part,
	CASE 
	    WHEN INSTR(remainder, '/') > 0 THEN SUBSTR(remainder , INSTR(remainder , '/') + 1)
		ELSE
			''
	END remainder
		FROM
        Splitter
    WHERE
        remainder != ''
)
SELECT
    Numero, nom, TRIM(part) occupation, 0 as fk_occupation
FROM
    Splitter
order by Numero ;




SELECT occupation, count(*) as number
FROM t_person_occupation
group by occupation 
having occupation like 'Photo%';





/*
 * Décomposer les domaines
 * Documentation:
 * https://www.geeksforgeeks.org/sqlite/how-to-split-a-delimited-string-to-access-individual-items-in-sqlite/
 */

-- traitement des cas sans '/' pour éviter la boule infinie du récursif
SELECT
    p.Numero, Nom,
    CASE 
	    WHEN (INSTR(Domaine, '/')) > 0 THEN SUBSTR(p.Domaine , 1, INSTR(p.Domaine , '/') - 1)
		ELSE
			Domaine
	END part,
	CASE 
	    WHEN INSTR(Domaine, '/') > 0 THEN SUBSTR(p.Domaine , INSTR(p.Domaine , '/') + 1)
		ELSE
			''
	END remainder
FROM "20170907_persovd" p ;


-- en ajoutant la récursivité
WITH RECURSIVE Splitter AS (
	    SELECT
	    p.Numero, Nom,
	    CASE 
	    WHEN (INSTR(Domaine, '/')) > 0 THEN SUBSTR(p.Domaine , 1, INSTR(p.Domaine , '/') - 1)
		ELSE
			Domaine
	END part,
	CASE 
	    WHEN INSTR(Domaine, '/') > 0 THEN SUBSTR(p.Domaine , INSTR(p.Domaine , '/') + 1)
		ELSE
			''
	END remainder
		FROM "20170907_persovd" p 
    UNION ALL
		SELECT
		    Numero, nom,
		    CASE 
	    WHEN (INSTR(remainder, '/')) > 0 THEN SUBSTR(remainder , 1, INSTR(remainder , '/') - 1)
		ELSE
			remainder
	END part,
	CASE 
	    WHEN INSTR(remainder, '/') > 0 THEN SUBSTR(remainder , INSTR(remainder , '/') + 1)
		ELSE
			''
	END remainder
		FROM
        Splitter
    WHERE
        remainder != ''
)
SELECT
    Numero, nom, TRIM(part), remainder
FROM
    Splitter
order by Numero ;



-- crééer une table pour le résultat
-- DROP TABLE t_person_domain;
CREATE TABLE t_person_domain AS
WITH RECURSIVE Splitter AS (
	    SELECT
	    p.Numero, Nom,
	    CASE 
	    WHEN (INSTR(Domaine, '/')) > 0 THEN SUBSTR(p.Domaine , 1, INSTR(p.Domaine , '/') - 1)
		ELSE
			Domaine
	END part,
	CASE 
	    WHEN INSTR(Domaine, '/') > 0 THEN SUBSTR(p.Domaine , INSTR(p.Domaine , '/') + 1)
		ELSE
			''
	END remainder
		FROM "20170907_persovd" p 
    UNION ALL
		SELECT
		    Numero, nom,
		    CASE 
	    WHEN (INSTR(remainder, '/')) > 0 THEN SUBSTR(remainder , 1, INSTR(remainder , '/') - 1)
		ELSE
			remainder
	END part,
	CASE 
	    WHEN INSTR(remainder, '/') > 0 THEN SUBSTR(remainder , INSTR(remainder , '/') + 1)
		ELSE
			''
	END remainder
		FROM
        Splitter
    WHERE
        remainder != ''
)
SELECT
    Numero, nom, TRIM(part) domain, 0 as fk_domaine
FROM
    Splitter
order by Numero ;



-- inspecter le résultat
SELECT domain, count(*) as number
FROM t_person_domain
group by domain ;
having domain like 'Photo%';



-- premières lignes

SELECT *
FROM "20170907_persovd" p 
limit 30;


/*
 * Vérification des doublons
 * 
 * Apparemment il n'y en a pas, par contre de nombreux homonymes
 * 
 * Objets de la table: personnes (et non mentions de personnes)
 * 
 */



SELECT Nom || ', ' || Prenom as appellation
FROM "20170907_persovd" p 
limit 30;






-- vérifier s'il y a des doublons
with tw1 as (
SELECT Nom || ', ' || Prenom as appellation 
FROM "20170907_persovd" p )
SELECT appellation, count(*) as number
from tw1
group by appellation
having count(*) > 1;



SELECT Nom || ', ' || Prenom as appellation, p.Date_naiss, p.Lieu_naiss, p.Dates_vie, p.Date_mort, p.Profession, p.Domaine 
FROM "20170907_persovd" p 
where Nom = 'Besson'
and p.Prenom = 'Jacques'
order by Dates_vie;

SELECT Nom || ', ' || Prenom as appellation, p.Date_naiss, p.Lieu_naiss, p.Dates_vie, p.Date_mort, p.Profession, p.Domaine 
FROM "20170907_persovd" p 
where Nom = 'Vallotton' --'André'
and p.Prenom = 'Paul'
order by Dates_vie ;



/*
 * Distribution des genres
*/

SELECT p.Sexe, count(*) as number
FROM "20170907_persovd" p 
group by p.Sexe ;



/*
 * Distribution des années de naissance
*/


SELECT p.Date_naiss, count(*) as number
FROM "20170907_persovd" p 
group by p.Date_naiss ;

select *
FROM "20170907_persovd" p 
where Date_naiss = 902 -- 14


select date_naiss, *
FROM "20170907_persovd" p 
where Date_naiss > 750
and Date_naiss < 2010


select 
	case 
		when date_naiss > 750 AND Date_naiss < 1401
		then 'moyen-age'
		when date_naiss > 1400 AND Date_naiss < 1551
		then 'renaissance'
		when date_naiss > 1550 AND Date_naiss < 1771
		then 'ancien-regime'
		when date_naiss > 1770 AND Date_naiss < 1880
		then '19-siecle'
		when date_naiss > 1881 
		then 'epoque-contemporaine'
	end epoque
FROM "20170907_persovd" p 
where Date_naiss > 750
and Date_naiss < 2010;

with epoque as (
select 
	case 
		when date_naiss > 750 AND Date_naiss < 1401
		then '01-moyen-age'
		when date_naiss > 1400 AND Date_naiss < 1551
		then '02-renaissance'
		when date_naiss > 1550 AND Date_naiss < 1771
		then '03-ancien-regime'
		when date_naiss > 1770 AND Date_naiss < 1881
		then '04-19-siecle'
		when date_naiss > 1880 AND Date_naiss < 1951
		then '05-20-siecle'
		when date_naiss > 1950 
		then '06-epoque-contemporaine'
	end epoque
FROM "20170907_persovd" p 
where Date_naiss > 750
and Date_naiss < 2010)
select epoque, count(*) as number
from epoque 
group by epoque;


/*
 * Occupations
 */


SELECT occupation, count(*) as number
FROM t_person_occupation
group by occupation 
order by number desc;


SELECT occupation, count(*) as number
FROM t_person_occupation
group by occupation 
having occupation like '%criv%';

-- créer la table des métiers
CREATE TABLE occupation (
	pk_occupation INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT,
	definition TEXT,
	notes TEXT
);


SELECT occupation, count(*) as number
FROM t_person_occupation
group by occupation 
order by number desc;


SELECT occupation, count(*) as number
FROM t_person_occupation
group by occupation 
having occupation like '%ensei%'
order by number desc;


/*
 * Ajouter les métiers
 * 
 * Métiers traités: écrivain, enseignant
 */

SELECT Numero, Nom , occupation , fk_occupation 
FROM t_person_occupation
where occupation like '%ensei%';

update t_person_occupation set fk_occupation = 2
where occupation like '%ensei%';





/*
 * Domaines
 */

SELECT domain, count(*) as number
FROM t_person_domain
group by domain
having domain like 'Photo%';
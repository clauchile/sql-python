select * from cities;
select * from countries;
select * from languages;
select name as Pais, language as Lengua, percentage as Porcentaje from countries join languages on countries.id = languages.country_id WHERE language = 'Slovene'
order by porcentaje desc;
/*¿Qué consulta ejecutarías para mostrar el número total de ciudades para cada país? Su consulta debe devolver
 el nombre del país y el número total de ciudades. Tu consulta debe organizar el resultado por el número de 
 ciudades en orden descendente. (3)*/
select p.name, COUNT(*) 
from countries p join cities c on p.id = c.country_id
group by p.name ORDER BY count(*)desc;
/*3. ¿Qué consulta harías para obtener todas las ciudades de México con una población de más de 500,000? 
Tu consulta debe organizar el resultado por población en orden descendente. (1)*/

select ciudad.name, ciudad.population, ciudad.country_id
from countries pais 
join cities ciudad on pais.id = ciudad.country_id
where pais.name = "Mexico" AND ciudad.population > 500000
order by ciudad.population desc;

/*4. ¿Qué consulta ejecutarías para obtener todos los idiomas en cada país con un porcentaje superior al 89%? 
Tu consulta debe organizar el resultado por porcentaje en orden descendente. (1)*/

select p.name, i.language, i.percentage 
from countries p 
join languages i on p.id = i.country_id where i.percentage  >89
order by i.percentage desc;

/*5. ¿Qué consulta haría para obtener todos los países con un área de superficie inferior a 501 
y una población superior a 100,000? (2)*/

select p.name, p.surface_area, p.population 
from countries p where p.surface_area < 501 and 
p.population > 100000;

/*6. ¿Qué consulta harías para obtener países con solo Monarquía Constitucional con un capital superior a 200
 y una esperanza de vida superior a 75 años? (1)*/

SELECT p.NAME, p.government_form, p.capital, p.life_expectancy
from countries p where p.government_form ='Constitutional Monarchy' and p.capital > 200 and 
p.life_expectancy > 75;

/*7. ¿Qué consulta harías para obtener todas las ciudades de Argentina dentro del distrito de Buenos Aires y 
tener una población superior a 500,000? 
La consulta debe devolver el nombre del país, el nombre de la ciudad, el distrito y la población. (2)*/

select p.name, c.name, c.district, c.population 
from countries p join cities c 
on p.id = c.country_id 
where p.name = 'Argentina' and c.district = 'Buenos Aires' and c.population >= 500000;

/*8. ¿Qué consulta harías para resumir el número de países en cada región? 
La consulta debe mostrar el nombre de la región y el número de países. 
Además, la consulta debe organizar el resultado por el número de países en orden descendente. (2)*/

select c.region, count(c.name) 
from countries c
group by c.region ORDER BY count(c.name)desc;
 


 
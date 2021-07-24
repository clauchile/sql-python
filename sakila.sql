/*1. ¿Qué consulta ejecutarías para obtener todos los clientes dentro 
de city_id = 312? Su consulta debe devolver el nombre, apellido, 
correo electrónico y dirección del cliente.*/
select * from city;
select * from actor;
select * from customer;
select * from address;

select c.city_id, c.city, cus.first_name, cus.last_name, cus.email
from city c 
join address ad on c.city_id = ad.city_id
join customer cus on ad.address_id = cus.address_id
where c.city_id = 312;

/*2. ¿Qué consulta harías para obtener todas las películas de comedia? 
Su consulta debe devolver el título de la película, la descripción, 
el año de estreno, la calificación, las características especiales y 
el género (categoría).*/
select * from film_category;
select *from film;
select * from category;
select f.title, f.description, f.release_year, f.rating, f.special_features, cat.name
from category cat 
join film_category fc on cat.category_id = fc.category_id 
join film f on f.film_id = fc.film_id
where cat.name = 'comedy';
/*3. ¿Qué consulta harías para obtener todas las películas 
unidas por actor_id = 5? Su consulta debe devolver la 
identificación del actor, el nombre del actor, el título de la película, 
la descripción y el año de lanzamiento.*/
SELECT * FROM ACTOR;
SELECT * FROM FILM;
SELECT * FROM FILM_ACTOR;

SELECT a.actor_id, concat_ws(" ",a.first_name,  a.last_name) as Nombre , f.film_id, f.title, 
f.description, f.release_year
FROM actor a
JOIN film_actor fa on a.actor_id = fa.actor_id
JOIN film f on f.film_id = fa.film_id
where a.actor_id = 5 ;

/*4. ¿Qué consulta ejecutaría para obtener todos los clientes en store_id = 1 
y dentro de estas ciudades (1, 42, 312 y 459)? Su consulta debe devolver 
el nombre, apellido, correo electrónico y dirección del cliente.*/
select * from customer;
select * from store;
select * from address;

SELECT c.store_id, c.first_name, c.last_name, c.email , a.address
FROM store s 
join customer c on s.store_id = c.store_id
join address a on a.address_id = c.address_id
where s.store_id = 1 AND a.city_id IN (1,42,312,459);


/*5. ¿Qué consulta realizarías para obtener todas las películas con una
 "calificación = G" y "característica especial = detrás de escena", 
 unidas por actor_id = 15? Su consulta debe devolver el título de la
 película, la descripción, el año de lanzamiento, la calificación y 
 la función especial. Sugerencia: puede usar la función LIKE para obtener 
 la parte 'detrás de escena'.*/
 
SELECT * FROM FILM_CATEGORY;
SELECT * FROM CATEGORY;
SELECT * FROM FILM;
SELECT * FROM FILM_actor;

SELECT f.title, f.description, f.release_year, f.rating, f.special_features
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON a.actor_id = fa.actor_id
WHERE f.rating = 'G' AND a.actor_id = 15
AND f.special_features LIKE '%Behind the Scenes' ;

/*6. ¿Qué consulta harías para obtener todos los actores que se 
unieron en el film_id = 369? Su consulta debe devolver film_id, 
title, actor_id y actor_name.*/

SELECT * FROM FILM;
SELECT * FROM FILM_actor;
SELECT * FROM actor;

SELECT f.film_id, f.title, a.actor_id ,concat_ws(" ", a.first_name, a. last_name) as Nombre_del_actor
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.film_id = 369;

/*7. ¿Qué consulta harías para obtener todas las películas dramáticas 
con una tarifa de alquiler de 2.99? Su consulta debe devolver el 
título de la película, la descripción, el año de estreno, la calificación, 
las características especiales y el género (categoría).*/

SELECT f.film_id,f.title, f.description, f.description, f.release_year,f.rating, f.rental_rate, f.special_features -- fc.category_id
FROM actor a 
JOIN film_actor fa on fa.actor_id = a.actor_id
JOIN film f on f.film_id = fa.film_id
JOIN film_category fc on f.film_id = fc.film_id
JOIN category c on c.category_id = fc.category_id
where c.name = 'Drama' and f.rental_rate= 2.99
group by f.film_id;

/*8. ¿Qué consulta harías para obtener todas las películas de acción 
a las que se une SANDRA KILMER? Su consulta debe devolver el título
 de la película, la descripción, el año de estreno, la calificación, 
 las características especiales, el género (categoría) y el nombre y 
 apellido del actor.*/
 
SELECT a.actor_id,  concat_ws(" ",a.first_name, a.last_name) as Nombre_del_actor, f.film_id, f.title, f.description, f.release_year, 
f.rating, f. special_features
FROM actor a 
JOIN film_actor fa on fa.actor_id = a.actor_id
JOIN film f on f.film_id = fa.film_id
JOIN film_category fc on f.film_id = fc.film_id
JOIN category c on c.category_id = fc.category_id
where a.first_name = 'SANDRA' and a.last_name = 'KILMER' and c.name = 'Action'

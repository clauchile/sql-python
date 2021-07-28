select * from users;
select * from friendships;

SELECT users.first_name, users.last_name,amigo.first_name as nombre_amigo,amigo.last_name as apellido_amigo
FROM friendships
JOIN users ON friendships.user_id = users.id
JOIN users as amigo ON amigo.id = friendships.friend_id;

/*Devuelva a todos los usuarios que son amigos de Kermit, asegúrese de que sus nombres se muestren en los resultados.*/
SELECT  users.first_name as nombre_amigo, users.last_name as apellido_amigo
/*amigo.first_name,amigo.last_name*/
FROM friendships
JOIN users ON friendships.user_id = users.id
JOIN users as amigo ON amigo.id = friendships.friend_id
where amigo.first_name = 'Kermit'; /*friendships.friend_id = 4;*/

/*3.- Devuelve el recuento de todas las amistades.*/

SELECT users.first_name as Nombre,COUNT(users.first_name) AS Total_de_amistades
FROM friendships
JOIN users ON friendships.user_id = users.id
JOIN users as amigo ON amigo.id = friendships.friend_id
group by users.first_name asc;


/*Descubre quién tiene más amigos y devuelve el recuento de sus amigos.*/
SELECT users.first_name as Nombre, count(amigo.first_name) AS Total_de_amistades
FROM friendships
JOIN users ON friendships.user_id = users.id
JOIN users as amigo ON amigo.id = friendships.friend_id
/*where  max(user.first_name);*/
group by Nombre
limit 1;


/*Crea un nuevo usuario y hazlos amigos de Eli Byers, Kermit The Frog y Marky Mark.*/
SET
@eli = (SELECT ID FROM USERS WHERE FIRST_NAME = 'eli'),
@kermit = (SELECT id FROM users WHERE first_name = 'Kermit'),
@marki = (SELECT id FROM users WHERE first_name = 'marky'),
@nuevo = (SELECT MAX(id)+1 FROM	 users);

INSERT INTO users (first_name,last_name,created_at) VALUES ('Claudio','Orellana',NOW());
INSERT INTO friendships (user_id, friend_id,created_at) VALUES (@eli,@nuevo,NOW());
INSERT INTO friendships (user_id, friend_id,created_at) VALUES (@kermit, @nuevo,NOW());
INSERT INTO friendships (user_id, friend_id,created_at) VALUES (@marky, @nuevo,NOW());



/*Devuelve a los amigos de Eli en orden alfabético.*/
Select amigo.first_name as nombre_amigo, amigo.last_name as apellido_amigo
from friendships
join users 
on friendships.user_id = users.id
join users as amigo 
on friendships.friend_id = amigo.id
where users.first_name = 'Eli' 
order by users.first_name asc;

/*Eliminar a Marky Mark de los amigos de Eli.*/
DELETE from friendships WHERE user_id = 2 AND friend_id = 5;



/*Devuelve todas las amistades, mostrando solo el nombre y apellido de ambos amigos*/
Select users.first_name as Nombre, users.last_name as Apellido, amigo.first_name as nombre_amigo
, amigo.last_name as apellido_amigo
from friendships
join users 
on friendships.user_id = users.id
join users as amigo 
on friendships.friend_id = amigo.id;

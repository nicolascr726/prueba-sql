-- 1. Revisa el tipo de relación y crea el modelo correspondiente. Respeta las claves primarias, foráneas y tipos de datos

create table "peliculas" (
"id" integer,
"nombre" Varchar(255),
"año" Integer,
 primary key ("id")
);

create table "tags" (
"id" integer,
"tag" Varchar(32),
primary key ("id")
);

create table "peliculastags" (
"peliculas_id" integer,
"tags_id" integer,
foreign key ("peliculas_id") references
"peliculas" (id),
foreign key ("tags_id") references
"tags" (id)
);

select * from peliculas;
select * from tags;
select * from peliculastags;

-- 2. Inserta 5 películas y 5 tags; la primera película debe tener 3 tags asociados, la segunda película debe tener 2 tags asociados

insert into peliculas (id, nombre, año) 
values (1, 'Sonic the hedgehog', '2020');
insert into peliculas (id, nombre, año) 
values (2, 'La Máscara', '1994');
insert into peliculas (id, nombre, año) 
values (3, 'Sonic the hedgehog 2', '2022');
insert into peliculas (id, nombre, año) 
values (4, 'Todo Poderoso', '2003');
insert into peliculas (id, nombre, año) 
values (5, 'Ironman 2', '2010');

insert into tags (id, tag) 
values (1, 'Acción');
insert into tags (id, tag) 
values (2, 'Aventura');
insert into tags (id, tag) 
values (3, 'Ciencia Ficción');
insert into tags (id, tag) 
values (4, 'Comedia');
insert into tags (id, tag) 
values (5, 'Fantasía');

insert into peliculastags (peliculas_id, tags_id) 
values (1, 1);
insert into peliculastags (peliculas_id, tags_id) 
values (1, 2);
insert into peliculastags (peliculas_id, tags_id) 
values (1, 3);
insert into peliculastags (peliculas_id, tags_id) 
values (2, 4);
insert into peliculastags (peliculas_id, tags_id) 
values (2, 5);
insert into peliculastags (peliculas_id) 
values (3);
insert into peliculastags (peliculas_id) 
values (4);
insert into peliculastags (peliculas_id) 
values (5);

-- 3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.

select peliculas.id as "Id", peliculas.nombre as "Película", count(peliculastags.tags_id) as "Cantidad De Tags" 
from peliculas right join peliculastags on id = peliculastags.peliculas_id 
group by "id", "Película" order by "id";

-- 4. Crea las tablas correspondientes respetando los nombres, tipos, claves primarias y foráneas y tipos de datos

create table "usuarios" (
"id" integer,
"nombre" Varchar(255),
"edad" Integer,
 primary key ("id")
);

create table "preguntas" (
"id" integer,
"pregunta" Varchar(255),
"respuesta_correcta" varchar,
primary key ("id")
);

create table "respuestas" (
"id" integer, primary key ("id"),
"respuesta" varchar(255),
"usuario_id" integer,
"pregunta_id" integer,
foreign key ("usuario_id") references
"usuarios" ("id"),
foreign key ("pregunta_id") references
"preguntas" ("id")
);

select * from usuarios;
select * from preguntas;
select * from respuestas;

-- 5. Agrega 5 usuarios y 5 preguntas 

insert into usuarios (id, nombre, edad) 
values (1, 'José Salamanca', 20);
insert into usuarios (id, nombre, edad) 
values (2, 'Eddie Vera', 23);
insert into usuarios (id, nombre, edad) 
values (3, 'Chris Winters', 30);
insert into usuarios (id, nombre, edad) 
values (4, 'Dayanne Ortega', 19);
insert into usuarios (id, nombre, edad) 
values (5, 'Omar Thompson', 34);

insert into preguntas (id, pregunta, respuesta_correcta) 
values (1, '¿Qué es más rapido, un tren bala o un auto convertible?', 'el tren bala');
insert into preguntas (id, pregunta, respuesta_correcta) 
values (2, '¿Qué es más frio, un trozo de hielo pequeño o una piedra en un volcan?', 'el trozo de hielo');
insert into preguntas (id, pregunta, respuesta_correcta) 
values (3, '¿Qué es lo que gestiona SQL?', 'bases de datos');
insert into preguntas (id, pregunta, respuesta_correcta) 
values (4, '¿Qué es más rapido, un avion supersonico o un ferrari?', 'el avion supersonico');
insert into preguntas (id, pregunta, respuesta_correcta) 
values (5, '¿Qué es más pesado, un kilo de piedras o un kilo de plumas?', 'ambos pesan lo mismo');

-- a. La primera pregunta debe estar respondida correctamente dos veces, por dos usuarios diferentes.

insert into respuestas (id, respuesta, usuario_id, pregunta_id) 
values (1, 'el tren bala', 1, 1);
insert into respuestas (id, respuesta, usuario_id, pregunta_id) 
values (2, 'el tren bala', 3, 1);

-- b. La segunda pregunta debe estar contestada correctamente solo por un usuario.

insert into respuestas (id, respuesta, usuario_id, pregunta_id) 
values (3, 'el trozo de hielo', 5, 2);

-- c. Las otras tres preguntas deben tener respuestas incorrectas.

insert into respuestas (id, respuesta, usuario_id, pregunta_id) 
values (4, 'codigos', 4, 3);
insert into respuestas (id, respuesta, usuario_id, pregunta_id) 
values (5, 'el ferrari', 2, 4);
insert into respuestas (id, respuesta, usuario_id, pregunta_id) 
values (6, 'el kilo de piedras', 5, 5);

-- 6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta).
select usuarios.id, usuarios.nombre as "usuario", count(preguntas.respuesta_correcta) as "respuestas correctas"
from usuarios left join respuestas on usuarios.id = respuestas.usuario_id
left join preguntas on respuestas.pregunta_id = preguntas.id where respuestas.respuesta = preguntas.respuesta_correcta
group by usuarios.id, "usuario";


-- 7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios respondieron correctamente.

select usuarios.id, usuarios.nombre as "usuario", count(preguntas.respuesta_correcta) as "respuestas correctas"
from usuarios left join respuestas on usuarios.id = respuestas.usuario_id
left join preguntas on respuestas.respuesta = preguntas.respuesta_correcta
group by usuarios.id, "usuario" order by usuarios.id asc;

-- 8. Implementa un borrado en cascada de las respuestas al borrar un usuario. Prueba la implementación borrando el primer usuario.

ALTER TABLE respuestas ADD FOREIGN KEY
(usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE;

delete from respuestas where usuario_id = 1;

select * from respuestas;

-- 9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.
alter table usuarios add constraint chk_edad check (edad >= 18);

insert into usuarios (id, nombre, edad) 
values (6, 'usuario nuevo', 17); 

-- 10. Altera la tabla existente de usuarios agregando el campo email. Debe tener la restricción de ser único.

ALTER TABLE usuarios add column email varchar, add constraint uq_email unique (email);

select * from usuarios;


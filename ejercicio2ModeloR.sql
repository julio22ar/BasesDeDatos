use ejercicio2ModeloR
create database ejercicio2ModeloR

if OBJECT_ID('hotel')is not null
drop table hotel

--creando tabla hotel---------------------------------
create table hotel(
id int primary key,--declarando pk
nombre varchar(20),
direccion varchar(30),
telefono varchar(12),
id_hotel int,
);
--creando la recursividad
alter table hotel add constraint fk_hotel_hotel foreign key(id_hotel) references hotel(id);
--insertando datos
insert into hotel (id,nombre, direccion, telefono,id_hotel)values(1,'La gran quijada', '4ta avenidad sureste', '+50322931939',1)
--El id pk y el id_hotel FK deben tener el mismo valor CREOOO YOOOO

--creando y declarando la llave foranea
create table habitacion(
id int primary key,
numero int,
precio float,
id_hotel int,
);
 
--creando la fk de hotel en habitacion
alter table habitacion add constraint fk_hotel foreign key(id_hotel) references hotel(id)
--CREANDO TABLA CLIENTE-------------------------------
create table cliente(
id int primary key,
nombre varchar(50),
documento varchar(15),
);
insert into cliente(id, nombre, documento) values(1,'Julio','06557559-9')
--CREANDO TABLA COMENTARIO-------------------------
create table comentario(
id int primary key,
comentario varchar(100),
calificacion int,
id_hotel int,
id_cliente int,
);
--insertando datos en  COMENTARIO
insert into comentario (id, comentario, calificacion, id_hotel,id_cliente) values(1,'Muy buen hotel',5,1,1)
--creando FKs de hotel y cliente en comentario
alter table comentario add constraint fk_hotelC foreign key(id_hotel) references hotel(id)
alter table comentario add constraint fk_cliente foreign key(id_cliente) references cliente(id)

--CREANDO TABLA RESERVA---------------------------
create table reserva(
id int primary key,
checkin date,
checkout date,
id_cliente_reserva int,--Aqui solo creo el espacio PARA LAS FKs
id_habitacion int,
);
--creando las FKs
alter table reserva add constraint fk_clienteR foreign key(id_cliente_reserva) references cliente(id)
--EN los parentesis de foreign key va el nombre de la columna que cree en la tabla														
alter table reserva add constraint fk_habitacionR foreign key(id_habitacion) references habitacion(id)
--en esta instruccion lo que hago es crear las FKs

--------CREANDO TABLA SERVICIO--------------
create table servicio(
id int primary key,
nombre varchar(20),
precio float,
descripcion varchar(100)
);
--insertando datos en servicio
insert into servicio(id, nombre,precio,descripcion) values(1,'tv satelital', 20.80,'Todos los canales del mundo')
select * from servicio
--==CREANDO RELACION N:N Con reserva y servicio===------------
create table extra(
id_servicio int, 
id_reserva int,
primary key (id_reserva, id_servicio),
foreign key(id_reserva) references reserva(id),
foreign key (id_servicio) references servicio(id),
);

SELECT 
    FK.name AS 'Nombre de la FK',
    SCHEMA_NAME(FK.schema_id) AS 'Esquema',
    OBJECT_NAME(FK.parent_object_id) AS 'Tabla Padre',
    COL_NAME(FKC.parent_object_id, FKC.parent_column_id) AS 'Columna Padre',
    OBJECT_NAME(FK.referenced_object_id) AS 'Tabla Referenciada',
    COL_NAME(FKC.referenced_object_id, FKC.referenced_column_id) AS 'Columna Referenciada'
FROM 
    sys.foreign_keys AS FK
INNER JOIN 
    sys.foreign_key_columns AS FKC ON FK.object_id = FKC.constraint_object_id
ORDER BY 
    'Esquema', 'Tabla Padre', 'Nombre de la FK';

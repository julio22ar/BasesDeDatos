create database JulioRodriguez00163922
use JulioRodriguez00163922

--====CREANDO TABLAS===----
create table proyecto(
codigo int primary key,
nombre varchar(20)not null,
presupuesto money not null default 0,
id_coordinador int not null-----FK
);
--verificando configuracion de la tabla
exec sp_columns proyecto
-------
create table ejecucion(
id int primary key,
codigo_proyecto int not null, ----FK
-----FK, validar que el valor este entre 1 y 262
id_municipio int not null check (id_municipio>=1 and id_municipio<=262),
--validar que la fecha inicio del proyecto no sea anterior a la fecha actual
fecha_inicio varchar(10) not null check(fecha_inicio>'05/15/2023'), 

--ASI ERRAAA  fecha_inicio date not null check(fecha_inicio >getdate())

fecha_fin date null,
);

create table municipio(
id int primary key,
nombre varchar(20) not null,
);

create table asignacion(
codigo_empleado int,
codigo_proyecto int
primary key(codigo_empleado, codigo_proyecto)

);
/*En esta tabla hago uso de las EXPRESIONES REGULARES*/
create table empleado(
codigo int primary key,
nombre varchar(20)not null,
correo_electronico varchar(20) unique,
--VALIDAR que el valor a insertar este compuesto por 7 digitos 0-9 y los primeros dos no pueden ser 00
numero_isss char null,check (numero_isss like '[1-9][1-9][0-9][0-9][0-9][0-9][0-9]'),
id_categoria int not null---FK
);

create  table telefono (
id int primary key,
codigo_empleado int ---FK,
);

create table categoria(
id int primary key,
nombre varchar(20),
descripcion varchar(100)
);

create table objetivo(
id int primary key,
titulo varchar(20)not null,
descripcion varchar(100)null,
id_proyecto int not null,---FK
);

create table metrica(
id int primary key,
titulo varchar(20) not null,
tipo_metrica bit not null,
fecha_cumplimiento date null,
id_objetivo int not null,----FK
id_empleado int null
);

---=====FKs===---
alter table proyecto add constraint fk_coordinador foreign key(id_coordinador) references empleado(codigo)
alter table asignacion add constraint fk_codigo_empleado foreign key(codigo_empleado) references empleado(codigo);
alter table asignacion add constraint fk_codigo_proyecto foreign key(codigo_proyecto) references proyecto(codigo);
alter table ejecucion add constraint fk_codigo_proyecto_ejecucion foreign key(codigo_proyecto) references proyecto(codigo);
alter table objetivo add constraint fk_proyecto_objetivo foreign key(id_proyecto) references proyecto(codigo);
alter table telefono add constraint fk_empleado foreign key(codigo_empleado) references empleado(codigo);
alter table empleado add constraint fk_empleado_categoria foreign key(id_categoria) references categoria(id);
alter table metrica add constraint fk_metrica foreign key(id_empleado) references empleado(codigo);
alter table ejecucion add constraint fk_codigo_municipio foreign key(id_municipio) references municipio(id);
alter table metrica add constraint fk_objetivo foreign key(id_objetivo) references objetivo(id);



---INSERTANDO VALORES PRUEBA----
insert into municipio(id,nombre) values(1,'San Salvador')
insert into municipio(id,nombre) values(2,'Soyapango')
insert into municipio(id,nombre) values(3,'San Jacinto')
insert into categoria(id, nombre, descripcion) values(1,'Social','Ayuda humanitaria')
insert into categoria values(2,'Tecnica','Reparacion de vehiculos')
insert into categoria values(3,'Tecnica','Reparacion De Computadoras')
select * from categoria

 










 


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
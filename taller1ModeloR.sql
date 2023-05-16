create database taller1ModeloR
use taller1ModeloR

if OBJECT_ID('vacaciones')is not null
drop table vacaciones

------======CREANDO TABLAS SIN NORMALIZAR====---------
create table sitio(
id int primary key,
nombre varchar(20),
id_tipo int,-----FK----
id_municipio int, -----FK----
id_cooperativa int,-----FK----
);


create table resennia(
id int primary key,
comentario varchar(100),
calificacion int,
fecha date,
hora time,
id_visitante int,-----FK----
id_sitio int,-----FK----
);

create table atractivo(
id int primary key,
nombre varchar(20),
resennia varchar(100),
fotografia VARBINARY(MAX),
id_tipo int,-----FK----
id_sitio int,-----FK----
);


create table cooperativa(
id int primary key,
nombre varchar(20),
direccion varchar(30),
telefono varchar(12),
id_representante int,-----FK----
financiamiento varchar(30),
correo varchar(30),
);

create table consulta(
id int primary key,
fecha date,
descripcion varchar(50),
calificacion int,
id_medio int,-----FK----
id_visitante int,-----FK----
id_cooperativa int-----FK----
);

create table visitante (
id int primary key,
documento_identidad int,
nombre varchar(20),
fotografia varbinary(max),
email varchar(30),
id_pais int-----FK----
);

create table itinerario(
id int primary key,
id_atractivo int,-----FK----
id_tour int,-----FK----
hr_llegada time,
hr_salida time,
);

create table tour(
id int primary key,
nombre varchar(20),
descripciom varchar(50),
precio float,
id_punto_encuentro int,-----FK----
id_empresa int-----FK----
);

create table empresa(
id int primary key,
nombre varchar(20),
id_representante int,-----FK----
ubicacion varchar(30),
telefono varchar(12),
pagina_web varchar(20)
);

----======TABLAS NORMALIZADAS Y DE ULTIMO TABLAS RELACIONES====------
create table tipo_sitio(
id int primary key,
tipo varchar(10)
);
/**la tabla tipo_sitio la hice el dia anterior, explicandole a raul como se hacian la relaciones
entonces, al final la borre, ya existe por eso da error, pero la he dejado solo para 
constatar que ya la cree*/

create table municipio(
id int primary key,
nombre varchar(20)
);

create table galeria (
id int primary key,
fotografia varbinary(max),
id_sitio int----FK
);

create table palabra_clave(
id int primary key,
palabra_clave varchar(10),
id_sitio int, ---FK
);

create table medio(
id int primary key,
medio varchar(10),
);
create table tipo_atractivo(
id int primary key,
tipo varchar(10)
);
create table representante(
id int primary key,
nombre varchar(30),
);

create table red_social(
id int primary key,
red_social varchar(20),
);

create table cuenta(
id int primary key,
id_visitante int, ---FK
id_red_social int, ---FK
);
create table pais(
id int primary key,
nombre varchar(20),
);

create table punto_encuentro(
id int primary key,
nombre varchar(20)
);

create table asistencia(
id_visitante int,
id_tour int
);

create table reserva(
id_visitante int,
id_tour int,
cupo_reservado varchar(10)
);

----======CREANDO FKs==========----
/    MOSTRANDO TODAS LAS FKs 
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
	**/
alter table sitio add constraint fk_municipio foreign key(id_municipio) references municipio(id)
alter table galeria add constraint fk_sitio foreign key(id_sitio) references sitio(id)
alter table palabra_clave add constraint fk_sitio_palabra_clave foreign key(id_sitio) references sitio(id)
alter table atractivo add constraint fk_tipo_atractivo foreign key(id_tipo) references tipo_atractivo(id)
	









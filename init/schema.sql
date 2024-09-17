CREATE DATABASE IF NOT EXISTS proyectos;
use proyectos;
/* crear tablas */
create table if not exists clientes (
    idcliente int,
    nombre varchar(100),
    email varchar(100),
    provincia varchar(50)
);
create table if not exists integrantes (
    idintegrante int,
    nombre varchar(100),
    email varchar(100),
    provincia varchar(50)
);
create table if not exists proyectos (
    idproyecto int,
    idcliente int,
    fechaini date,
    fechafin date,
    estado char(1),
    idlider int
);
create table if not exists participantes (
    idproyecto int,
    idintegrante int,
    fechadesde date,
    fechahasta date
);
create table if not exists etapas (
    idetapa int,
    descripcion varchar(100),
    tipo char(2)
);
create table if not exists detallehoras (
    idproyecto int,
    fecha date,
    idetapa int,
    detalle varchar(200),
    idintegrante int,
    horas int
);
/* eliminar objetos */
delete from detallehoras
where idproyecto < 100;
delete from etapas
where idetapa < 100;
delete from participantes
where idproyecto < 100;
delete from proyectos
where idproyecto < 100;
delete from integrantes
where idintegrante < 100;
delete from clientes
where idcliente < 100;
drop function pIntegrante;
drop view v_misHoras;
drop view v_horasTotales;
alter table detallehoras drop constraint detallehorasproyectosfk;
alter table detallehoras drop constraint detallehorasetapasfk;
alter table detallehoras drop constraint detallehorasintegrantesfk;
alter table participantes drop constraint participantesintegrantesfk;
alter table participantes drop constraint participantesproyectosfk;
alter table proyectos drop constraint proyectosclientesfk;
alter table proyectos drop constraint proyectosintegrantesfk;
Alter table clientes drop primary key;
Alter table integrantes drop primary key;
Alter table proyectos drop primary key;
Alter table participantes drop primary key;
Alter table etapas drop primary key;
Alter table detallehoras drop primary key;
Alter table clientes drop index emailUQ;
Alter table detallehoras drop index detallehorasetapas;
Alter table detallehoras drop index detallehorasproyectos;
Alter table detallehoras drop index detallehorasintegrantes;
Alter table participantes drop index participantesintegrantes;
Alter table participantes drop index participantesproyectos;
Alter table proyectos drop index proyectosclientes;
Alter table proyectos drop index proyectosintegrantes;
alter table clientes drop constraint clientesemailchk;
/* crear pk */
Alter table clientes
add constraint clientesPK primary key (idcliente);
Alter table integrantes
add constraint integrantesPK primary key (idintegrante);
Alter table proyectos
add constraint proyectosPK primary key (idproyecto);
Alter table participantes
add constraint participantesPK primary key (idproyecto, idintegrante, fechadesde);
Alter table etapas
add constraint etapasPK primary key (idetapa);
Alter table detallehoras
add constraint detallehorasPK primary key (idproyecto, fecha, idetapa, idintegrante);
/* crear indices  */
alter table clientes
add unique index emailUQ (email);
alter table detallehoras
add index detallehorasetapas (idetapa);
alter table detallehoras
add index detallehorasproyectos (idproyecto);
alter table detallehoras
add index detallehorasintegrantes (idintegrante);
alter table participantes
add index participantesintegrantes (idintegrante);
alter table participantes
add index participantesproyectos (idproyecto);
alter table proyectos
add index proyectosclientes (idcliente);
alter table proyectos
add index proyectosintegrantes (idlider);
/* crear foreign keys */
alter table detallehoras
add constraint detallehorasproyectosfk foreign key (idproyecto) references proyectos(idproyecto);
alter table detallehoras
add constraint detallehorasetapasfk foreign key (idetapa) references etapas(idetapa);
alter table detallehoras
add constraint detallehorasintegrantesfk foreign key (idintegrante) references integrantes(idintegrante);
alter table participantes
add constraint participantesintegrantesfk foreign key (idintegrante) references integrantes(idintegrante);
alter table participantes
add constraint participantesproyectosfk foreign key (idproyecto) references proyectos(idproyecto);
alter table proyectos
add constraint proyectosclientesfk foreign key (idcliente) references clientes(idcliente);
alter table proyectos
add constraint proyectosintegrantesfk foreign key (idlider) references integrantes(idintegrante);
/* crear checks constrainsts */
alter table clientes
add constraint clientesemailchk check(email <> '');
/* cargar datos */
insert into etapas (idetapa, descripcion, tipo)
values(1, 'Analisis', 'D');
insert into etapas (idetapa, descripcion, tipo)
values(2, 'Diseño', 'D');
insert into etapas (idetapa, descripcion, tipo)
values(3, 'Testing', 'QA');
insert into etapas (idetapa, descripcion, tipo)
values(4, 'Deploy', 'I');
insert into clientes (idcliente, nombre, email, provincia)
values (1, "Rosa mosqueta", "rosa@gmail.com", "BA");
insert into clientes (idcliente, nombre, email, provincia)
values (2, "La ponderosa", "laponderosa@gmail.com", "ER");
insert into clientes (idcliente, nombre, email, provincia)
values (3, "Muñeca brava", "munie@gmail.com", "BA");
insert into integrantes (idintegrante, nombre, email, provincia)
values (1, "Jose", "jose@gmail.com", "BA");
insert into integrantes (idintegrante, nombre, email, provincia)
values (2, "Isabel", "isabel@gmail.com", "BA");
insert into proyectos (
        idproyecto,
        idcliente,
        fechaini,
        fechafin,
        estado,
        idlider
    )
values (1, 1, '2000-01-01', '2026-01-01', 'A', 1);
insert into proyectos (
        idproyecto,
        idcliente,
        fechaini,
        fechafin,
        estado,
        idlider
    )
values (2, 1, '2001-01-01', '2028-01-01', 'A', 1);
insert into participantes (idproyecto, idintegrante, fechadesde)
values(1, 2, '2024-1-1');
insert into participantes (idproyecto, idintegrante, fechadesde)
values(2, 2, '2024-1-1');
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-2-1', 1, 'Analizar cliente', 1, 10);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-2-2', 1, 'Analizar cliente', 1, 10);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-2-3', 1, 'Analizar cliente', 1, 8);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-3-1', 1, 'Analizar cliente', 1, 5);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-3-2', 1, 'Analizar cliente', 1, 4);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-1-1', 1, 'Analizar cliente', 2, 10);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-2-2', 1, 'Analizar cliente', 2, 9);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-3-3', 1, 'Analizar cliente', 2, 7);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-4-1', 1, 'Analizar cliente', 2, 5);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (1, '2024-5-2', 1, 'Analizar cliente', 2, 9);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (2, '2024-2-1', 1, 'Analizar cliente', 2, 15);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (2, '2024-3-4', 1, 'Analizar cliente', 2, 3);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (2, '2024-5-7', 1, 'Analizar cliente', 2, 7);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (2, '2024-6-1', 1, 'Analizar cliente', 2, 2);
insert into detallehoras (
        idproyecto,
        fecha,
        idetapa,
        detalle,
        idintegrante,
        horas
    )
values (2, '2024-7-2', 1, 'Analizar cliente', 2, 9);
create function pIntegrante() returns INTEGER DETERMINISTIC NO SQL return @pIntegrante;
CREATE VIEW `v_misHoras` AS
SELECT dh.*,
    e.tipo,
    e.descripcion as etapa,
    p.fechaini,
    p.fechafin,
    p.estado,
    c.nombre as cliente,
    c.provincia,
    i.nombre as integrante,
    l.nombre as lider
FROM detallehoras dh,
    etapas e,
    proyectos p,
    clientes c,
    integrantes i,
    integrantes l
where dh.idetapa = e.idetapa
    and dh.idproyecto = p.idproyecto
    and dh.idintegrante = i.idintegrante
    and p.idcliente = c.idcliente
    and p.idlider = l.idintegrante
    and dh.idintegrante = pIntegrante();
/*
 De esta manera puedo llamar a la anterior vista como si tuviese un parámetro
 select h.* 
 from (select @pIntegrante:=2 p) parm , misHoras h;
 */
CREATE VIEW `v_horasTotales` AS
SELECT dh.*,
    e.tipo,
    e.descripcion as etapa,
    p.fechaini,
    p.fechafin,
    p.estado,
    c.nombre as cliente,
    c.provincia,
    i.nombre as integrante,
    l.nombre as lider
FROM detallehoras dh,
    etapas e,
    proyectos p,
    clientes c,
    integrantes i,
    integrantes l
where dh.idetapa = e.idetapa
    and dh.idproyecto = p.idproyecto
    and dh.idintegrante = i.idintegrante
    and p.idcliente = c.idcliente
    and p.idlider = l.idintegrante;
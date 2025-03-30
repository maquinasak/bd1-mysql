use mega;
drop table detalles_pedido;
drop table pedidos;
drop table productos;
drop table clientes;

/* SHOW CREATE TABLE orders;*/

CREATE TABLE IF NOT EXISTS clientes (
            id INT AUTO_INCREMENT PRIMARY KEY,
            nombre VARCHAR(100),
            provincia VARCHAR(50),
            tipo varchar(10),
            email VARCHAR(100) UNIQUE
        );
        
CREATE TABLE IF NOT EXISTS productos (
            id INT AUTO_INCREMENT PRIMARY KEY,
            nombre VARCHAR(100),
            precio DECIMAL(10,2)
        );        

CREATE TABLE IF NOT EXISTS pedidos (
            id INT AUTO_INCREMENT PRIMARY KEY,
            cliente_id INT,
            fecha DATE            
        );

CREATE TABLE IF NOT EXISTS detalles_pedido (
            pedido_id INT,
            producto_id INT,
            cantidad INT,
            PRIMARY KEY (pedido_id, producto_id)
        );
        
/* La creación de claves foraneas crea índices */
Alter table pedidos add constraint fk_clientes
foreign key (cliente_id) references clientes(id);

Alter table detalles_pedido add constraint fk_pedidos_productos
foreign key (producto_id) references productos(id);

Alter table detalles_pedido add constraint fk_pedidos
foreign key (pedido_id) references pedidos(id);

/* cración de indices */

CREATE INDEX idx_clientes_prov ON clientes (provincia);


/*
delete from detalles_pedido where pedido_id =0;

select * from detalles_pedido dp where dp.pedido_id not in (select id from pedidos p where p.id = dp.pedido_id)
*/



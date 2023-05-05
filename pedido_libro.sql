CREATE SEQUENCE id_socio_sq;
CREATE SEQUENCE id_pedido_sq;
CREATE SEQUENCE id_detalle_pedido_sq;
CREATE SEQUENCE isbn_sq;
CREATE SEQUENCE id_coleccion_sq;
CREATE SEQUENCE id_libro_almacen_sq;
CREATE SEQUENCE id_almacen_sq;
CREATE SEQUENCE id_provincia_sq;
CREATE SEQUENCE id_poblacion_sq;

CREATE TABLE IF NOT EXISTS socio(
	
	id_socio integer default NEXTVAL('id_socio_sq'),
	telefono integer NOT NULL,
	avalista integer NOT NULL,
	DNI character varying UNIQUE NOT NULL ,
	nombre_apellidos character varying NOT NULL,
	id_poblacion integer NOT NULL,
	CONSTRAINT PK_socio PRIMARY KEY(id_socio)
	
);

CREATE TABLE IF NOT EXISTS pedido(
	
	id_pedido integer default NEXTVAL('id_pedido_sq'),
	forma_pago character varying NOT NULL,
	forma_envio character varying NOT NULL,
	id_socio integer NOT NULL,	
	CONSTRAINT PK_pedido PRIMARY KEY(id_pedido)
	
);

CREATE TABLE IF NOT EXISTS detalle_pedido(
	
	id_detalle_pedido integer default NEXTVAL('id_detalle_pedido_sq'),
	cantidad_ejemplares integer NOT NULL,
	id_pedido integer NOT NULL,
	isbn integer NOT NULL,	
	CONSTRAINT PK_detalle_pedido PRIMARY KEY(id_detalle_pedido)
	
);

CREATE TABLE IF NOT EXISTS libro(
	
	isbn integer default NEXTVAL('isbn_sq'),
	titulo character varying NOT NULL,
	autor character varying NOT NULL,
	editorial character varying NOT NULL,	
	id_coleccion integer NOT NULL,	
	CONSTRAINT PK_libro PRIMARY KEY(isbn)
	
);

CREATE TABLE IF NOT EXISTS coleccion(
	
	id_coleccion integer default NEXTVAL('id_coleccion_sq'),		
	num_volumen integer NOT NULL,	
	CONSTRAINT PK_coleccion PRIMARY KEY(id_coleccion)	
);

CREATE TABLE IF NOT EXISTS libro_almacen(
	
	id_libro_almacen integer default NEXTVAL('id_libro_almacen_sq'),
	stock integer NOT NULL,
	ISBN integer NOT NULL,
	id_almacen integer NOT NULL,		
	CONSTRAINT PK_libro_almacen PRIMARY KEY(id_libro_almacen)
	
);

CREATE TABLE IF NOT EXISTS almacen(
	
	id_almacen integer default NEXTVAL('id_almacen_sq'),
	nombre character varying NOT NULL,
	direccion  character varying NOT NULL,
	fecha_apertura date NOT NULL,
	id_provincia integer UNIQUE NOT NULL,
	CONSTRAINT PK_almacen PRIMARY KEY(id_almacen)	
);

CREATE TABLE IF NOT EXISTS provincia(
	
	id_provincia integer default NEXTVAL('id_provincia_sq'),
	nombre character varying NOT NULL,
	extension_metros integer NOT NULL,
	id_almacen integer NOT NULL,	
	CONSTRAINT PK_provincia PRIMARY KEY(id_provincia)
	
);

CREATE TABLE IF NOT EXISTS poblacion(
	
	id_poblacion integer default NEXTVAL('id_poblacion_sq'),
	nombre character varying NOT NULL,
	n_habitantes integer NOT NULL,
	id_provincia integer NOT NULL,	
	CONSTRAINT PK_poblacion PRIMARY KEY(id_poblacion)
	
);

	ALTER TABLE socio ADD CONSTRAINT FK_socio_poblacion
	FOREIGN KEY (id_poblacion) 
	REFERENCES poblacion(id_poblacion)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	ALTER TABLE pedido ADD CONSTRAINT FK_socio_pedido 
	FOREIGN KEY (id_socio) REFERENCES socio(id_socio)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	ALTER TABLE detalle_pedido ADD CONSTRAINT FK_detalle_pedido_libro 
	FOREIGN KEY (isbn) REFERENCES libro(isbn)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	ALTER TABLE detalle_pedido ADD CONSTRAINT FK_pedido_detalle_pedido 
	FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	ALTER TABLE libro ADD CONSTRAINT FK_libro_coleccion 
	FOREIGN KEY (id_coleccion) REFERENCES coleccion(id_coleccion)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	ALTER TABLE libro_almacen ADD CONSTRAINT FK_libro_libro_almacen 
	FOREIGN KEY (isbn) REFERENCES libro(isbn)
	ON UPDATE CASCADE ON DELETE CASCADE;
	ALTER TABLE libro_almacen ADD CONSTRAINT FK_libro_almacen_almacen 
	FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	ALTER TABLE provincia ADD CONSTRAINT FK_almacen_provincia 
	FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	ALTER TABLE poblacion ADD CONSTRAINT FK_provincia_poblacion 
	FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia)
	ON UPDATE CASCADE ON DELETE CASCADE;
	
	
	
	


CREATE SEQUENCE id_zoo_sq;
CREATE SEQUENCE especie_sq;
CREATE SEQUENCE num_identificacion_sq;

CREATE TABLE IF NOT EXISTS Zoo(
	
	id_zoo integer default NEXTVAL('id_zoo_sq'),
	nombre character varying NOT NULL,
	ciudad character varying NOT NULL,
	pais character varying NOT NULL,
	tamanio integer NOT NULL,
	CONSTRAINT PK_zoo PRIMARY KEY(id_zoo)	
);

CREATE TABLE IF NOT EXISTS Especie(
	
	id_especie integer default NEXTVAL ('especie_sq'),
	nombre_cientifico character varying NOT NULL,
	nombre_vulgar character varying NOT NULL,
	familia character varying NOT NULL,
	peligro_extincion boolean NOT NULL,
	CONSTRAINT PK_especie PRIMARY KEY (id_especie)	
);

CREATE TABLE IF NOT EXISTS Animal(
	
	num_identificacion integer default NEXTVAL ('num_identificacion_sq'),
	pais_origen character varying NOT NULL,
	continente character varying NOT NULL,
	sexo char(1) CHECK (sexo in ('H','M')) NOT NULL,
	anio_nacimiento date NOT NULL,
	id_zoo integer,
	id_especie integer,
	CONSTRAINT PK_animal PRIMARY KEY(num_identificacion),
	CONSTRAINT FK_zoo_animal FOREIGN KEY (id_zoo) REFERENCES Zoo(id_zoo)
	ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_especie_animal FOREIGN KEY (id_especie) REFERENCES Especie(id_especie)
	ON UPDATE CASCADE ON DELETE CASCADE
);

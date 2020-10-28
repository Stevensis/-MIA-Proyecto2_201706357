CREATE TABLE Prueba(
        idPrueba NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre varchar(100),
    apellido varchar(100)
);

SELECT * FROM Prueba;

INSERT INTO prueba (nombre,apellido) values ('Steven','Sis');

CREATE TABLE tipo_U (
    idTipo_U NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(20)
);

INSERT INTO tipo_U (nombre) VALUES('admin');
INSERT INTO tipo_U (nombre) VALUES('client');

CREATE TABLE pais(
    idPais  NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50)
);

INSERT INTO pais (nombre) VALUES ('Argentina');
INSERT INTO pais (nombre) VALUES ('Bolivia');
INSERT INTO pais (nombre) VALUES ('Brasil');
INSERT INTO pais (nombre) VALUES ('Chile');
INSERT INTO pais (nombre) VALUES ('Costa Rica');
INSERT INTO pais (nombre) VALUES ('Cuba');
INSERT INTO pais (nombre) VALUES ('Ecuador');
INSERT INTO pais (nombre) VALUES ('El Salvador');
INSERT INTO pais (nombre) VALUES ('Guayana Francesa');
INSERT INTO pais (nombre) VALUES ('Granada');
INSERT INTO pais (nombre) VALUES ('Guatemala');
INSERT INTO pais (nombre) VALUES ('Guayana');
INSERT INTO pais (nombre) VALUES ('Haiti');
INSERT INTO pais (nombre) VALUES ('Honduras');
INSERT INTO pais (nombre) VALUES ('Jamaica');
INSERT INTO pais (nombre) VALUES ('Mexico');
INSERT INTO pais (nombre) VALUES ('Nicaragua');
INSERT INTO pais (nombre) VALUES ('Paraguay');
INSERT INTO pais (nombre) VALUES ('Panama');
INSERT INTO pais (nombre) VALUES ('Peru');
INSERT INTO pais (nombre) VALUES ('Puerto Rico');
INSERT INTO pais (nombre) VALUES ('Republica Dominicana');
INSERT INTO pais (nombre) VALUES ('Surinam');
INSERT INTO pais (nombre) VALUES ('Uruguay');
INSERT INTO pais (nombre) VALUES ('Venezuela');


CREATE TABLE usuario(
    idUsuario NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    pass VARCHAR(50),
    email VARCHAR(50),
    nacimieno DATE,
    credito DECIMAL,
    confirmacion NUMBER,
    idTipo_U NUMBER,
    token VARCHAR(250),
    pathI VARCHAR(250),
    idPais NUMBER,
    FOREIGN KEY (idtipo_U) REFERENCES tipo_U (idTipo_U),
    FOREIGN KEY (idPais) REFERENCES pais (idPais)
);

CREATE TABLE categoria(
    idCategoria NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE producto(
    idProducto NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    detalle VARCHAR(200) NOT NULL,
    precio FLOAT NOT NULL,
    estado NUMBER NOT NULL,
    pathI VARCHAR(250) NOT NULL,
    idCategoria NUMBER NOT NULL,
    idUsuario NUMBER NOT NULL,
    
    FOREIGN KEY (idCategoria) REFERENCES categoria (idCategoria),
    FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario)
);

CREATE TABLE palabras_C(
    idPalabraC NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE palabrasC_producto(
    idPalabraC NUMBER,
    idProducto NUMBER,
    
    FOREIGN KEY (idPalabraC) REFERENCES palabras_C (idPalabraC) ON DELETE CASCADE,
    FOREIGN KEY (idProducto) REFERENCES producto (idProducto) ON DELETE CASCADE
);

SELECT PR.idProducto, PR.nombre, PR.precio, PR.pathI  FROM palabrasc_producto PP 
INNER JOIN producto PR ON (PR.idProducto=PP.idProducto)
INNER JOIN palabras_C PC ON (PC.idPalabraC=PP.idPalabrac);



INSERT INTO palabras_C(nombre) VALUES ('DeLL');

SELECT * FROM palabras_c WHERE nombre='dell';

SELECT * FROM palabrasc_producto;
SELECT * FROM producto;

INSERT INTO palabrasc_producto (idPalabraC, idProducto) VALUES (21,(SELECT idProducto FROM producto P WHERE P.pathI='uploads/38445f55-c06b-4c2a-9516-3e4d38b09bb2.png'));

TRUNCATE TABLE producto;
INSERT INTO usuario (nombre,apellido,pass,email,nacimieno,idTipo_U, confirmacion) VALUES ('201706357','sis','21232f297a57a5a743894a0e4a801fc3','201706357',TO_DATE('12/01/2016', 'DD/MM/YYYY'),1,1);
SELECT * FROM usuario;



INSERT INTO usuario (nombre,apellido,pass,email,nacimieno,credito, idTipo_U) VALUES ('201706357','sis','admin','aaronsishernandez@gmail.com',TO_DATE('12/01/2016', 'DD/MM/YYYY'),10000.00,2);

SELECT * FROM tipo_u;


SELECT * FROM usuario WHERE email='201706357' AND pass='admin';

UPDATE usuario SET confirmacion=0 WHERE token='eyJhbGciOiJIUzI1NiJ9.cHJ1ZWJhc2lzQGdtYWlsLmNvbQ.WV0tT9CXqHixs7zvqJw2rL3AZBL-azR1irrX2bbZ2eo';


DROP TABLE usuario;
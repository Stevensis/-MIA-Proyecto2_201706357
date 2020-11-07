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
    palabras VARCHAR(250),
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

CREATE TABLE Likes(
    estado NUMBER NOT NULL,
    idProducto NUMBER NOT NULL,
    idUsuario NUMBER NOT NULL,
    
    FOREIGN KEY (idProducto) REFERENCES producto (idProducto) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE
);

CREATE TABLE Comentario(
    coment VARCHAR(300) NOT NULL,
    idProducto NUMBER NOT NULL,
    idUsuario NUMBER NOT NULL,
    fecha TIMESTAMP,
    
    FOREIGN KEY (idProducto) REFERENCES producto (idProducto) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE
);

CREATE TABLE Denuncias(
    coment VARCHAR(300) NOT NULL,
    idProducto NUMBER NOT NULL,
    idUsuario NUMBER NOT NULL,
    fecha TIMESTAMP,
    
    FOREIGN KEY (idProducto) REFERENCES producto (idProducto) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE
);

CREATE TABLE Carrito(
    idCarrito NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    idUsuario NUMBER,
    idProducto NUMBER,
    cantidad NUMBER,
    fecha TIMESTAMP,
    
    FOREIGN KEY (idProducto) REFERENCES producto (idProducto) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE
);

CREATE TABLE factura(
    idFactura NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    idUsuario NUMBER,
    fecha TIMESTAMP,
    FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE
);

CREATE TABLE detalle_factura(
    idFactura NUMBER,
    idProducto NUMBER,
    cantidad NUMBER,
    subtotal FLOAT,
    FOREIGN KEY (idProducto) REFERENCES producto (idProducto) ON DELETE CASCADE,
    FOREIGN KEY (idFactura) REFERENCES factura (idFactura) ON DELETE CASCADE
);

CREATE TABLE Bitacora(
    idBitacora NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email   VARCHAR(50),
    fecha   TIMESTAMP,
    descripcion VARCHAR(150)
);

CREATE TABLE chat(
    idChat NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    idUsuario1 NUMBER,
    idUsuario2 NUMBER,
    
    FOREIGN KEY (idUsuario1) REFERENCES usuario (idUsuario) ON DELETE CASCADE,
    FOREIGN KEY (idUsuario2) REFERENCES usuario (idUsuario) ON DELETE CASCADE
);


CREATE TABLE Mensaje(
    idMensaje NUMBER  GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    texto VARCHAR(150),
    fecha TIMESTAMP,
    idChat NUMBER,
    idUsuario NUMBER,
    
    
    FOREIGN KEY (idUsuario) REFERENCES usuario (idUsuario) ON DELETE CASCADE,
    FOREIGN KEY (idChat) REFERENCES chat (idChat) ON DELETE CASCADE
);

INSERT INTO mensaje (texto,fecha,idChat, idUsuario) VALUES (:texto,LOCALTIMESTAMP(2),:idChat,:idUsuario);
SELECT M.idMensaje, M.texto, M.fecha, M.idChat, U.nombre, U.apellido FROM Mensaje M
INNER JOIN usuario U ON (U.idUsuario=M.idUsuario)
WHERE M.idChat=:id



CREATE OR REPLACE TRIGGER actualizacionCredito 
AFTER INSERT ON detalle_factura FOR EACH ROW
BEGIN
UPDATE usuario U set U.credito = (U.credito-:new.subtotal) WHERE U.idUsuario= (SELECT idUsuario FROM factura WHERE :new.idFactura=factura.idFactura);
UPDATE usuario U set U.credito = (U.credito+:new.subtotal) WHERE U.idUsuario= (SELECT idUsuario FROM producto WHERE :new.idProducto=producto.idProducto);
END actualizacionCredito;

CREATE OR REPLACE TRIGGER addBitacora1
AFTER INSERT ON usuario FOR EACH ROW
BEGIN 
INSERT INTO Bitacora (email, fecha, descripcion) VALUES (:new.email,LOCALTIMESTAMP(2), 'Se registro un nuevo Usuario '||:new.nombre);
END addBitacora1;

CREATE OR REPLACE TRIGGER addBitacora2
AFTER INSERT ON categoria FOR EACH ROW
BEGIN 
INSERT INTO Bitacora (email, fecha, descripcion) VALUES ('admin',LOCALTIMESTAMP(2), 'El admin ah registrado una nueva categoria '||:new.nombre);
END addBitacora2;

CREATE OR REPLACE TRIGGER addBitacora3
AFTER INSERT ON producto FOR EACH ROW
BEGIN 
INSERT INTO Bitacora (email, fecha, descripcion) VALUES ((SELECT U.email FROM producto P INNER JOIN usuario U ON (U.idUsuario=P.idUsuario) WHERE P.idProducto=:new.idProducto),LOCALTIMESTAMP(2), 'El usuario ah registrado un nuevo producto '||:new.nombre);
END addBitacora3;

/* Reporte 2*/
SELECT P.nombre AS Producto, SUM(DT.cantidad) AS cantidad, U.nombre As cliente, U.apellido FROM detalle_factura DT 
INNER JOIN producto P ON (P.idProducto=DT.idProducto)
INNER JOIN usuario U ON (U.idUsuario=P.idUsuario) group by DT.idProducto, P.nombre, U.idusuario, U.nombre, U.apellido;

/* Reprote 3 */
SELECT P.nombre AS Producto, count(*) AS Me_Gusta, U.nombre As cliente, U.apellido FROM LIKES DT 
INNER JOIN producto P ON (P.idProducto=DT.idProducto)
INNER JOIN usuario U ON (U.idUsuario=P.idUsuario)
WHERE DT.estado=1
group by DT.idProducto, P.nombre, U.idusuario, U.nombre, U.apellido;

/* Reporte 4 */
SELECT P.nombre AS Producto, count(*) AS Me_Gusta, U.nombre As cliente, U.apellido FROM LIKES DT 
INNER JOIN producto P ON (P.idProducto=DT.idProducto)
INNER JOIN usuario U ON (U.idUsuario=P.idUsuario)
WHERE DT.estado=2
group by DT.idProducto, P.nombre, U.idusuario, U.nombre, U.apellido;

/* Reporte 5*/
SELECT*FROM(
SELECT * FROM usuario U WHERE confirmacion=1 AND idTIpo_U=2 
ORDER BY U.credito DESC
)WHERE  ROWNUM <= 10;

SELECT*FROM(
SELECT * FROM usuario U WHERE confirmacion=1 AND idTIpo_U=2 
ORDER BY U.credito ASC
)WHERE  ROWNUM <= 10;

/*Reporte 6*/
SELECT*FROM(
SELECT U.nombre,U.email, U.nacimieno, COUNT(*) AS Den FROM denuncias D 
INNER JOIN Usuario U ON (U.idUsuario=D.idUsuario)
GROUP BY  D.idUsuario, U.nombre, U.email, U.nacimieno
ORDER BY Den DESC
) WHERE ROWNUM <= 10;

/* Reporte 7 */
SELECT*FROM(
SELECT U.nombre, U.email, U.credito, COUNT(*) AS Cant FROM producto P 
INNER JOIN usuario U ON (U.idUsuario=P.idUsuario)
WHERE P.estado=0 
group by P.idUsuario, U.nombre, U.email, U.credito
ORDER BY Cant DESC
) WHERE ROWNUM <= 10;

/* Reporte 8 */
SELECT * FROM (
SELECT PA.nombre, TA.suma, TCLI.clientes,  COUNT(*) AS ventas FROM producto P
INNER JOIN usuario U ON (U.idUsuario=P.idUsuario)
INNER JOIN pais PA ON (PA.idPais=U.idPais)
INNER JOIN (SELECT PAA.idPais,SUM(UAA.credito) AS suma FROM pais PAA, usuario UAA WHERE UAA.idPais=PAA.idPais group by PAA.idPais)  TA ON (TA.idPais=PA.idPais) 
INNER JOIN (SELECT CLI.idPais, count(*) AS clientes FROM usuario CLI group by CLI.idPais ) TCLI ON (TCLI.idPais=PA.idPais)
WHERE P.estado=0
GROUP BY U.idPais, PA.nombre, TA.suma, TCLI.clientes
) WHERE ROWNUM <= 10;

/* Fin ----------------------------------------*/

SELECT * FROM Bitacora ORDER BY fecha ASC
delete  detalle_factura;
delete  factura;

SELECT * FROM usuario
INSERT INTO factura (idUsuario,fecha) VALUES (21,TO_TIMESTAMP('1/11/2020 23:41:03', 'DD/MM/YYYY HH24:MI:SS'));

SELECT * FROM factura;
SELECT * FROM detalle_factura;  
DELETE factura

INSERT INTO detalle_factura (idFactura, idProducto, cantidad, subtotal) VALUES 
( (SELECT idFactura FROM factura WHERE idUsuario=:idUsuario AND fecha=TO_DATE(:fecha, 'DD/MM/YYYY HH24:MI:SS')),:idProducto,:cantidad,:subtotal );


INSERT INTO factura (idUsuario,fecha) VALUES (:idUsuario,LOCALTIMESTAMP(2));

INSERT INTO Carrito (idUsuario, idProducto, cantidad, fecha) VALUES (:idUsuario, :idProducto, :cantidad, LOCALTIMESTAMP(2));

SELECT C.idCarrito, P.idProducto, P.nombre, P.precio, C.cantidad, C.fecha, C.idUsuario  FROM Carrito C 
INNER JOIN producto P ON (P.idProducto=C.idProducto)
WHERE idUsuario=1;



DELETE Carrito WHERE idCarrito=:id;

SELECT C.idCarrito, P.idProducto, P.nombre, P.precio, C.cantidad, C.fecha, C.idUsuario, (C.Cantidad*P.precio) AS subtotal  FROM Carrito C INNER JOIN producto P ON (P.idProducto=C.idProducto) WHERE C.idUsuario=10

Select*From Carrito;

INSERT INTO Denuncias (coment, idProducto, idUsuario, fecha) VALUES ('ES LO MEJOR',21,10, LOCALTIMESTAMP(2) );

SELECT * FROM comentario

SELECT C.coment, C.idProducto, C.idUsuario, C.fecha, U.nombre, U.apellido, P.nombre AS nombreP, P.idUsuario AS idUP, J.nombre AS nombreU2, J.apellido AS apellido2, J.email AS email FROM Denuncias C 
INNER JOIN usuario U ON (U.idUsuario=C.idUsuario)  
INNER JOIN producto P ON (C.idProducto=P.idProducto) 
INNER JOIN usuario J ON (J.idUsuario=P.idUsuario)  
ORDER BY C.fecha ASC;

DROP TABLE Comentario

INSERT INTO Likes (estado, idProducto, idUsuario) VALUES ()
SELECT * FROM Likes WHERE idProducto!=21 AND idUsuario!=10

SELECT count(*) AS Megusta FROM Likes WHERE idProducto=21 AND estado=1
UNION ALL
SELECT count(*) AS NoMegusta FROM Likes WHERE idProducto=21 AND estado=2;

SELECT PR.idProducto, PR.nombre, PR.precio, PR.pathI  FROM palabrasc_producto PP 
INNER JOIN producto PR ON (PR.idProducto=PP.idProducto)
INNER JOIN palabras_C PC ON (PC.idPalabraC=PP.idPalabrac);



INSERT INTO palabras_C(nombre) VALUES ('DeLL');

SELECT * FROM palabras_c WHERE nombre='dell';

SELECT * FROM palabrasc_producto;
SELECT * FROM usuario;

INSERT INTO palabrasc_producto (idPalabraC, idProducto) VALUES (21,(SELECT idProducto FROM producto P WHERE P.pathI='uploads/38445f55-c06b-4c2a-9516-3e4d38b09bb2.png'));

TRUNCATE TABLE producto;
INSERT INTO usuario (nombre,apellido,pass,email,nacimieno,idTipo_U, confirmacion) VALUES ('201706357','sis','21232f297a57a5a743894a0e4a801fc3','201706357',TO_DATE('12/01/2016', 'DD/MM/YYYY'),1,1);
SELECT * FROM usuario;

DROP TABLE producto

INSERT INTO usuario (nombre,apellido,pass,email,nacimieno,credito, idTipo_U) VALUES ('201706357','sis','admin','aaronsishernandez@gmail.com',TO_DATE('12/01/2016', 'DD/MM/YYYY'),10000.00,2);

SELECT * FROM tipo_u;


SELECT * FROM usuario WHERE email='201706357' AND pass='admin';

UPDATE usuario SET confirmacion=0 WHERE token='eyJhbGciOiJIUzI1NiJ9.cHJ1ZWJhc2lzQGdtYWlsLmNvbQ.WV0tT9CXqHixs7zvqJw2rL3AZBL-azR1irrX2bbZ2eo';


DROP TABLE usuario;
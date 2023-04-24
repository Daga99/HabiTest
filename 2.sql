CREATE TABLE tabla_TIENDA (
  codigo_tienda int PRIMARY KEY,
  nombre_tienda varchar(255)
);

CREATE TABLE tabla_BEBIDA (
  codigo_bebida int PRIMARY KEY,
  nombre_bebida varchar(255)
);

CREATE TABLE tabla_BEBEDOR (
  cedula bigint PRIMARY KEY,
  nombre varchar(255)
);

CREATE TABLE tabla_GUSTA (
  cedula bigint,
  codigo_bebida int,
  PRIMARY KEY (cedula, codigo_bebida),
  FOREIGN KEY (cedula) REFERENCES tabla_BEBEDOR(cedula),
  FOREIGN KEY (codigo_bebida) REFERENCES tabla_BEBIDA(codigo_bebida)
);

CREATE TABLE tabla_FRECUENTA (
  cedula bigint,
  codigo_tienda int,
  PRIMARY KEY (cedula, codigo_tienda),
  FOREIGN KEY (cedula) REFERENCES tabla_BEBEDOR(cedula),
  FOREIGN KEY (codigo_tienda) REFERENCES tabla_TIENDA(codigo_tienda)
);

CREATE TABLE tabla_VENDE (
  codigo_tienda int,
  codigo_bebida int,
  precio float,
  PRIMARY KEY (codigo_tienda, codigo_bebida),
  FOREIGN KEY (codigo_tienda) REFERENCES tabla_TIENDA(codigo_tienda),
  FOREIGN KEY (codigo_bebida) REFERENCES tabla_BEBIDA(codigo_bebida)
);

-- Insertar datos en tabla_TIENDA
INSERT INTO tabla_TIENDA (codigo_tienda, nombre_tienda)
VALUES (1, 'Tienda 1'),
       (2, 'Tienda 2'),
       (3, 'Tienda 3'),
       (4, 'Tienda 4');

-- Insertar datos en tabla_BEBIDA
INSERT INTO tabla_BEBIDA (codigo_bebida, nombre_bebida)
VALUES (1, 'Coca Cola'),
       (2, 'Pepsi'),
       (3, 'Sprite'),
       (4, 'colombiana');

-- Insertar datos en tabla_BEBEDOR
INSERT INTO tabla_BEBEDOR (cedula, nombre)
VALUES (1, 'Juan Perez'),
       (2, 'Maria Rodriguez'),
       (3, 'Andres Camilo Restrepo'),
       (4, 'Luisa Martinez'),
       (5, 'Luis Perez'),
       (6, 'Jazlyn Acero');

-- Insertar datos en tabla_GUSTA
INSERT INTO tabla_GUSTA (cedula, codigo_bebida)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (2, 3),
       (3, 1),
       (3, 4),
       (4, 3),
       (4, 4),
       (5, 2),
       (6, 1);

-- Insertar datos en tabla_FRECUENTA
INSERT INTO tabla_FRECUENTA (cedula, codigo_tienda)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (2, 3),
       (3, 1),
       (3, 4),
       (4, 3),
       (4, 4),
       (5, 1),
       (6, 1);

-- Insertar datos en tabla_VENDE
INSERT INTO tabla_VENDE (codigo_tienda, codigo_bebida, precio)
VALUES (1, 1, 1000),
       (1, 2, 1500),
       (1, 3, 1200),
       (2, 2, 1400),
       (2, 3, 1200),
       (2, 4, 1100),
       (3, 1, 900),
       (3, 4, 1000),
       (4, 3, 1300),
       (4, 4, 1000);
       
SELECT DISTINCT b.cedula, b.nombre FROM tabla_BEBEDOR b
WHERE NOT EXISTS (
  SELECT * FROM tabla_GUSTA g JOIN tabla_BEBIDA beb 
  ON g.codigo_bebida = beb.codigo_bebida 
  WHERE beb.nombre_bebida = 'colombiana' AND g.cedula = b.cedula
);

SELECT t.codigo_tienda, t.nombre_tienda FROM tabla_TIENDA t 
WHERE NOT EXISTS (
  SELECT * FROM tabla_FRECUENTA f JOIN tabla_BEBEDOR b 
  ON f.cedula = b.cedula 
  WHERE b.nombre = 'Andres Camilo Restrepo' AND f.codigo_tienda = t.codigo_tienda
);
SELECT DISTINCT b.cedula, b.nombre FROM tabla_BEBEDOR b 
WHERE EXISTS (
  SELECT * FROM tabla_GUSTA g 
  WHERE g.cedula = b.cedula
) AND EXISTS (
  SELECT * FROM tabla_FRECUENTA f 
  WHERE f.cedula = b.cedula
);
SELECT b.cedula, b.nombre, beb.nombre_bebida FROM tabla_BEBEDOR b, tabla_BEBIDA beb 
WHERE NOT EXISTS (
  SELECT * FROM tabla_GUSTA g 
  WHERE g.cedula = b.cedula AND g.codigo_bebida = beb.codigo_bebida
) 
AND beb.codigo_bebida NOT IN (
  SELECT g.codigo_bebida FROM tabla_GUSTA g 
  WHERE g.cedula = b.cedula
);

SELECT DISTINCT b.cedula, b.nombre FROM tabla_BEBEDOR b, tabla_FRECUENTA f1 
WHERE b.cedula = f1.cedula 
AND EXISTS (
  SELECT * FROM tabla_FRECUENTA f2 JOIN tabla_BEBEDOR bp 
  ON f2.cedula = bp.cedula 
  WHERE bp.nombre = 'Luis Perez' AND f1.codigo_tienda = f2.codigo_tienda AND bp.cedula <> b.cedula
);

SELECT DISTINCT b.cedula, b.nombre FROM tabla_BEBEDOR b, tabla_GUSTA g, tabla_FRECUENTA f, tabla_VENDE v
WHERE b.cedula = g.cedula AND b.cedula = f.cedula AND f.codigo_tienda = v.codigo_tienda AND g.codigo_bebida = v.codigo_bebida 
  AND NOT EXISTS (
    SELECT * FROM tabla_VENDE v2
    WHERE v2.codigo_tienda = v.codigo_tienda AND v2.codigo_bebida 
    NOT IN (SELECT g2.codigo_bebida FROM tabla_GUSTA g2
        WHERE g2.cedula = b.cedula
      )
  )
  AND NOT EXISTS (
    SELECT * FROM tabla_FRECUENTA f2
    WHERE f2.cedula = b.cedula AND f2.codigo_tienda NOT IN (
        SELECT v3.codigo_tienda FROM tabla_VENDE v3 JOIN tabla_GUSTA g3
        ON v3.codigo_bebida = g3.codigo_bebida 
        WHERE g3.cedula = b.cedula
      )
  )
  AND NOT EXISTS (
    SELECT * FROM tabla_FRECUENTA f4 JOIN tabla_VENDE v4 ON f4.codigo_tienda = v4.codigo_tienda
    WHERE f4.cedula = b.cedula AND v4.codigo_bebida NOT IN (
        SELECT g4.codigo_bebida FROM tabla_GUSTA g4
        WHERE g4.cedula = b.cedula
      )
  );
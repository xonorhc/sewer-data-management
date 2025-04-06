CREATE TABLE sistema_esgoto.tipo_forma (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_forma
    VALUES (1, 'Circular'),
    (2, 'Quadrado'),
    (3, 'Retangular');


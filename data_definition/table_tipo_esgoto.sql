CREATE TABLE sistema_esgoto.tipo_esgoto (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_esgoto
    VALUES (1, 'Domestico'),
    (2, 'Industrial'),
    (3, 'Pluvial'),
    (4, 'Tratado');


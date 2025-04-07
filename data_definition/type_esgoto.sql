CREATE TABLE :PGSCHEMA.tipo_esgoto (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO :PGSCHEMA.tipo_esgoto
    VALUES (1, 'Domestico'),
    (2, 'Industrial'),
    (3, 'Pluvial'),
    (4, 'Tratado');


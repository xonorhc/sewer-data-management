CREATE TABLE sistema_esgoto.tipo_bomba (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_bomba
    VALUES (1, 'Centrifuga'),
    (2, 'Submersa'),
    (3, 'Submersivel'),
    (4, 'Auto-aspirante'),
    (5, 'Periferica'),
    (6, 'Injetora');


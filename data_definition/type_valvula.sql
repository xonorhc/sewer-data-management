CREATE TABLE sistema_esgoto.tipo_valvula (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_valvula
    VALUES (1, 'Borboleta'),
    (2, 'Esferica'),
    (3, 'Gaveta'),
    (4, 'Redutora de pressao'),
    (5, 'Retencao');


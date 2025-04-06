CREATE TABLE sistema_esgoto.tipo_situacao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_situacao
    VALUES (1, 'Ativa'),
    (2, 'Inativa'),
    (3, 'Em construcao');


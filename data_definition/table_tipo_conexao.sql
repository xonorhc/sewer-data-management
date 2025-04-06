CREATE TABLE sistema_esgoto.tipo_conexao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_conexao
    VALUES (1, 'Adaptador'),
    (2, 'CAP'),
    (3, 'Colar de tomada'),
    (4, 'Cruzeta'),
    (5, 'Curva'),
    (6, 'Luva de uniao'),
    (7, 'Reducao'),
    (8, 'TE'),
    (9, 'Ventosa');


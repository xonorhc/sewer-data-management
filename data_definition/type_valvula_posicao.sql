CREATE TABLE sistema_esgoto.tipo_valvula_posicao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_valvula_posicao
    VALUES (1, 'Aberta'),
    (2, 'Fechada'),
    (3, 'Nao aplicavel'),
    (4, 'Parcialmente aberta');


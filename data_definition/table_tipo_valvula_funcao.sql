CREATE TABLE sistema_esgoto.tipo_valvula_funcao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_valvula_funcao
    VALUES (1, 'Bloqueio'),
    (2, 'Controle'),
    (3, 'Descarga'),
    (4, 'Redutora de pressao'),
    (5, 'Retencao');


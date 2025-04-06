CREATE TABLE sistema_esgoto.tipo_rede_esgoto (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO sistema_esgoto.tipo_rede_esgoto
    VALUES (1, 'Coletor'),
    (2, 'Coletor tronco'),
    (3, 'Interceptor'),
    (4, 'Recalque'),
    (5, 'Emissario');


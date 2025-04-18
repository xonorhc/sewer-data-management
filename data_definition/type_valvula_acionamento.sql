BEGIN;
CREATE TABLE :PGSCHEMA.tipo_valvula_acionamento (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);
INSERT INTO :PGSCHEMA.tipo_valvula_acionamento
    VALUES (1, 'Eletrico'),
    (2, 'Manual Chave'),
    (3, 'Manual Volante'),
    (4, 'Mecanico');
COMMIT;


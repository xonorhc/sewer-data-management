BEGIN;
CREATE TABLE :PGSCHEMA.tipo_unidade_inspecao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);
INSERT INTO :PGSCHEMA.tipo_unidade_inspecao
    VALUES (1, 'Caixa de passagem'),
    (2, 'Poco de inspecao'),
    (3, 'Poco de visita'),
    (4, 'Terminal de limpeza');
COMMIT;


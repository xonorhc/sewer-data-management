CREATE TABLE :PGSCHEMA.tipo_tratamento_nivel (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO :PGSCHEMA.tipo_tratamento_nivel
    VALUES (1, 'Preliminar/Acondicionamento'),
    (2, 'Primario'),
    (3, 'Secundario'),
    (4, 'Terciario');


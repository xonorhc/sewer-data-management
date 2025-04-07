CREATE TABLE :PGSCHEMA.tipo_manancial (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

INSERT INTO :PGSCHEMA.tipo_manancial
    VALUES (1, 'Rio'),
    (2, 'Lago'),
    (3, 'Acude'),
    (4, 'Represa'),
    (5, 'Aquifero'),
    (6, 'Nascente');


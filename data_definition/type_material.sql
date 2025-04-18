BEGIN;
CREATE TABLE :PGSCHEMA.tipo_material (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);
INSERT INTO :PGSCHEMA.tipo_material
    VALUES (1, 'CA'),
    (2, 'Concreto'),
    (3, 'FoFo'),
    (4, 'FGal'),
    (5, 'PRFV'),
    (6, 'PVC'),
    (7, 'PVC Corrugado'),
    (8, 'PVC DeFoFo'),
    (9, 'PEAD'),
    (10, 'PEAD Corrugado'),
    (11, 'Aco'),
    (12, 'Tijolo');
COMMIT;


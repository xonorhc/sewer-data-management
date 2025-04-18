BEGIN;
CREATE TABLE :PGSCHEMA.tipo_tratamento_tecnologia (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);
INSERT INTO :PGSCHEMA.tipo_tratamento_tecnologia
    VALUES (1, 'Decantacao primaria'),
    (2, 'Lagoa anaerobica'),
    (3, 'Reator anaerobico'),
    (4, 'Lagoa aerobica'),
    (5, 'Lodos ativados'),
    (6, 'Filtro biologico'),
    (7, 'Coagulacao'),
    (8, 'Flotacao'),
    (9, 'Desinfeccao'),
    (10, 'Outros - especificar na obs');
COMMIT;


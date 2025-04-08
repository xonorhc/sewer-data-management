CREATE TABLE :PGSCHEMA.bombas (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, :SRID) UNIQUE NOT NULL,
    id_estacao_elevatoria integer REFERENCES :PGSCHEMA.estacoes_elevatorias (id) ON DELETE SET NULL, -- TODO: Function to update from estacoes_elevatorias
    tipo smallint REFERENCES :PGSCHEMA.tipo_bomba (id),
    diametro_entrada smallint CHECK (diametro_entrada BETWEEN 0 AND 1000),
    diametro_saida smallint CHECK (diametro_saida BETWEEN 0 AND 1000),
    vazao numeric(6, 2) CHECK (vazao BETWEEN 0 AND 5000),
    potencia numeric(6, 2) CHECK (potencia BETWEEN 0 AND 1000),
    pressao numeric(4, 1) CHECK (pressao BETWEEN 0 AND 200),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.bombas USING gist (geom);


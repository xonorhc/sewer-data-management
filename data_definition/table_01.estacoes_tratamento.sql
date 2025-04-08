CREATE TABLE :PGSCHEMA.estacoes_tratamento (
    id serial PRIMARY KEY,
    geom geometry(point, :SRID) UNIQUE NOT NULL,
    nome varchar(50) UNIQUE NOT NULL,
    nivel_tratamento smallint REFERENCES :PGSCHEMA.tipo_tratamento_nivel (id) ON DELETE SET NULL,
    tecnologia smallint[], -- TODO: references tipo_tratamento_tecnologia
    vazao numeric(6, 2) CHECK (vazao BETWEEN 0 AND 5000),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) ON DELETE RESTRICT NOT NULL DEFAULT 1,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.estacoes_tratamento USING gist (geom);


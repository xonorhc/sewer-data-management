CREATE TABLE :PGSCHEMA.estacoes_elevatorias (
    id serial PRIMARY KEY,
    geom geometry(polygon, :SRID) NOT NULL,
    nome varchar(50) NOT NULL UNIQUE,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL DEFAULT 1, -- TODO: Function to updade from redes_esgoto
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) ON DELETE RESTRICT NOT NULL DEFAULT 1,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.estacoes_elevatorias USING gist (geom);


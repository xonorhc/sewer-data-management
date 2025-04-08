CREATE TABLE :PGSCHEMA.estacoes_elevatorias (
    id serial PRIMARY KEY,
    geom geometry(polygon, 4674) NOT NULL,
    nome varchar(50) NOT NULL UNIQUE,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL,
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.estacoes_elevatorias USING gist (geom);


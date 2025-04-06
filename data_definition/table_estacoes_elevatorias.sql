CREATE TABLE sistema_esgoto.estacoes_elevatorias (
    id serial PRIMARY KEY,
    geom geometry(polygon, 4674) NOT NULL,
    nome varchar(50) NOT NULL UNIQUE,
    esgoto smallint REFERENCES sistema_esgoto.tipo_esgoto (id) NOT NULL,
    situacao smallint REFERENCES sistema_esgoto.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.estacoes_elevatorias USING gist (geom);


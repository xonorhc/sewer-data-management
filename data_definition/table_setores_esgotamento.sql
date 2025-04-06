CREATE TABLE sistema_esgoto.setores_esgotamento (
    id serial PRIMARY KEY,
    geom geometry(polygon, 4674) NOT NULL,
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.setores_esgotamento USING gist (geom);


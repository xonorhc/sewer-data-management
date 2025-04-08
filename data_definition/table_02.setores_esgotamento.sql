CREATE TABLE :PGSCHEMA.setores_esgotamento (
    id serial PRIMARY KEY,
    geom geometry(polygon, :SRID) NOT NULL, -- TODO: function to generated geom from redes_esgoto and estacoes_tratamento
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.setores_esgotamento USING gist (geom);


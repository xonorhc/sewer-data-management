<<<<<<< HEAD
CREATE TABLE IF NOT EXISTS :PGSCHEMA.estacoes_tratamento (
=======
CREATE TABLE :PGSCHEMA.estacoes_tratamento (
>>>>>>> 1a429f4 (random commit)
    id serial PRIMARY KEY,
    geom geometry(point, :SRID) UNIQUE NOT NULL,
    nome varchar(50) UNIQUE NOT NULL,
    nivel_tratamento smallint REFERENCES :PGSCHEMA.tipo_tratamento_nivel (id) NOT NULL,
    tecnologia smallint[], -- TODO: References tipo_tratamento_tecnologia (id).
    vazao numeric(6, 2) CHECK (vazao BETWEEN 0 AND 5000),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

COMMENT ON COLUMN :PGSCHEMA.estacoes_tratamento.vazao IS 'NOTE : Metros cubicos por hora (m3/h)';

CREATE INDEX ON :PGSCHEMA.estacoes_tratamento USING gist (geom);


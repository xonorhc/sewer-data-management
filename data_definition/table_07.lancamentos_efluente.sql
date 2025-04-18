CREATE TABLE IF NOT EXISTS :PGSCHEMA.lancamentos_efluente (
    id serial PRIMARY KEY,
    geom geometry(point, :SRID) UNIQUE NOT NULL,
    tipo smallint REFERENCES :PGSCHEMA.tipo_lancamento (id) NOT NULL,
    local_lancamento smallint REFERENCES :PGSCHEMA.tipo_descarga (id) NOT NULL,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL, -- TODO: Function to update from redes_esgoto.
    tipo_corpo_receptor smallint REFERENCES :PGSCHEMA.tipo_manancial (id) NOT NULL,
    nome_corpo_receptor varchar, -- ISSUE: Adicionar referencia a alguma tabela de hidrografia/cursos dagua.
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.lancamentos_efluente USING gist (geom);


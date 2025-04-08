CREATE TABLE :PGSCHEMA.lancamentos_efluente (
    id serial PRIMARY KEY,
    geom geometry(point, 4674) UNIQUE NOT NULL,
    tipo smallint REFERENCES :PGSCHEMA.tipo_lancamento (id) NOT NULL,
    local_lancamento smallint REFERENCES :PGSCHEMA.tipo_descarga (id) NOT NULL,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL,
    tipo_corpo_receptor smallint REFERENCES :PGSCHEMA.tipo_manancial (id),
    nome_corpo_receptor varchar, -- ISSUE: references hidrografia
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.lancamentos_efluente USING gist (geom);


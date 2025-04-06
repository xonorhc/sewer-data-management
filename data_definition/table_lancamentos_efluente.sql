CREATE TABLE sistema_esgoto.lancamentos_efluente (
    id serial PRIMARY KEY,
    geom geometry(point, 4674) UNIQUE NOT NULL,
    tipo smallint REFERENCES sistema_esgoto.tipo_lancamento (id) NOT NULL,
    local_lancamento smallint REFERENCES sistema_esgoto.tipo_descarga (id) NOT NULL,
    esgoto smallint REFERENCES sistema_esgoto.tipo_esgoto (id) NOT NULL,
    tipo_corpo_receptor smallint REFERENCES sistema_esgoto.tipo_manancial (id),
    nome_corpo_receptor varchar, -- ISSUE: references hidrografia
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.lancamentos_efluente USING gist (geom);


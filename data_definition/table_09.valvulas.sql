CREATE TABLE IF NOT EXISTS :PGSCHEMA.valvulas (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, :SRID) UNIQUE NOT NULL, -- TODO: Function to connect on redes_esgoto
    tipo smallint REFERENCES :PGSCHEMA.tipo_valvula (id) NOT NULL,
    funcao smallint REFERENCES :PGSCHEMA.tipo_valvula_funcao (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 0 AND 1000) NOT NULL,
    acionamento smallint REFERENCES :PGSCHEMA.tipo_valvula_acionamento (id),
    acesso smallint REFERENCES :PGSCHEMA.tipo_valvula_acesso (id),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    posicao smallint REFERENCES :PGSCHEMA.tipo_valvula_posicao (id) NOT NULL,
    qtd_voltas_fechar numeric(3, 1),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

COMMENT ON COLUMN :PGSCHEMA.valvulas.diametro IS 'NOTE : Diametro nominal (dn) em milimetros (mm)';

COMMENT ON COLUMN :PGSCHEMA.valvulas.profundidade IS 'NOTE : Metros (m)';

CREATE INDEX ON :PGSCHEMA.valvulas USING gist (geom);


CREATE TABLE :PGSCHEMA.valvulas (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, :SRID) UNIQUE NOT NULL, -- TODO: Function to connect on redes_esgoto
    tipo smallint REFERENCES :PGSCHEMA.tipo_valvula (id) NOT NULL DEFAULT 3,
    funcao smallint REFERENCES :PGSCHEMA.tipo_valvula_funcao (id) NOT NULL DEFAULT 2,
    diametro smallint CHECK (diametro BETWEEN 0 AND 1000) NOT NULL,
    acionamento smallint REFERENCES :PGSCHEMA.tipo_valvula_acionamento (id) DEFAULT 2,
    acesso smallint REFERENCES :PGSCHEMA.tipo_valvula_acesso (id),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    posicao smallint REFERENCES :PGSCHEMA.tipo_valvula_posicao (id) NOT NULL DEFAULT 1,
    qtd_voltas_fechar numeric(3, 1),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) ON DELETE RESTRICT NOT NULL DEFAULT 1,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.valvulas USING gist (geom);


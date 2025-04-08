CREATE TABLE :PGSCHEMA.unidades_inspecao (
    id serial PRIMARY KEY,
    geom geometry(point, :SRID) UNIQUE NOT NULL, -- TODO: Function to connect on redes_esgoto
    tipo smallint REFERENCES :PGSCHEMA.tipo_unidade_inspecao (id) NOT NULL DEFAULT 3,
    forma smallint REFERENCES :PGSCHEMA.tipo_forma (id) DEFAULT 1,
    material smallint REFERENCES :PGSCHEMA.tipo_material (id) DEFAULT 2,
    diametro smallint CHECK (diametro BETWEEN 0 AND 2000) DEFAULT 1000,
    cota_nivel numeric(6, 3) CHECK (cota_nivel BETWEEN 0 AND 1000),
    cota_fundo numeric(6, 3) CHECK (cota_fundo BETWEEN 0 AND 1000),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    forma_tampao smallint REFERENCES :PGSCHEMA.tipo_forma (id) DEFAULT 1,
    material_tampao smallint REFERENCES :PGSCHEMA.tipo_material (id) DEFAULT 3,
    diametro_tampao smallint CHECK (diametro_tampao BETWEEN 0 AND 1200) DEFAULT 600,
    extravasor boolean DEFAULT FALSE,
    cota_extravasor numeric(6, 3) CHECK (cota_extravasor BETWEEN 0 AND 1000),
    profundidade_extravasor numeric(3, 2) CHECK (profundidade_extravasor BETWEEN 0 AND 10),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) ON DELETE RESTRICT NOT NULL DEFAULT 1,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.unidades_inspecao USING gist (geom);


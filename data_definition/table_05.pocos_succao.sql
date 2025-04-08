CREATE TABLE :PGSCHEMA.pocos_succao (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, :SRID) UNIQUE NOT NULL,
    id_estacao_elevatoria smallint REFERENCES :PGSCHEMA.estacoes_elevatorias (id) ON DELETE SET NULL, -- TODO: Function to update from estacoes_elevatorias
    cota_nivel numeric(6, 3) CHECK (cota_nivel BETWEEN 0 AND 1000),
    cota_fundo numeric(6, 3) CHECK (cota_fundo BETWEEN 0 AND 1000),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    diametro smallint CHECK (diametro BETWEEN 0 AND 2000),
    volume integer CHECK (volume BETWEEN 0 AND 1000),
    nivel_min numeric(3, 2) CHECK (nivel_min BETWEEN 0 AND 10),
    nivel_max numeric(3, 2) CHECK (nivel_max BETWEEN 0 AND 10),
    forma_tampao smallint REFERENCES :PGSCHEMA.tipo_forma (id),
    material_tampao smallint REFERENCES :PGSCHEMA.tipo_material (id),
    diametro_tampao smallint CHECK (diametro_tampao BETWEEN 0 AND 1200),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL DEFAULT 1,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.pocos_succao USING gist (geom);


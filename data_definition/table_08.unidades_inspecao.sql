CREATE TABLE IF NOT EXISTS :PGSCHEMA.unidades_inspecao (
    id serial PRIMARY KEY,
    geom geometry(point, :SRID) UNIQUE NOT NULL, -- TODO: Function to snapping on redes_esgoto
    tipo smallint REFERENCES :PGSCHEMA.tipo_unidade_inspecao (id) NOT NULL,
    forma smallint REFERENCES :PGSCHEMA.tipo_forma (id) NOT NULL,
    material smallint REFERENCES :PGSCHEMA.tipo_material (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 0 AND 2000) NOT NULL,
    cota_nivel numeric(6, 3) CHECK (cota_nivel BETWEEN 0 AND 1000),
    cota_fundo numeric(6, 3) CHECK (cota_fundo BETWEEN 0 AND 1000),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    forma_tampao smallint REFERENCES :PGSCHEMA.tipo_forma (id),
    material_tampao smallint REFERENCES :PGSCHEMA.tipo_material (id),
    diametro_tampao smallint CHECK (diametro_tampao BETWEEN 0 AND 1200),
    extravasor boolean,
    cota_extravasor numeric(6, 3) CHECK (cota_extravasor BETWEEN 0 AND 1000),
    profundidade_extravasor numeric(3, 2) CHECK (profundidade_extravasor BETWEEN 0 AND 10),
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

COMMENT ON COLUMN :PGSCHEMA.unidades_inspecao.diametro IS 'NOTE : Diametro nominal (dn) em milimetros (mm)';

COMMENT ON COLUMN :PGSCHEMA.unidades_inspecao.cota_nivel IS 'NOTE : Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.unidades_inspecao.cota_fundo IS 'NOTE : Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.unidades_inspecao.profundidade IS 'NOTE : Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.unidades_inspecao.diametro_tampao IS 'NOTE : Diametro nominal (dn) em milimetros (mm)';

COMMENT ON COLUMN :PGSCHEMA.unidades_inspecao.cota_extravasor IS 'NOTE : Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.unidades_inspecao.profundidade_extravasor IS 'NOTE : Metros (m)';

CREATE INDEX ON :PGSCHEMA.unidades_inspecao USING gist (geom);


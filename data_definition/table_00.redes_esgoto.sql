CREATE TABLE IF NOT EXISTS :PGSCHEMA.redes_esgoto (
    id serial PRIMARY KEY,
    geom geometry(linestring, :SRID) NOT NULL,
    tipo smallint REFERENCES :PGSCHEMA.tipo_rede_esgoto (id) NOT NULL,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL, -- TODO: Auto-update when before/after estacoes_tratamento
    material smallint REFERENCES :PGSCHEMA.tipo_material (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 50 AND 1000) NOT NULL,
    extensao_digital numeric GENERATED ALWAYS AS ((ST_LENGTH (geom))::numeric(8, 2)) STORED,
    cota_montante numeric(6, 3) CHECK (cota_montante BETWEEN 0 AND 1000),
    profundidade_montante numeric(3, 2) CHECK (profundidade_montante BETWEEN 0 AND 10),
    cota_jusante numeric(6, 3) CHECK (cota_jusante BETWEEN 0 AND 1000),
    profundidade_jusante numeric(3, 2) CHECK (profundidade_jusante BETWEEN 0 AND 10),
    declividade numeric(7, 6) CHECK (declividade BETWEEN 0 AND 2), -- TODO: generated ((cota_jusante - cota_montante) / extensao_digital)
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

COMMENT ON COLUMN :PGSCHEMA.redes_esgoto.diametro IS 'NOTE: Diametro nominal (dn) em milimetros (mm)';

COMMENT ON COLUMN :PGSCHEMA.redes_esgoto.extensao_digital IS 'NOTE: Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.redes_esgoto.cota_montante IS 'NOTE: Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.redes_esgoto.profundidade_montante IS 'NOTE: Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.redes_esgoto.cota_jusante IS 'NOTE: Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.redes_esgoto.profundidade_jusante IS 'NOTE: Metros (m)';

COMMENT ON COLUMN :PGSCHEMA.redes_esgoto.declividade IS 'NOTE: Metros (m)';

CREATE INDEX ON :PGSCHEMA.redes_esgoto USING gist (geom);


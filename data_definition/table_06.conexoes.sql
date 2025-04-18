CREATE TABLE IF NOT EXISTS :PGSCHEMA.conexoes (
    id serial PRIMARY KEY,
    geom geometry(point, :SRID) UNIQUE NOT NULL,
    tipo smallint REFERENCES :PGSCHEMA.tipo_conexao (id) NOT NULL,
    material smallint REFERENCES :PGSCHEMA.tipo_material (id) NOT NULL,
    diametro_entrada smallint CHECK (diametro_entrada BETWEEN 0 AND 1000) NOT NULL,
    diametro_saida smallint CHECK (diametro_saida BETWEEN 0 AND 1000) NOT NULL,
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    localizacao varchar(255),
    observacoes varchar(255),
    rotacao_simbolo numeric -- NOTE: Para rotacao da simbologia no QGIS.
);

COMMENT ON COLUMN :PGSCHEMA.conexoes.diametro_entrada IS 'NOTE : Diametro nominal (dn) em milimetros (mm)';

COMMENT ON COLUMN :PGSCHEMA.conexoes.diametro_saida IS 'NOTE : Diametro nominal (dn) em milimetros (mm)';

COMMENT ON COLUMN :PGSCHEMA.conexoes.profundidade IS 'NOTE : Metros (m)';

CREATE INDEX ON :PGSCHEMA.conexoes USING gist (geom);


CREATE TABLE :PGSCHEMA.redes_esgoto (
    id serial PRIMARY KEY,
    geom geometry(linestring, :SRID) NOT NULL,
    tipo smallint REFERENCES :PGSCHEMA.tipo_rede_esgoto (id) ON DELETE RESTRICT CASCADE NOT NULL,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) ON DELETE RESTRICT NOT NULL, -- TODO: before/after estacoes_tratamento
    material smallint REFERENCES :PGSCHEMA.tipo_material (id) ON DELETE SET NULL NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 100 AND 1000) NOT NULL,
    cota_montante numeric(6, 3) CHECK (cota_montante BETWEEN 0 AND 1000),
    profundidade_montante numeric(3, 2) CHECK (profundidade_montante BETWEEN 0 AND 10),
    cota_jusante numeric(6, 3) CHECK (cota_jusante BETWEEN 0 AND 1000),
    profundidade_jusante numeric(3, 2) CHECK (profundidade_jusante BETWEEN 0 AND 10),
    declividade numeric(7, 6) CHECK (declividade BETWEEN 0 AND 2), -- TODO: generated
    extensao_digital numeric GENERATED ALWAYS AS ((ST_LENGTH (geom))::numeric(8, 2)) STORED,
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) ON DELETE RESTRICT NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.redes_esgoto USING gist (geom);


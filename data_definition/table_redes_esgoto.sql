CREATE TABLE sistema_esgoto.redes_esgoto (
    id serial PRIMARY KEY,
    geom geometry(linestring, 4674) NOT NULL,
    tipo smallint REFERENCES sistema_esgoto.tipo_rede_esgoto (id) NOT NULL,
    esgoto smallint REFERENCES sistema_esgoto.tipo_esgoto (id) NOT NULL,
    material smallint REFERENCES sistema_esgoto.tipo_material (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 0 AND 1000) NOT NULL,
    cota_montante numeric(6, 3) CHECK (cota_montante BETWEEN 0 AND 1000),
    profundidade_montante numeric(3, 2) CHECK (profundidade_montante BETWEEN 0 AND 10),
    cota_jusante numeric(6, 3) CHECK (cota_jusante BETWEEN 0 AND 1000),
    profundidade_jusante numeric(3, 2) CHECK (profundidade_jusante BETWEEN 0 AND 10),
    declividade numeric(7, 6) CHECK (declividade BETWEEN 0 AND 2),
    extensao_digital numeric GENERATED ALWAYS AS ((ST_LENGTH (geom))::numeric(8, 2)) STORED,
    situacao smallint REFERENCES sistema_esgoto.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.redes_esgoto USING gist (geom);


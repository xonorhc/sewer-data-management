CREATE TABLE :PGSCHEMA.redes_esgoto (
    id serial PRIMARY KEY,
    geom geometry(linestring, 4674) NOT NULL,
    tipo smallint REFERENCES :PGSCHEMA.tipo_rede_esgoto (id) NOT NULL,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL,
    material smallint REFERENCES :PGSCHEMA.tipo_material (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 0 AND 1000) NOT NULL,
    cota_montante numeric(6, 3) CHECK (cota_montante BETWEEN 0 AND 1000),
    profundidade_montante numeric(3, 2) CHECK (profundidade_montante BETWEEN 0 AND 10),
    cota_jusante numeric(6, 3) CHECK (cota_jusante BETWEEN 0 AND 1000),
    profundidade_jusante numeric(3, 2) CHECK (profundidade_jusante BETWEEN 0 AND 10),
    declividade numeric(7, 6) CHECK (declividade BETWEEN 0 AND 2),
    extensao_digital numeric GENERATED ALWAYS AS ((ST_LENGTH (geom))::numeric(8, 2)) STORED,
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.redes_esgoto USING gist (geom);

ALTER TABLE :PGSCHEMA.redes_esgoto
    ADD COLUMN data_criacao timestamp,
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON :PGSCHEMA.redes_esgoto
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.inserido_por ();

ALTER TABLE :PGSCHEMA.redes_esgoto
    ADD COLUMN data_atualizacao timestamp,
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON :PGSCHEMA.redes_esgoto
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.atualizado_por ();


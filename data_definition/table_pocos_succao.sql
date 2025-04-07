CREATE TABLE :PGSCHEMA.pocos_succao (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, 4674) UNIQUE NOT NULL,
    id_estacao_elevatoria smallint REFERENCES :PGSCHEMA.estacoes_elevatorias (id),
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
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.pocos_succao USING gist (geom);

ALTER TABLE :PGSCHEMA.pocos_succao
    ADD COLUMN data_criacao timestamp,
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON :PGSCHEMA.pocos_succao
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.inserido_por ();

ALTER TABLE :PGSCHEMA.pocos_succao
    ADD COLUMN data_atualizacao timestamp,
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON :PGSCHEMA.pocos_succao
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.atualizado_por ();


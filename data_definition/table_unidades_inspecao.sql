CREATE TABLE sistema_esgoto.unidades_inspecao (
    id serial PRIMARY KEY,
    geom geometry(point, 4674) UNIQUE NOT NULL,
    tipo smallint REFERENCES sistema_esgoto.tipo_unidade_inspecao (id) NOT NULL,
    forma smallint REFERENCES sistema_esgoto.tipo_forma (id),
    material smallint REFERENCES sistema_esgoto.tipo_material (id),
    diametro smallint CHECK (diametro BETWEEN 0 AND 2000),
    cota_nivel numeric(6, 3) CHECK (cota_nivel BETWEEN 0 AND 1000),
    cota_fundo numeric(6, 3) CHECK (cota_fundo BETWEEN 0 AND 1000),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    forma_tampao smallint REFERENCES sistema_esgoto.tipo_forma (id),
    material_tampao smallint REFERENCES sistema_esgoto.tipo_material (id),
    diametro_tampao smallint CHECK (diametro_tampao BETWEEN 0 AND 1200),
    extravasor boolean,
    cota_extravasor numeric(6, 3) CHECK (cota_extravasor BETWEEN 0 AND 1000),
    profundidade_extravasor numeric(3, 2) CHECK (profundidade_extravasor BETWEEN 0 AND 10),
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.unidades_inspecao USING gist (geom);

ALTER TABLE sistema_esgoto.unidades_inspecao
    ADD COLUMN data_criacao timestamp,
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON sistema_esgoto.unidades_inspecao
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.inserido_por ();

ALTER TABLE sistema_esgoto.unidades_inspecao
    ADD COLUMN data_atualizacao timestamp,
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON sistema_esgoto.unidades_inspecao
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.atualizado_por ();


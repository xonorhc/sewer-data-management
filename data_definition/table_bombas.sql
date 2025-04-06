CREATE TABLE sistema_esgoto.bombas (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, 4674) UNIQUE NOT NULL,
    id_estacao_elevatoria integer REFERENCES sistema_esgoto.estacoes_elevatorias (id),
    tipo smallint REFERENCES sistema_esgoto.tipo_bomba (id),
    diametro_entrada smallint CHECK (diametro_entrada BETWEEN 0 AND 1000),
    diametro_saida smallint CHECK (diametro_saida BETWEEN 0 AND 1000),
    vazao numeric(6, 2) CHECK (vazao BETWEEN 0 AND 5000),
    potencia numeric(6, 2) CHECK (potencia BETWEEN 0 AND 1000),
    pressao numeric(4, 1) CHECK (pressao BETWEEN 0 AND 200),
    situacao smallint REFERENCES sistema_esgoto.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.bombas USING gist (geom);

ALTER TABLE sistema_esgoto.bombas
    ADD COLUMN data_criacao timestamp
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON sistema_esgoto.bombas
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.inserido_por ();

ALTER TABLE sistema_esgoto.bombas
    ADD COLUMN data_atualizacao timestamp
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON sistema_esgoto.bombas
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.atualizado_por ();


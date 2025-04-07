CREATE TABLE sistema_esgoto.estacoes_tratamento (
    id serial PRIMARY KEY,
    geom geometry(point, 4674) UNIQUE NOT NULL,
    nome varchar(50) UNIQUE,
    nivel_tratamento smallint REFERENCES sistema_esgoto.tipo_tratamento_nivel (id),
    tecnologia smallint[], -- ISSUE: references tipo_tratamento_tecnologia
    vazao numeric(6, 2) CHECK (vazao BETWEEN 0 AND 5000),
    situacao smallint REFERENCES sistema_esgoto.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.estacoes_tratamento USING gist (geom);

ALTER TABLE sistema_esgoto.estacoes_tratamento
    ADD COLUMN data_criacao timestamp,
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON sistema_esgoto.estacoes_tratamento
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.inserido_por ();

ALTER TABLE sistema_esgoto.estacoes_tratamento
    ADD COLUMN data_atualizacao timestamp,
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON sistema_esgoto.estacoes_tratamento
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.atualizado_por ();


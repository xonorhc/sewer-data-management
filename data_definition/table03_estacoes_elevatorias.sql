CREATE TABLE :PGSCHEMA.estacoes_elevatorias (
    id serial PRIMARY KEY,
    geom geometry(polygon, 4674) NOT NULL,
    nome varchar(50) NOT NULL UNIQUE,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL,
    situacao smallint REFERENCES :PGSCHEMA.tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.estacoes_elevatorias USING gist (geom);

ALTER TABLE :PGSCHEMA.estacoes_elevatorias
    ADD COLUMN data_criacao timestamp,
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON :PGSCHEMA.estacoes_elevatorias
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.inserido_por ();

ALTER TABLE :PGSCHEMA.estacoes_elevatorias
    ADD COLUMN data_atualizacao timestamp,
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON :PGSCHEMA.estacoes_elevatorias
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.atualizado_por ();


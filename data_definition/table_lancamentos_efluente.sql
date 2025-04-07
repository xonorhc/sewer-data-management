CREATE TABLE :PGSCHEMA.lancamentos_efluente (
    id serial PRIMARY KEY,
    geom geometry(point, 4674) UNIQUE NOT NULL,
    tipo smallint REFERENCES :PGSCHEMA.tipo_lancamento (id) NOT NULL,
    local_lancamento smallint REFERENCES :PGSCHEMA.tipo_descarga (id) NOT NULL,
    esgoto smallint REFERENCES :PGSCHEMA.tipo_esgoto (id) NOT NULL,
    tipo_corpo_receptor smallint REFERENCES :PGSCHEMA.tipo_manancial (id),
    nome_corpo_receptor varchar, -- ISSUE: references hidrografia
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON :PGSCHEMA.lancamentos_efluente USING gist (geom);

ALTER TABLE :PGSCHEMA.lancamentos_efluente
    ADD COLUMN data_criacao timestamp,
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON :PGSCHEMA.lancamentos_efluente
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.inserido_por ();

ALTER TABLE :PGSCHEMA.lancamentos_efluente
    ADD COLUMN data_atualizacao timestamp,
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON :PGSCHEMA.lancamentos_efluente
    FOR EACH ROW
    EXECUTE FUNCTION :PGSCHEMA.atualizado_por ();


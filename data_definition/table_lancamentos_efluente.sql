CREATE TABLE sistema_esgoto.lancamentos_efluente (
    id serial PRIMARY KEY,
    geom geometry(point, 4674) UNIQUE NOT NULL,
    tipo smallint REFERENCES sistema_esgoto.tipo_lancamento (id) NOT NULL,
    local_lancamento smallint REFERENCES sistema_esgoto.tipo_descarga (id) NOT NULL,
    esgoto smallint REFERENCES sistema_esgoto.tipo_esgoto (id) NOT NULL,
    tipo_corpo_receptor smallint REFERENCES sistema_esgoto.tipo_manancial (id),
    nome_corpo_receptor varchar, -- ISSUE: references hidrografia
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON sistema_esgoto.lancamentos_efluente USING gist (geom);

ALTER TABLE sistema_esgoto.lancamentos_efluente
    ADD COLUMN data_criacao timestamp
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON sistema_esgoto.lancamentos_efluente
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.inserido_por ();

ALTER TABLE sistema_esgoto.lancamentos_efluente
    ADD COLUMN data_atualizacao timestamp
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON sistema_esgoto.lancamentos_efluente
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.atualizado_por ();


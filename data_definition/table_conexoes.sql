CREATE TABLE sistema_esgoto.conexoes (
    id serial PRIMARY KEY,
    geom geometry(point, 4674) UNIQUE NOT NULL,
    tipo smallint REFERENCES sistema_esgoto.tipo_conexao (id) NOT NULL,
    material smallint REFERENCES sistema_esgoto.tipo_material (id) NOT NULL,
    diametro_entrada smallint CHECK (diametro_entrada BETWEEN 0 AND 1000) NOT NULL,
    diametro_saida smallint CHECK (diametro_saida BETWEEN 0 AND 1000) NOT NULL,
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    localizacao varchar(255),
    observacoes varchar(255),
    rotacao_simbolo numeric
);

CREATE INDEX ON sistema_esgoto.conexoes USING gist (geom);

ALTER TABLE sistema_esgoto.conexoes
    ADD COLUMN data_criacao timestamp
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON sistema_esgoto.conexoes
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.inserido_por ();

ALTER TABLE sistema_esgoto.conexoes
    ADD COLUMN data_atualizacao timestamp
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON sistema_esgoto.conexoes
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.atualizado_por ();


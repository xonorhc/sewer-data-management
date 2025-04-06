CREATE TABLE sistema_esgoto.valvulas (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, 4674) UNIQUE NOT NULL,
    tipo smallint REFERENCES tipo_valvula (id) NOT NULL,
    funcao smallint REFERENCES tipo_valvula_funcao (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 0 AND 1000) NOT NULL,
    acionamento smallint REFERENCES tipo_valvula_acionamento (id),
    acesso smallint REFERENCES tipo_valvula_acesso (id),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    posicao smallint REFERENCES tipo_valvula_posicao (id) NOT NULL,
    qtd_voltas_fechar numeric(3, 1),
    situacao smallint REFERENCES tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255),
    rotacao_simbolo numeric
);

CREATE INDEX ON sistema_esgoto.valvulas USING gist (geom);

ALTER TABLE sistema_esgoto.valvulas
    ADD COLUMN data_criacao timestamp
    ADD COLUMN usuario_criacao varchar(20);

CREATE OR REPLACE TRIGGER trig_inserido_por
    BEFORE INSERT ON sistema_esgoto.valvulas
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.inserido_por ();

ALTER TABLE sistema_esgoto.valvulas
    ADD COLUMN data_atualizacao timestamp
    ADD COLUMN usuario_atualizacao varchar(20);

CREATE OR REPLACE TRIGGER trig_atualizado_por
    BEFORE UPDATE ON sistema_esgoto.valvulas
    FOR EACH ROW
    EXECUTE FUNCTION sistema_esgoto.atualizado_por ();


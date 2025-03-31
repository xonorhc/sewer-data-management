CREATE TABLE tipo_rede_esgoto (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_esgoto (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_material (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_situacao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE redes_esgoto (
    id serial PRIMARY KEY,
    geom geometry(linestring, 31984) NOT NULL,
    tipo smallint REFERENCES tipo_rede_esgoto (id) NOT NULL,
    esgoto smallint REFERENCES tipo_esgoto (id) NOT NULL,
    material smallint REFERENCES tipo_material (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 0 AND 1000) NOT NULL,
    cota_montante numeric(6, 3) CHECK (cota_montante BETWEEN 0 AND 1000),
    profundidade_montante numeric(3, 2) CHECK (profundidade_montante BETWEEN 0 AND 10),
    cota_jusante numeric(6, 3) CHECK (cota_jusante BETWEEN 0 AND 1000),
    profundidade_jusante numeric(3, 2) CHECK (profundidade_jusante BETWEEN 0 AND 10),
    declividade numeric(7, 6) CHECK (declividade BETWEEN 0 AND 2),
    -- HACK: extensao_digital numeric GENERATED ALWAYS AS ((ST_LENGTH (geom))::numeric(8, 2)) STORED,
    situacao smallint REFERENCES tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON redes_esgoto USING gist (geom);

CREATE TABLE setores_esgotamento (
    id serial PRIMARY KEY,
    geom geometry(polygon, 31984) NOT NULL,
    observacoes varchar(255)
);

CREATE INDEX ON setores_esgotamento USING gist (geom);

CREATE TABLE tipo_nivel_tratamento_esgoto (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_tecnologia_tratamento_esgoto (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE estacoes_tratamento (
    id serial PRIMARY KEY,
    geom geometry(point, 31984) UNIQUE NOT NULL,
    nome varchar(50) UNIQUE,
    nivel_tratamento smallint REFERENCES tipo_nivel_tratamento_esgoto (id),
    tecnologia smallint[], -- ISSUE: references tipo_tecnologia_tratamento_esgoto(id)
    vazao numeric(6, 2) CHECK (vazao BETWEEN 0 AND 5000),
    situacao smallint REFERENCES tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON estacoes_tratamento USING gist (geom);

CREATE TABLE estacoes_elevatorias (
    id serial PRIMARY KEY,
    geom geometry(polygon, 31984) NOT NULL,
    nome varchar(50) NOT NULL UNIQUE,
    esgoto smallint REFERENCES tipo_esgoto (id) NOT NULL,
    situacao smallint REFERENCES tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON estacoes_elevatorias USING gist (geom);

CREATE TABLE tipo_bomba (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE bombas (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, 31984) UNIQUE NOT NULL,
    id_estacao_elevatoria integer REFERENCES estacoes_elevatorias (id),
    tipo smallint REFERENCES tipo_bomba (id),
    diametro_entrada smallint CHECK (diametro_entrada BETWEEN 0 AND 1000),
    diametro_saida smallint CHECK (diametro_saida BETWEEN 0 AND 1000),
    vazao numeric(6, 2) CHECK (vazao BETWEEN 0 AND 5000),
    potencia numeric(6, 2) CHECK (potencia BETWEEN 0 AND 1000),
    pressao numeric(4, 1) CHECK (pressao BETWEEN 0 AND 200),
    situacao smallint REFERENCES tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON bombas USING gist (geom);

CREATE TABLE tipo_forma (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE pocos_succao (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, 31984) UNIQUE NOT NULL,
    id_estacao_elevatoria smallint REFERENCES estacoes_elevatorias (id),
    cota_nivel numeric(6, 3) CHECK (cota_nivel BETWEEN 0 AND 1000),
    cota_fundo numeric(6, 3) CHECK (cota_fundo BETWEEN 0 AND 1000),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    diametro smallint CHECK (diametro BETWEEN 0 AND 2000),
    volume integer CHECK (volume BETWEEN 0 AND 1000),
    nivel_min numeric(3, 2) CHECK (nivel_min BETWEEN 0 AND 10),
    nivel_max numeric(3, 2) CHECK (nivel_max BETWEEN 0 AND 10),
    forma_tampao smallint REFERENCES tipo_forma (id),
    material_tampao smallint REFERENCES tipo_material (id),
    diametro_tampao smallint CHECK (diametro_tampao BETWEEN 0 AND 1200),
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON pocos_succao USING gist (geom);

CREATE TABLE tipo_lancamento (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_manancial (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE lancamentos_efluente (
    id serial PRIMARY KEY,
    geom geometry(point, 31984) UNIQUE NOT NULL,
    tipo smallint REFERENCES tipo_lancamento (id) NOT NULL,
    local_lancamento smallint REFERENCES tipo_descarga (id) NOT NULL,
    esgoto smallint REFERENCES tipo_esgoto (id) NOT NULL,
    tipo_corpo_receptor smallint REFERENCES tipo_manancial (id),
    nome_corpo_receptor varchar, -- ISSUE: references hidrografia
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON lancamentos_efluente USING gist (geom);

CREATE TABLE tipo_valvula (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_funcao_valvula (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_acionamento_valvula (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_acesso_valvula (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE tipo_posicao_valvula (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE valvulas (
    id serial PRIMARY KEY,
    geom GEOMETRY(point, 31984) UNIQUE NOT NULL,
    tipo smallint REFERENCES tipo_valvula (id) NOT NULL,
    funcao smallint REFERENCES tipo_funcao_valvula (id) NOT NULL,
    diametro smallint CHECK (diametro BETWEEN 0 AND 1000) NOT NULL,
    acionamento smallint REFERENCES tipo_acionamento_valvula (id),
    acesso smallint REFERENCES tipo_acesso_valvula (id),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    posicao smallint REFERENCES tipo_posicao_valvula (id) NOT NULL,
    qtd_voltas_fechar numeric(3, 1),
    situacao smallint REFERENCES tipo_situacao (id) NOT NULL,
    localizacao varchar(255),
    observacoes varchar(255),
    rotacao_simbolo numeric
);

CREATE INDEX ON valvulas USING gist (geom);

CREATE TABLE tipo_unidade_inspecao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE unidades_inspecao (
    id serial PRIMARY KEY,
    geom geometry(point, 31984) UNIQUE NOT NULL,
    tipo smallint REFERENCES tipo_unidade_inspecao (id) NOT NULL,
    forma smallint REFERENCES tipo_forma (id),
    material smallint REFERENCES tipo_material (id),
    diametro smallint CHECK (diametro BETWEEN 0 AND 2000),
    cota_nivel numeric(6, 3) CHECK (cota_nivel BETWEEN 0 AND 1000),
    cota_fundo numeric(6, 3) CHECK (cota_fundo BETWEEN 0 AND 1000),
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    forma_tampao smallint REFERENCES tipo_forma (id),
    material_tampao smallint REFERENCES tipo_material (id),
    diametro_tampao smallint CHECK (diametro_tampao BETWEEN 0 AND 1200),
    extravasor boolean,
    cota_extravasor numeric(6, 3) CHECK (cota_extravasor BETWEEN 0 AND 1000),
    profundidade_extravasor numeric(3, 2) CHECK (profundidade_extravasor BETWEEN 0 AND 10),
    localizacao varchar(255),
    observacoes varchar(255)
);

CREATE INDEX ON unidades_inspecao USING gist (geom);

CREATE TABLE tipo_conexao (
    id smallint PRIMARY KEY,
    tipo varchar UNIQUE NOT NULL
);

CREATE TABLE conexoes (
    id serial PRIMARY KEY,
    geom geometry(point, 31984) UNIQUE NOT NULL,
    tipo smallint REFERENCES tipo_conexao (id) NOT NULL,
    material smallint REFERENCES tipo_material (id) NOT NULL,
    diametro_entrada smallint CHECK (diametro_entrada BETWEEN 0 AND 1000) NOT NULL,
    diametro_saida smallint CHECK (diametro_saida BETWEEN 0 AND 1000) NOT NULL,
    profundidade numeric(3, 2) CHECK (profundidade BETWEEN 0 AND 10),
    localizacao varchar(255),
    observacoes varchar(255),
    rotacao_simbolo numeric
);

CREATE INDEX ON conexoes USING gist (geom);


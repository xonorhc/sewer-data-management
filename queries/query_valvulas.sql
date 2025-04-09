DROP MATERIALIZED VIEW IF EXISTS cadastro_tecnico.ses_valvulas;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastro_tecnico.ses_valvulas AS
SELECT
    sv.id,
    sv.geom,
    tv.tipo,
    tfv.tipo AS funcao,
    sv.diametro,
    tav.tipo AS acionamento,
    tav2.tipo AS acesso,
    sv.profundidade,
    tpv.tipo AS posicao,
    sv.qtd_voltas_fechar,
    sv.localizacao,
    sv.observacoes
FROM
    fdw_ct.ses_valvulas AS sv
    LEFT JOIN fdw_ct.tipo_valvula AS tv ON tv.id = sv.tipo
    LEFT JOIN fdw_ct.tipo_funcao_valvula AS tfv ON tfv.id = sv.funcao
    LEFT JOIN fdw_ct.tipo_acionamento_valvula AS tav ON tav.id = sv.acionamento
    LEFT JOIN fdw_ct.tipo_acesso_valvula AS tav2 ON tav2.id = sv.acesso
    LEFT JOIN fdw_ct.tipo_posicao_valvula AS tpv ON tpv.id = sv.posicao
WHERE
    sv.geom IS NOT NULL
    AND st_intersects (sv.geom, (
            SELECT
                st_collect (geom) AS geom FROM fdw_ct.ses_redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON cadastro_tecnico.ses_valvulas USING gist (geom);

CREATE UNIQUE INDEX ON cadastro_tecnico.ses_valvulas (id);


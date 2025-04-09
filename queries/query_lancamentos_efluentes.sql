DROP MATERIALIZED VIEW IF EXISTS cadastro_tecnico.ses_lancamentos_efluente;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastro_tecnico.ses_lancamentos_efluente AS
SELECT
    sle.id,
    sle.geom,
    tl.tipo,
    td.tipo AS local_lancamento,
    te.tipo AS esgoto,
    tm.tipo AS tipo_corpo_receptor,
    sle.nome_corpo_receptor,
    sle.localizacao,
    sle.observacoes
FROM
    fdw_ct.ses_lancamentos_efluente AS sle
    LEFT JOIN fdw_ct.tipo_lancamento AS tl ON tl.id = sle.tipo
    LEFT JOIN fdw_ct.tipo_descarga AS td ON td.id = sle.local_lancamento
    LEFT JOIN fdw_ct.tipo_esgoto AS te ON te.id = sle.esgoto
    LEFT JOIN fdw_ct.tipo_manancial AS tm ON tm.id = sle.tipo_corpo_receptor
WHERE
    sle.geom IS NOT NULL
    AND st_intersects (sle.geom, (
            SELECT
                st_collect (geom) AS geom FROM fdw_ct.ses_redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON cadastro_tecnico.ses_lancamentos_efluente USING gist (geom);

CREATE UNIQUE INDEX ON cadastro_tecnico.ses_lancamentos_efluente (id);


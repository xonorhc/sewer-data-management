SET search_path TO :PGSCHEMA, public;

CREATE MATERIALIZED VIEW IF NOT EXISTS :MVSCHEMA.se_setores_esgotamento AS
SELECT
    se.id,
    se.geom,
    se.observacoes,
    concat(et.id, ' - ', et.nome) AS estacao_tratamento,
    sum(re.extensao_digital) AS extensao_rede
FROM
    setores_esgotamento se
    LEFT JOIN estacoes_tratamento et ON st_contains (se.geom, et.geom)
    LEFT JOIN redes_esgoto re ON st_contains (se.geom, re.geom)
WHERE
    se.geom IS NOT NULL
GROUP BY
    se.id,
    et.id;

CREATE INDEX ON :MVSCHEMA.se_setores_esgotamento USING gist (geom);

CREATE UNIQUE INDEX ON :MVSCHEMA.se_setores_esgotamento (id);

GRANT SELECT ON :MVSCHEMA.se_setores_esgotamento TO PUBLIC;


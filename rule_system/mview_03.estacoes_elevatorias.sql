SET search_path TO :PGSCHEMA, public;

CREATE MATERIALIZED VIEW IF NOT EXISTS :MVSCHEMA.se_estacoes_elevatorias AS
SELECT
    ee.id,
    ee.geom,
    ee.nome,
    te.tipo AS esgoto,
    ts.tipo AS situacao,
    ee.localizacao,
    ee.observacoes,
    string_agg('B' || b.id::text, ',') AS bomba_id,
    string_agg('PS' || ps.id::text, ',') AS poco_succao_id
FROM
    estacoes_elevatorias ee
    LEFT JOIN tipo_esgoto te ON te.id = ee.esgoto
    LEFT JOIN tipo_situacao ts ON ts.id = ee.situacao
    LEFT JOIN bombas b ON st_contains (ee.geom, b.geom)
    LEFT JOIN pocos_succao ps ON st_contains (ee.geom, ps.geom)
WHERE
    ee.geom IS NOT NULL
GROUP BY
    ee.id,
    ee.geom,
    ee.nome,
    te.tipo,
    ts.tipo,
    ee.localizacao,
    ee.observacoes;

CREATE INDEX ON :MVSCHEMA.se_estacoes_elevatorias USING gist (geom);

CREATE UNIQUE INDEX ON :MVSCHEMA.se_estacoes_elevatorias (id);

GRANT SELECT ON :MVSCHEMA.se_estacoes_elevatorias TO PUBLIC;


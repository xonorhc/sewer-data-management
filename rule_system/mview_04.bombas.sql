SET search_path TO :PGSCHEMA, public;

CREATE MATERIALIZED VIEW IF NOT EXISTS :MVSCHEMA.se_bombas AS
SELECT
    b.id,
    b.geom,
    concat(ee.id || ' - ', ee.nome) AS estacao_elevatoria,
    tb.tipo,
    b.diametro_entrada,
    b.diametro_saida,
    b.vazao,
    b.potencia,
    b.pressao,
    ts.tipo AS situacao,
    b.localizacao,
    b.observacoes
FROM
    bombas b
    LEFT JOIN tipo_bomba tb ON tb.id = b.tipo
    LEFT JOIN tipo_situacao ts ON ts.id = b.situacao
    LEFT JOIN estacoes_elevatorias ee ON st_within (b.geom, ee.geom) -- on b.id_estacao_elevatoria = ee.id
WHERE
    b.geom IS NOT NULL
    AND st_intersects (b.geom, (
            SELECT
                st_collect (geom) AS geom FROM redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON :MVSCHEMA.se_bombas USING gist (geom);

CREATE UNIQUE INDEX ON :MVSCHEMA.se_bombas (id);

GRANT SELECT ON :MVSCHEMA.se_bombas TO PUBLIC;


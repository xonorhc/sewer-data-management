SET search_path TO :PGSCHEMA, public;

CREATE MATERIALIZED VIEW IF NOT EXISTS :MVSCHEMA.se_pocos_succao AS
SELECT
    ps.id,
    ps.geom,
    concat(ee.id || ' - ', ee.nome) AS estacao_elevatoria,
    ps.cota_nivel,
    ps.cota_fundo,
    ps.profundidade,
    ps.diametro,
    ps.volume,
    ps.nivel_max,
    ps.nivel_min,
    tf.tipo AS forma_tampao,
    tm.tipo AS material_tampao,
    ps.diametro_tampao,
    ps.localizacao,
    ps.observacoes
FROM
    pocos_succao ps
    LEFT JOIN tipo_forma tf ON tf.id = ps.forma_tampao
    LEFT JOIN tipo_material tm ON tm.id = ps.material_tampao
    LEFT JOIN estacoes_elevatorias ee ON st_contains (ee.geom, ps.geom) -- on ps.id_estacao_elevatoria = ee.id
WHERE
    ps.geom IS NOT NULL
    AND st_intersects (ps.geom, (
            SELECT
                st_collect (geom) AS geom FROM redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON :MVSCHEMA.se_pocos_succao USING gist (geom);

CREATE UNIQUE INDEX ON :MVSCHEMA.se_pocos_succao (id);

GRANT SELECT ON :MVSCHEMA.se_pocos_succao TO PUBLIC;


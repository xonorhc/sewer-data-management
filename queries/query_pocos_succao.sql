DROP MATERIALIZED VIEW IF EXISTS cadastro_tecnico.ses_pocos_succao;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastro_tecnico.ses_pocos_succao AS
SELECT
    sps.id,
    sps.geom,
    sps.cota_nivel,
    sps.cota_fundo,
    sps.profundidade,
    sps.diametro,
    sps.volume,
    sps.nivel_max,
    sps.nivel_min,
    tf2.tipo AS forma_tampao,
    tm2.tipo AS material_tampao,
    sps.diametro_tampao,
    sps.observacoes
FROM
    fdw_ct.ses_pocos_succao AS sps
    LEFT JOIN fdw_ct.tipo_forma AS tf2 ON tf2.id = sps.forma_tampao
    LEFT JOIN fdw_ct.tipo_material AS tm2 ON tm2.id = sps.material_tampao
WHERE
    sps.geom IS NOT NULL
    AND st_intersects (sps.geom, (
            SELECT
                st_collect (geom) AS geom FROM fdw_ct.ses_redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON cadastro_tecnico.ses_pocos_succao USING gist (geom);

CREATE UNIQUE INDEX ON cadastro_tecnico.ses_pocos_succao (id);


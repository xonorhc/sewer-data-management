DROP MATERIALIZED VIEW IF EXISTS cadastro_tecnico.ses_unidades_inspecao;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastro_tecnico.ses_unidades_inspecao AS
SELECT
    sui.id,
    sui.geom,
    tui.tipo,
    tf.tipo AS forma,
    tm.tipo AS material,
    sui.diametro,
    sui.cota_nivel,
    sui.cota_fundo,
    sui.profundidade,
    tf2.tipo AS forma_tampao,
    tm2.tipo AS material_tampao,
    sui.diametro_tampao,
    sui.extravasor,
    sui.cota_extravasor,
    sui.profundidade_extravasor,
    sui.localizacao,
    sui.observacoes
FROM
    fdw_ct.ses_unidades_inspecao AS sui
    LEFT JOIN fdw_ct.tipo_unidade_inspecao AS tui ON tui.id = sui.tipo
    LEFT JOIN fdw_ct.tipo_forma AS tf ON tf.id = sui.forma
    LEFT JOIN fdw_ct.tipo_forma AS tf2 ON tf2.id = sui.forma_tampao
    LEFT JOIN fdw_ct.tipo_material AS tm ON tm.id = sui.material
    LEFT JOIN fdw_ct.tipo_material AS tm2 ON tm2.id = sui.material_tampao
WHERE
    sui.geom IS NOT NULL
    AND st_intersects (sui.geom, (
            SELECT
                st_collect (geom) AS geom FROM fdw_ct.ses_redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON cadastro_tecnico.ses_unidades_inspecao USING gist (geom);

CREATE UNIQUE INDEX ON cadastro_tecnico.ses_unidades_inspecao (id);


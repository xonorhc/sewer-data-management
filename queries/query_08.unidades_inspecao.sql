SET search_path TO sistema_esgoto, public;

SELECT
    ui.id,
    ui.geom,
    ui.tipo,
    tf.tipo AS forma,
    tm.tipo AS material,
    ui.diametro,
    ui.cota_nivel,
    ui.cota_fundo,
    ui.profundidade,
    tf2.tipo AS forma_tampao,
    tm2.tipo AS material_tampao,
    ui.diametro_tampao,
    ui.extravasor,
    ui.cota_extravasor,
    ui.profundidade_extravasor,
    ui.localizacao,
    ui.observacoes
FROM
    unidades_inspecao ui
    LEFT JOIN tipo_unidade_inspecao tui ON tui.id = ui.tipo
    LEFT JOIN tipo_forma tf ON tf.id = ui.forma
    LEFT JOIN tipo_forma tf2 ON tf2.id = ui.forma_tampao
    LEFT JOIN tipo_material tm ON tm.id = ui.material
    LEFT JOIN tipo_material tm2 ON tm2.id = ui.material_tampao
WHERE
    ui.geom IS NOT NULL
    AND st_intersects (ui.geom, (
            SELECT
                st_collect (geom) AS geom FROM redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1))
    AND ui.material <> ui.material_tampao;

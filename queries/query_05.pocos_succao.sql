SET search_path TO sistema_esgoto, public;

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

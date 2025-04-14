SET search_path TO sistema_esgoto, public;

SELECT
    ee.id,
    ee.geom,
    ee.nome,
    te.tipo AS esgoto,
    ts.tipo AS situacao,
    ee.localizacao,
    ee.observacoes,
    array_agg(DISTINCT b.id) AS id_bomba,
    array_agg(DISTINCT ps.id) AS id_poco_succao
FROM
    estacoes_elevatorias ee
    LEFT JOIN tipo_esgoto te ON te.id = ee.esgoto
    LEFT JOIN tipo_situacao ts ON ts.id = ee.situacao
    LEFT JOIN ( SELECT id, geom
        FROM bombas
        WHERE situacao = 1) b ON st_contains (ee.geom, b.geom)
    LEFT JOIN ( SELECT id, geom
        FROM pocos_succao
        WHERE geom IS NOT NULL) ps ON st_contains (ee.geom, ps.geom)
WHERE
    ee.geom IS NOT NULL
GROUP BY
    ee.id,
    te.tipo,
    ts.tipo;


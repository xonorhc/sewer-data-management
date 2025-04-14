SET search_path TO sistema_esgoto, public;

SELECT DISTINCT ON (se.id)
    se.id,
    se.geom,
    se.observacoes,
    array_agg(DISTINCT concat(et.id || ' - ', et.nome)) AS estacoes_tratamento,
    array_agg(DISTINCT concat(ee.id || ' - ', ee.nome)) AS estacoes_elevatorias,
    sum(re.extensao_digital) AS extensao_rede
FROM
    setores_esgotamento se
    LEFT JOIN ( SELECT id, geom, nome
        FROM estacoes_tratamento
        WHERE situacao = 1) et ON st_contains (se.geom, et.geom)
    LEFT JOIN ( SELECT id, geom, nome
        FROM estacoes_elevatorias
        WHERE situacao = 1) ee ON st_intersects (se.geom, ee.geom)
    LEFT JOIN ( SELECT id, geom, extensao_digital
        FROM redes_esgoto
        WHERE situacao = 1) re ON st_contains (se.geom, re.geom)
WHERE
    se.geom IS NOT NULL
GROUP BY
    se.id,
    et.id;


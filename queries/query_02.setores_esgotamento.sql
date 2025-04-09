SET search_path TO sistema_esgoto, public;

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


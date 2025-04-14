SET search_path TO sistema_esgoto, public;

SELECT
    b.id,
    b.geom,
    ee.id AS id_estacao_elevatoria,
    ee.nome AS nome_estacao_elevatoria,
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
    LEFT JOIN estacoes_elevatorias ee ON st_within (b.geom, ee.geom)
WHERE
    b.geom IS NOT NULL
    AND st_intersects (b.geom, (
            SELECT
                st_collect (geom) AS geom FROM redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));


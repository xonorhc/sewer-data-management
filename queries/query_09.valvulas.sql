SET search_path TO sistema_esgoto, public;

SELECT
    v.id,
    v.geom,
    tv.tipo,
    tvf.tipo AS funcao,
    v.diametro,
    tva.tipo AS acionamento,
    tvac.tipo AS acesso,
    v.profundidade,
    tvp.tipo AS posicao,
    v.qtd_voltas_fechar,
    v.localizacao,
    v.observacoes
FROM
    valvulas AS v
    LEFT JOIN tipo_valvula AS tv ON tv.id = v.tipo
    LEFT JOIN tipo_valvula_funcao AS tvf ON tvf.id = v.funcao
    LEFT JOIN tipo_valvula_acionamento AS tva ON tva.id = v.acionamento
    LEFT JOIN tipo_valvula_acesso AS tvac ON tvac.id = v.acesso
    LEFT JOIN tipo_valvula_posicao AS tvp ON tvp.id = v.posicao
WHERE
    v.geom IS NOT NULL
    AND st_intersects (v.geom, (
            SELECT
                st_collect (geom) AS geom FROM redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));


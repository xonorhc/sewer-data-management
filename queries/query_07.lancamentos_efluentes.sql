SET search_path TO sistema_esgoto, public;

SELECT
    le.id,
    le.geom,
    tl.tipo,
    td.tipo AS local_lancamento,
    te.tipo AS esgoto,
    tm.tipo AS tipo_corpo_receptor,
    le.nome_corpo_receptor,
    le.localizacao,
    le.observacoes
FROM
    lancamentos_efluente le
    LEFT JOIN tipo_lancamento tl ON tl.id = le.tipo
    LEFT JOIN tipo_descarga td ON td.id = le.local_lancamento
    LEFT JOIN tipo_esgoto te ON te.id = le.esgoto
    LEFT JOIN tipo_manancial tm ON tm.id = le.tipo_corpo_receptor
WHERE
    le.geom IS NOT NULL
    AND st_intersects (le.geom, (
            SELECT
                st_collect (geom) AS geom FROM fdw_ct.ses_redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

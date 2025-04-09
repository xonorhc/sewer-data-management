DROP MATERIALIZED VIEW IF EXISTS cadastro_tecnico.ses_bombas;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastro_tecnico.ses_bombas AS
SELECT
    sb.id,
    sb.geom,
    tb.tipo AS bomba,
    sb.diametro_entrada,
    sb.diametro_saida,
    sb.vazao,
    sb.potencia,
    sb.pressao,
    ts.tipo AS situacao,
    sb.observacoes
FROM
    fdw_ct.ses_bombas AS sb
    LEFT JOIN fdw_ct.tipo_bomba AS tb ON tb.id = sb.tipo
    LEFT JOIN fdw_ct.tipo_situacao AS ts ON ts.id = sb.situacao
WHERE
    sb.geom IS NOT NULL
    AND st_intersects (sb.geom, (
            SELECT
                st_collect (geom) AS geom FROM fdw_ct.ses_redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON cadastro_tecnico.ses_bombas USING gist (geom);

CREATE UNIQUE INDEX ON cadastro_tecnico.ses_bombas (id);


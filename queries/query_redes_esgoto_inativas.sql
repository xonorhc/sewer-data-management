DROP MATERIALIZED VIEW IF EXISTS cadastro_tecnico.ses_redes_esgoto_inativas;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastro_tecnico.ses_redes_esgoto_inativas AS
SELECT
    sre.id,
    sre.geom,
    tre.tipo,
    te.tipo AS esgoto,
    tm.tipo AS material,
    sre.diametro,
    sre.cota_montante,
    sre.profundidade_montante,
    sre.cota_jusante,
    sre.profundidade_jusante,
    sre.declividade,
    sre.extensao_digital,
    ts.tipo AS situacao,
    tg.tipo AS gerenciado,
    sre.localizacao,
    sre.observacoes
FROM
    fdw_ct.ses_redes_esgoto AS sre
    LEFT JOIN fdw_ct.tipo_rede_esgoto AS tre ON tre.id = sre.tipo
    LEFT JOIN fdw_ct.tipo_esgoto AS te ON te.id = sre.esgoto
    LEFT JOIN fdw_ct.tipo_material AS tm ON tm.id = sre.material
    LEFT JOIN fdw_ct.tipo_situacao AS ts ON ts.id = sre.situacao
    LEFT JOIN fdw_ct.tipo_gerenciado AS tg ON tg.id = sre.gerenciado
WHERE
    sre.geom IS NOT NULL
    AND sre.situacao != 1;

CREATE INDEX ON cadastro_tecnico.ses_redes_esgoto_inativas USING gist (geom);

CREATE UNIQUE INDEX ON cadastro_tecnico.ses_redes_esgoto_inativas (id);


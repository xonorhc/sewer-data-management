SET search_path TO :PGSCHEMA, public;

CREATE MATERIALIZED VIEW IF NOT EXISTS :MVSCHEMA.se_redes_esgoto AS
SELECT
    re.id,
    re.geom,
    tre.tipo,
    te.tipo AS esgoto,
    tm.tipo AS material,
    re.diametro,
    re.cota_montante,
    re.profundidade_montante,
    re.cota_jusante,
    re.profundidade_jusante,
    re.declividade,
    re.extensao_digital,
    ts.tipo AS situacao,
    re.localizacao,
    re.observacoes
FROM
    redes_esgoto re
    LEFT JOIN tipo_rede_esgoto tre ON tre.id = re.tipo
    LEFT JOIN tipo_esgoto te ON te.id = re.esgoto
    LEFT JOIN tipo_material tm ON tm.id = re.material
    LEFT JOIN tipo_situacao ts ON ts.id = re.situacao
WHERE
    re.geom IS NOT NULL
    AND re.situacao = 1;

CREATE INDEX ON :MVSCHEMA.se_redes_esgoto USING gist (geom);

CREATE UNIQUE INDEX ON :MVSCHEMA.se_redes_esgoto (id);

GRANT SELECT ON :MVSCHEMA.se_redes_esgoto TO PUBLIC;


SET search_path TO :PGSCHEMA, public;

CREATE MATERIALIZED VIEW IF NOT EXISTS :MVSCHEMA.se_conexoes AS
SELECT
    c.id,
    c.geom,
    tc.tipo,
    tm.tipo AS material,
    c.diametro_entrada,
    c.diametro_saida,
    c.profundidade,
    c.localizacao,
    c.observacoes,
    c.rotacao_simbolo
FROM
    conexoes c
    LEFT JOIN tipo_conexao tc ON tc.id = c.tipo
    LEFT JOIN tipo_material tm ON tm.id = c.material
WHERE
    c.geom IS NOT NULL
    AND st_intersects (c.geom, (
            SELECT
                st_collect (geom) AS geom FROM redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON :MVSCHEMA.se_conexoes USING gist (geom);

CREATE UNIQUE INDEX ON :MVSCHEMA.se_conexoes (id);

GRANT SELECT ON :MVSCHEMA.se_conexoes TO PUBLIC;


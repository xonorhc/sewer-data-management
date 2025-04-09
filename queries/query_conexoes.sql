DROP MATERIALIZED VIEW IF EXISTS cadastro_tecnico.ses_conexoes;

CREATE MATERIALIZED VIEW IF NOT EXISTS cadastro_tecnico.ses_conexoes AS
SELECT
    sc.id,
    sc.geom,
    tcx.tipo AS conexao,
    tm.tipo AS material,
    sc.diametro_entrada,
    sc.diametro_saida,
    sc.profundidade,
    sc.localizacao,
    sc.observacoes,
    sc.rotacao_simbolo
FROM
    fdw_ct.ses_conexoes AS sc
    LEFT JOIN fdw_ct.tipo_conexao AS tcx ON tcx.id = sc.tipo
    LEFT JOIN fdw_ct.tipo_material AS tm ON tm.id = sc.material
WHERE
    sc.geom IS NOT NULL
    AND st_intersects (sc.geom, (
            SELECT
                st_collect (geom) AS geom FROM fdw_ct.ses_redes_esgoto
            WHERE
                geom IS NOT NULL
                AND situacao = 1));

CREATE INDEX ON cadastro_tecnico.ses_conexoes USING gist (geom);

CREATE UNIQUE INDEX ON cadastro_tecnico.ses_conexoes (id);


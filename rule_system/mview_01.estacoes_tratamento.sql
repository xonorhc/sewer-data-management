SET search_path TO :PGSCHEMA, public;

CREATE MATERIALIZED VIEW IF NOT EXISTS :MVSCHEMA.se_estacoes_tratamento AS
SELECT
    et.id,
    et.geom,
    et.nome,
    ttn.tipo AS nivel_tratamento,
    tt.arr_tipo AS tecnologia,
    et.vazao,
    ts.tipo AS situacao,
    et.localizacao,
    et.observacoes
FROM
    estacoes_tratamento et
    LEFT JOIN tipo_tratamento_nivel ttn ON ttn.id = et.nivel_tratamento
    LEFT JOIN tipo_situacao ts ON ts.id = et.situacao
    LEFT JOIN ( SELECT et.id, array_agg(et.unnest) AS arr_id, array_agg(ttt.tipo) AS arr_tipo
        FROM ( SELECT id, unnest(tecnologia)
            FROM estacoes_tratamento) AS et
            LEFT JOIN tipo_tratamento_tecnologia AS ttt ON ttt.id = et.unnest
        GROUP BY et.id) tt ON tt.id = et.id
WHERE et.geom IS NOT NULL;

CREATE INDEX ON :MVSCHEMA.se_estacoes_tratamento USING gist (geom);

CREATE UNIQUE INDEX ON :MVSCHEMA.se_estacoes_tratamento (id);

GRANT SELECT ON :MVSCHEMA.se_estacoes_tratamento TO PUBLIC;


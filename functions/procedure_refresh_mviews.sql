-- NOTE: Procedimento para refresh de todas as materialized views.
CREATE OR REPLACE PROCEDURE cadastro_tecnico.refresh_mviews ()
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    mviews RECORD;
BEGIN
    RAISE NOTICE 'Refreshing all materialized views...';
    FOR mviews IN
    SELECT
        n.nspname AS mv_schema,
        c.relname AS mv_name,
        pg_catalog.pg_get_userbyid(c.relowner) AS owner
    FROM
        pg_catalog.pg_class c
    LEFT JOIN pg_catalog.pg_namespace n ON (n.oid = c.relnamespace)
WHERE
    c.relkind = 'm'
        AND n.nspname LIKE 'cadastro_tecnico'
    ORDER BY
        1,
        2 LOOP
            -- Now "mviews" has one record with information about the materialized view
            RAISE NOTICE 'Refreshing materialized view %.% (owner: %)...', quote_ident(mviews.mv_schema), quote_ident(mviews.mv_name), quote_ident(mviews.owner);
            EXECUTE format('REFRESH MATERIALIZED VIEW %I.%I', mviews.mv_schema, mviews.mv_name);
        END LOOP;
    RAISE NOTICE 'Done refreshing materialized views.';
END;
$$;

-- NOTE: Configuracao de privilegio para execucao do procedimento pelo grupo de edicao do Cadastro Tecnico.
GRANT EXECUTE ON PROCEDURE cadastro_tecnico.refresh_mviews () TO grupo_geotecnologia;

CALL cadastro_tecnico.refresh_mviews ();

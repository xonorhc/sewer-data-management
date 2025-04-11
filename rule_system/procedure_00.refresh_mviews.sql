CREATE OR REPLACE PROCEDURE :MVSCHEMA.refresh_mviews ()
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
        AND n.nspname LIKE :'MVSCHEMA' -- FIX: Double cote is literal and don't return variable value from terminal
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

-- GRANT EXECUTE ON PROCEDURE :MVSCHEMA.refresh_mviews () TO group_dba;
-- CALL :MVSCHEMA.refresh_mviews ();

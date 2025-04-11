CREATE OR REPLACE FUNCTION :PGSCHEMA.atualizado_por ()
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE NOT LEAKPROOF
    AS $body$
BEGIN
    NEW.data_atualizacao := CURRENT_TIMESTAMP;
    NEW.usuario_atualizacao := CURRENT_USER;
    RETURN new;
END;
$body$;

-- PEFORM:
CREATE FUNCTION pg_temp.foo (_v1 text)
    RETURNS void
    AS $func$
DECLARE
    mytables record;
BEGIN
    FOR mytables IN
    SELECT
        table_schema,
        table_name
    FROM
        information_schema.tables
    WHERE
        table_schema = _v1
        AND table_name NOT LIKE ('tipo_%')
            LOOP
                EXECUTE format(' ALTER TABLE %2$I.%1$I ADD COLUMN data_atualizacao timestamp, ADD COLUMN usuario_atualizacao varchar(20) ', mytables.table_name, mytables.table_schema);
                EXECUTE format(' CREATE OR REPLACE TRIGGER trig_atualizado_por BEFORE UPDATE ON %2$I.%1$I FOR EACH ROW EXECUTE FUNCTION %2$I.atualizado_por (); ', mytables.table_name, mytables.table_schema);
            END LOOP;
END
$func$
LANGUAGE plpgsql;

SELECT
    pg_temp.foo (:'PGSCHEMA');

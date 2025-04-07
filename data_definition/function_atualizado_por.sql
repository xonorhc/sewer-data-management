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


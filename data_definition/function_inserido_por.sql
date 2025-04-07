CREATE OR REPLACE FUNCTION :PGSCHEMA.inserido_por ()
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
    COST 100 VOLATILE NOT LEAKPROOF
    AS $body$
BEGIN
    NEW.data_criacao := CURRENT_TIMESTAMP;
    NEW.usuario_criacao := CURRENT_USER;
    RETURN new;
END;
$body$;


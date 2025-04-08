#!/bin/bash

PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGDATABASE=modelo_dados_saneamento
PGSCHEMA=sistema_esgoto

# create database
psql -U $PGUSER -h $PGHOST -p $PGPORT -d 'postgres' \
  -c "create database $PGDATABASE;"

# create extension
psql -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE \
  -c "create extension if not exists postgis;"

# create schema
psql -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE \
  -c "create schema if not exists $PGSCHEMA;"

# find $(dirname $0)/data_definition -name "*.sql" -exec echo {} \;

# create types/tables
find $(dirname $0)/data_definition -type f -name "type*" -exec \
  psql -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE -b --variable=PGSCHEMA=$PGSCHEMA \
  -f {} \;

# create tables
find $(dirname $0)/data_definition -type f -name "table*" -print0 | sort -z | xargs -0 -I{} \
  psql -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE -b --variable=PGSCHEMA=$PGSCHEMA \
  -f "{}"

# create functions
find $(dirname $0)/data_definition -type f -name "function*" -exec \
  psql -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE -b --variable=PGSCHEMA=$PGSCHEMA \
  -f {} \;

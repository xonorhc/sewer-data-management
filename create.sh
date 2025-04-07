#!/bin/bash

# create database
psql -U postgres -h localhost -p 5432 -d postgres -c "create database modelo_dados_saneamento;"

# create extension
psql -U postgres -h localhost -p 5432 -d modelo_dados_saneamento -c "create extension if not exists postgis;"

# create schema
psql -U postgres -h localhost -p 5432 -d modelo_dados_saneamento -c "create schema if not exists sistema_esgoto;"

# find $(dirname $0)/data_definition -name "*.sql" -exec echo {} \;

# create functions
find $(dirname $0)/data_definition -name "function_*" \
    -exec psql -h localhost -p 5432 -d modelo_dados_saneamento -U postgres -f {} \;

# create types/tables
find $(dirname $0)/data_definition -name "type_*" \
    -exec psql -h localhost -p 5432 -d modelo_dados_saneamento -U postgres -f {} \;

# create tables
find $(dirname $0)/data_definition -name "table_*" -print0 | sort -z | xargs -0 -I{} \
    psql -h 'localhos' -p '5432' -d 'modelo_dados_saneamento' -U 'postgres' -f "{}" 

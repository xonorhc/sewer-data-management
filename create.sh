#!/bin/bash

# create database
psql -U golin -h 10.17.1.2 -p 5432 -d postgres -c "create database if not exists topazio;"

# create schema
psql -U golin -h 10.17.1.2 -p 5432 -d topazio -c "create schema if not exists sistema_esgoto;"

# find $(dirname $0)/data_definition -name "function_*" -exec echo {} \;
#
find $(dirname $0)/data_definition -name "function_*" \
    -exec psql -h '10.17.1.2' -p 5432 -d 'topazio' -U golin -f {} \;

find $(dirname $0)/data_definition -name "type_*" \
    -exec psql -h '10.17.1.2' -p 5432 -d 'topazio' -U golin -f {} \;

find $(dirname $0)/data_definition -name "table_*" \
    -exec psql -h '10.17.1.2' -p 5432 -d 'topazio' -U golin -f {} \;

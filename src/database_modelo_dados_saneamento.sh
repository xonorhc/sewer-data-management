psql -h localhost -p 5432 -d postgres -U postgres \
  -c ' CREATE DATABASE IF NOT EXISTS modelo_dados_saneamento; '

psql -h localhost -p 5432 -d modelo_dados_saneamento -U postgres \
  -c ' CREATE EXTENSION IF NOT EXISTS postgis; '

psql -h localhost -p 5432 -d modelo_dados_saneamento -U postgres \
  -c ' CREATE SCHEMA IF NOT EXISTS sistema_esgoto; '

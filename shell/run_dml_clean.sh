#!/bin/bash

# Charger les variables du fichier .env
export $(grep -v '^#' .env | xargs)

# Fonction pour exécuter un fichier SQL
run_sql() {
  local sql_file=$1
  PGPASSWORD=$DB_PASS psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f "$sql_file"
}

#Execution des scripts 

run_sql ingestion/raw/dml_users.sql
run_sql ingestion/raw/dml_raw_games.sql
run_sql ingestion/raw/dml_events.sql

run_sql ingestion/cleaned/dml_users.sql
run_sql ingestion/cleaned/dml_raw_games.sql
run_sql ingestion/cleaned/dml_events.sql
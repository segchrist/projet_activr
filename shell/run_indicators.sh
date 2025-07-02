#!/bin/bash

# Charger les variables du fichier .env
export $(grep -v '^#' .env | xargs)

# Fonction pour exécuter un fichier SQL
run_sql() {
  local sql_file=$1
  echo "Exécution de $sql_file"
  PGPASSWORD=$DB_PASS psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f "$sql_file"
}

# Exécuter tous les fichiers .sql dans calcul/raw/ dans l'ordre alphabétique
for sqlfile in ../scripts/calcul/raw/*.sql
do
  run_sql "$sqlfile"
done

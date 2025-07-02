#!/bin/bash

# Charger les variables du fichier .env
export $(grep -v '^#' .env | xargs)

# Fonction pour exécuter un script SQL
run_sql() {
  local sql_file=$1
  echo "Exécution de $sql_file ..."
  PGPASSWORD=$DB_PASS psql -h $DB_HOST -U $DB_USER -d $DB_NAME -v ON_ERROR_STOP=1 -f "$sql_file"
  if [ $? -ne 0 ]; then
    echo "Erreur lors de l'exécution de $sql_file"
    exit 1
  fi
}

# Exécution des scripts dans l'ordre logique

# 1. Création des tables RAW
run_sql run_ddl_raw.sql

# 2. Chargement des données RAW
run_sql run_dml_raw.sql

# 3. Création des tables CLEAN
run_sql run_ddl_clean.sql

# 4. Chargement des données CLEAN (transformations & nettoyage)
run_sql run_dml_clean.sql

# 5. Calcul des indicateurs
run_sql run_indicators.sql

echo "Pipeline exécuté avec succès."

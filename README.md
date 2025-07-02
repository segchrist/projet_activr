Projet ActiVR - Gestion et Analyse des Données Utilisateurs
Contexte
ActiVR souhaite exploiter les données de ses utilisateurs et événements pour des campagnes marketing ciblées et analyser la performance de ses jeux et activités.

Les données brutes collectées peuvent contenir des erreurs, des valeurs manquantes ou incohérences. Ce projet vise à :

Ingestion des données brutes (raw) dans des tables dédiées,

Nettoyage des données pour obtenir des tables propres (clean),

Calcul d’indicateurs clés grâce à des requêtes SQL avancées (CTE, fonctions fenêtres...),

Organisation modulaire avec scripts SQL pour chaque étape.

Arborescence du projet
bash
Copier
Modifier
.
├── README.md
├── .env                       # Configuration de la base de données
├── run_ddl_raw.sh             # Script pour créer les tables raw
├── run_ddl_clean.sh           # Script pour créer les tables clean
├── run_dml_raw.sh             # Script pour charger les données dans raw
├── run_dml_clean.sh           # Script pour créer et charger clean à partir de raw
├── run_calcul.sh              # Script pour calculer et stocker les indicateurs
├── ingestion
│   ├── raw
│   │   ├── ddl_users.sql
│   │   ├── ddl_games.sql
│   │   ├── ddl_events.sql
│   │   ├── dml_users.sql      # Insert depuis CSV raw_users.csv
│   │   ├── dml_games.sql
│   │   ├── dml_events.sql
│   │   └── raw_users.csv      # Données brutes utilisateurs
│   │   └── raw_games.csv
│   │   └── raw_events.csv
│   └── clean
│       ├── ddl_users.sql      # Création table clean.users (nettoyée)
│       ├── ddl_games.sql
│       ├── ddl_events.sql
│       └── dml_users.sql      # Insert clean à partir de raw + nettoyage
│       └── dml_games.sql
│       └── dml_events.sql
├── calcul
│   ├── ddl_indicators.sql     # Création tables d’indicateurs
│   ├── indicator_exposure.sql # Exposition utilisateurs par jour/semaine
│   ├── indicator_activity.sql # Activité utilisateurs par type jeu
│   └── indicator_performance.sql # Performance selon engagement et dates
Configuration de la base de données
Les paramètres de connexion à la base Postgres sont définis dans le fichier .env :

env
Copier
Modifier
DB_HOST=localhost
DB_NAME=activr_db
DB_USER=postgres
DB_PASS=secret_password
DB_PORT=5432
Étapes d’exécution
1. Création des tables raw (brutes)
bash
Copier
Modifier
./run_ddl_raw.sh
Crée les tables brutes (raw.users, raw.games, raw.events).

2. Chargement des données dans raw
bash
Copier
Modifier
./run_dml_raw.sh
Charge les données depuis les fichiers CSV dans les tables raw.

3. Création des tables clean (nettoyées)
bash
Copier
Modifier
./run_ddl_clean.sh
Crée les tables nettoyées (clean.users, etc.) avec les types et contraintes corrigés.

4. Nettoyage des données et insertion dans clean
bash
Copier
Modifier
./run_dml_clean.sh
Transforme les données depuis raw, remplace valeurs manquantes, nettoie les erreurs, et insère dans clean.

5. Calcul des indicateurs
bash
Copier
Modifier
./run_calcul.sh
Exécute les scripts SQL pour générer les tables d’indicateurs, par exemple :

Nombre d’utilisateurs actifs par jour, semaine, type de jeu

Répartition des âges, fréquences d’activité

Moyennes mobiles sur les participations

Indicateurs avec fonctions fenêtres et CTE

Nettoyage des données : règles principales
age : doit être un entier positif. Les valeurs manquantes ou non numériques sont remplacées par la moyenne des âges valides.

registration_date : doit être un date valide. Valeurs manquantes remplacées par 2024-01-01.

email : valeurs manquantes remplacées par 'Unknown'.

workout_frequency : valeurs manquantes remplacées par 'flexible'. Valeurs forcées en minuscules, uniquement parmi minimal, flexible, regular, maximal.

Technologies utilisées
PostgreSQL (SQL standard, fonctions fenêtres, CTE)

Bash (scripts d’exécution)

CSV (format d’import des données brutes)
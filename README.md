## Projet Data Pipeline & KPI
Description du projet
Ce projet consiste à construire un pipeline de données complet pour ingérer, nettoyer, enrichir et analyser les données issues d’une plateforme de jeux en ligne. L’objectif est de permettre un suivi précis des comportements utilisateurs et des performances des jeux à travers des indicateurs clés (KPIs), afin d’orienter les décisions business et améliorer l’expérience client.

Les données initiales sont collectées sous forme de fichiers CSV bruts (utilisateurs, événements, jeux). Ces données sont ensuite chargées dans une base PostgreSQL dans des tables raw. Un processus de nettoyage et d’enrichissement génère des tables clean où les données sont corrigées, complétées et normalisées. Enfin, un ensemble de tables KPI agrège ces informations selon différentes granularités (temps, utilisateur, jeu, localisation).

L’ensemble des étapes est automatisé et orchestré via Apache Airflow, assurant une mise à jour régulière et fiable.

## KPIs à suivre
Les principaux indicateurs calculés sont :

- Statuts utilisateurs :

Nombre d’utilisateurs actifs (événement dans les 6 derniers mois)

Nombre d’utilisateurs churnés (étaient actifs mais ne le sont plus)

Nombre d’utilisateurs inactifs (jamais été actifs)

- Engagement utilisateur :

Fréquence moyenne d’événements par utilisateur

Durée moyenne d’utilisation par session

Répartition des utilisateurs par tranche d’âge, genre, abonnement

- Performance des jeux :

Nombre total d’événements par jeu

Durée moyenne des sessions par jeu

Popularité des jeux par nombre d’utilisateurs actifs

- Dimension temporelle :

Agrégation mensuelle des KPIs pour suivre l’évolution dans le temps

Identification des tendances saisonnières ou ponctuelles

Dimension géographique (localisation) :

Répartition des utilisateurs actifs par localisation

Analyse des comportements utilisateurs selon la zone géographique

## Mailles d’analyse

Les KPIs sont calculés selon plusieurs granularités :

Par utilisateur : suivi individuel des comportements et statuts

Par mois : analyse temporelle pour détecter les évolutions

Par jeu : mesure de la performance et popularité des jeux

Par localisation : compréhension géographique des usages



## Outils utilisés

Python : génération des données brutes synthétiques

PostgreSQL : stockage et traitement des données

Apache Airflow : orchestration des pipelines ETL

SQL : création, nettoyage, transformation et calcul des KPIs

Bash : automatisation des imports et gestion des environnements

## Fonctionnement résumé
Génération des données brutes synthétiques

Ingestion dans les tables raw

Nettoyage et enrichissement vers les tables clean

Calcul et mise à jour des tables KPI selon les différentes mailles

Orchestration complète via Airflow pour automatisation et reprise sur erreur


## Table users.csv

user_id (entier, clé primaire) : identifiant unique utilisateur (exemple : 1, 2, 3...)

age_range (texte) : tranche d’âge, valeurs possibles : -18, 18-25, 26-35, 36-50, 50+ ou vide

registration_date (texte) : date d’inscription au format ISO (ex : 2023-05-12)

email (texte) : adresse email générée aléatoirement

workout_frequency (texte) : fréquence d’entraînement, valeurs : flexible, minimal, regular, maximal (avec variations de casse possibles)

gender (texte) : genre, valeurs : M, F, Other, ou vide

location (texte) : ville de résidence, valeurs : Paris, Lyon, Berlin, Madrid, Rome, ou vide

subscription_type (texte) : type d’abonnement, valeurs : free, premium, trial (avec variations de casse possibles)

## Table games.csv

game_id (entier, clé primaire) : identifiant unique du jeu (exemple : 100, 101, 102...)

game_type (texte) : type de jeu, valeurs : cardio, strategy, puzzle, arcade, action, avec erreurs possibles (ex : Actionn, vide, PuzZle)

game_name (texte) : nom du jeu, généré aléatoirement (exemple : Dragon Quest)

platform (texte) : plateforme, valeurs : iOS, Android, Web, avec erreurs possibles (ex : androiid, WEB, vide)

difficulty (texte) : difficulté, valeurs : easy, medium, hard, avec erreurs possibles (ex : Medium, HARD, vide)

## Table events.csv

event_id (entier, clé primaire) : identifiant unique de l’événement (exemple : 1, 2, 3...)

game_id (entier, clé étrangère) : référence au jeu, valeurs valides ou erreurs (9999)

user_id (entier, clé étrangère) : référence à l’utilisateur, valeurs valides ou erreurs (9999)

event_time (texte) : date et heure au format ISO (exemple : 2024-06-15T14:23:01)

event_type (texte) : type d’événement, valeurs : login, start_game, finish_game, purchase, avec erreurs possibles (Start_Game, vide)

duration_seconds (texte) : durée en secondes, valeurs : 30, 60, 90, vide ou négatif (-10)

device_type (texte) : type de dispositif, valeurs : mobile, web, console, avec erreurs possibles (tablet, MOBILE)

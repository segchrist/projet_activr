# 🌤️ Pipeline Météo – Projet ETL

Ce projet met en place un pipeline automatisé qui récupère quotidiennement des données météorologiques pour plusieurs villes françaises, les nettoie, puis les stocke dans une base **PostgreSQL**. Le pipeline est orchestré via **Apache Airflow**.

###  Objectifs
Fournir des données météo fiables pour :
- Anticiper les retards logistiques liés aux conditions climatiques
- Alimenter les analyses des data scientists/analystes métier


## Technologies utilisées

- **Python** : développement et orchestration
- **Pandas** : nettoyage et transformation des données
- **PostgreSQL** : stockage des données transformées
- **Airflow** : planification et orchestration ETL
- **API Open-Meteo** : source de données météo
- **SQL** : gestion des tables et insertion


## Lancer le projet

1. Cloner le dépôt :  
   `git clone <url_du_repo>`

2. Créer un environnement virtuel :  
   `python -m venv venv && source venv/Scripts/activate` (Windows)  
   ou `source venv/bin/activate` (Linux/Mac)

3. Installer les dépendances :  
   `pip install -r requirements.txt`

4. Configurer votre base PostgreSQL et exécuter le script dans `db/` pour créer la table.

5. Lancer Airflow (scheduler & webserver) et exécuter le DAG.


## Commandes utiles

```bash
# Activer l'environnement virtuel
source venv/Scripts/activate  # Windows
source venv/bin/activate      # Unix

# Installer les dépendances
pip install -r requirements.txt
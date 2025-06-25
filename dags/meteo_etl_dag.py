# === IMPORTS AIRFLOW & UTILS ===
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
import sys
import os

# AJOUT DU CHEMIN VERS TES SCRIPTS
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../scripts')))

# IMPORT DE TES FONCTIONS EXTRACT / TRANSFORM / LOAD ===
from scripts.extract import extract_meteo_data, get_coordonnate_cities
from scripts.transform import transform_meteo_data
from scripts.load import load_meteo_data

# PARAMÈTRES DU DAG
default_args = {
    'owner': 'glor1anesegoun',
    'depends_on_past': False,
    'start_date': datetime(2025, 6, 25),
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

# DÉFINITION DU DAG
with DAG(
    'meteo_etl_pipeline',
    default_args=default_args,
    description='Pipeline ETL météo',
    schedule_interval='@daily',
    catchup=False,
    tags=['meteo', 'etl']
) as dag:
    
    #TÂCHE GET COORDONNEES
    task_get_coord = PythonOperator(
        task_id = "get_coordonnes_cities",
        python_callable = get_coordonnate_cities
    )

    # TÂCHE EXTRACT
    task_extract = PythonOperator(
        task_id='extract_data',
        python_callable=extract_meteo_data
    )

    # TÂCHE TRANSFORM
    task_transform = PythonOperator(
        task_id='transform_data',
        python_callable=transform_meteo_data
    )

    # TÂCHE LOAD
    task_load = PythonOperator(
        task_id='load_data',
        python_callable=load_meteo_data
    )

    # ORDRE DES TÂCHES
    task_get_coord >>task_extract >> task_transform >> task_load

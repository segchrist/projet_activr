from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
}

with DAG(
    dag_id='kpi_all_dag',
    description='Mise à jour de toutes les tables KPI (user, mois, jeu, localisation)',
    schedule_interval='@daily',
    start_date=days_ago(1),
    catchup=False,
    default_args=default_args,
    tags=['kpi'],
) as dag:

    update_kpi_user = PostgresOperator(
        task_id='update_kpi_user',
        postgres_conn_id='postgres_default',
        sql='sql/kpi/kpi_user.sql',
    )

    update_kpi_user_month = PostgresOperator(
        task_id='update_kpi_user_month',
        postgres_conn_id='postgres_default',
        sql='sql/kpi/kpi_user_month.sql',
    )

    update_kpi_user_game = PostgresOperator(
        task_id='update_kpi_user_game',
        postgres_conn_id='postgres_default',
        sql='sql/kpi/kpi_user_game.sql',
    )

    update_kpi_user_location = PostgresOperator(
        task_id='update_kpi_user_location',
        postgres_conn_id='postgres_default',
        sql='sql/kpi/kpi_user_location.sql',
    )

    # Définir l’ordre d’exécution
    update_kpi_user >> [update_kpi_user_month, update_kpi_user_game, update_kpi_user_location]

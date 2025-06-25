
from datetime import datetime, timedelta

API_BASE_URL = "https://api.open-meteo.com/v1/forecast"
# Liste des villes ciblées
CITIES = ["Paris", "Lyon", "Marseille", "Lille", "Bordeaux"]

DATE_FIN = datetime.now().strftime("%Y-%m-%d")
DATE_DEBUT = (datetime.now() - timedelta(days=1)).strftime("%Y-%m-%d")


# Chemins des fichiers
PATH_CITIES_CSV = "data/cities.csv"
PATH_RAW_DATA_DIR = "data/raw/data.csv"
PATH_CLEANED_DATA = "data/cleaned/data.csv"


#DB CONFIG
HOSTNAME = ""
PORT = 5432
USER = ""
PASSWD = ""
DB_NAME = ""
METEO_TB_NAME = ""
POSTGRES_CONN_STR = f"postgresql+psycopg2://{USER}:{PASSWD}@{HOSTNAME}:{PORT}/{DB_NAME}"


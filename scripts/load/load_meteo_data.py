import pandas as pd
from sqlalchemy import create_engine
from scripts.config import *




def load_data():
    """
    Charge les données dans la table PostgreSQL via SQLAlchemy et pandas.to_sql
    
    Args:
    """
    df = pd.read_csv(PATH_CLEANED_DATA)
    # créer l’engine SQLAlchemy avec les infos de config
    engine = create_engine(POSTGRES_CONN_STR)

    # charger les données dans la table (mode append)
    df.to_sql(METEO_TB_NAME, engine, if_exists='append', index=False)
    
    print(f"{len(df)} lignes insérées dans la table {METEO_TB_NAME}.")
    return
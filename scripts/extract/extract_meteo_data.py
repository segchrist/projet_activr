import pandas as pd
from  scripts import config 
from  datetime import datetime, timedelta
import json
import requests


all_data = []
start_date = config.DATE_DEBUT
end_date = config.DATE_FIN
output_path = config.PATH_RAW_DATA_DIR

def extract_data():
    """
    Extrait les données météo pour chaque ville du fichier CSV
    et les enregistre dans un fichier CSV combiné.

    Les données proviennent de l'API Open-Meteo et couvrent
    la période entre start_date et end_date.

    Returns:
        result (DataFrame): Données météo combinées.
    """
    all_data = []
    df_cities = pd.read_csv(config.PATH_CITIES_CSV)
    url = "https://api.open-meteo.com/v1/forecast"
    
    for _, row in df_cities.iterrows():
        params = {
            "latitude": row["lat"],
            "longitude": row["lon"],
            "start_date": start_date,
            "end_date": end_date,
            "daily": "temperature_2m_max,temperature_2m_min,precipitation_sum",
            "timezone": "Europe/Paris"
        }

        response = requests.get(url, params=params)
        if response.status_code == 200:
            data = response.json()
            daily_data = data.get("daily", {})
            df_city = pd.DataFrame(daily_data)
            df_city["city"] = row["city"]
            all_data.append(df_city)
        else:
            print(f"Erreur API pour la ville {row['city']}: {response.status_code}")

    if all_data:
        result = pd.concat(all_data, ignore_index=True)
        result.to_csv(output_path, index=False)
        return result
    else:
        print("Aucune donnée collectée.")
        return None
    

if __name__== "__main__":
    print(extract_data())
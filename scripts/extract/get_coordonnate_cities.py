import requests
import os
import pandas as pd
from scripts import config


def get_coordonates(city):
    data={}
    url = "https://nominatim.openstreetmap.org/search"
    params = {"q":city, "format":"json", "limit":1}
    headers = {"User-Agent": "projet_etl_meteo"}
    response = requests.get(url, params=params, headers=headers)
    if response.status_code==200:
        data = response.json()
        if data:
            return data[0]["lon"], data[0]["lat"]
        else:
            raise ValueError(f"Aucune valeur trouvée pour la ville: {city}")
    else:
        raise ValueError(f"Donnees non recuperees, status code:{response.status_code}")
     

def load_update_cities():
    """
    Charge un fichier CSV contenant des villes avec leurs coordonnées (latitude, longitude).
    Si le fichier n'existe pas, crée un DataFrame vide avec les colonnes adéquates.
    Pour chaque ville dans la liste fournie, récupère ses coordonnées via une API (fonction get_coordonates)
    uniquement si la ville n'est pas déjà présente dans le fichier.
    Met à jour le fichier CSV uniquement si des nouvelles villes ont été ajoutées.

    Args:
        **kwargs: Dictionnaire avec :
            - file_path (str): chemin vers le fichier CSV des villes.
            - cities (list): liste des noms de villes à vérifier/ajouter.

    Returns:
        pd.DataFrame: DataFrame contenant toutes les villes et leurs coordonnées (mise à jour).
    """

    file_path = config.PATH_CITIES_CSV
    cities = config.CITIES

    if os.path.exists(file_path):
        df_cities = pd.read_csv(file_path)
    else:
        df_cities = pd.DataFrame(columns=["city", "lat", "lon"])

    l_temp = list(df_cities["city"])
    update = False

    for c in cities:
        if c in l_temp:
            continue
        else:
            lat, lon = get_coordonates(c)
            df_cities.loc[len(df_cities)] = [c, lat, lon]
            update = True

    if update:
        df_cities.to_csv(file_path, index=False)

    return df_cities



if __name__=="__main__":
    print(load_update_cities())
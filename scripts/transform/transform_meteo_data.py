import pandas as pd
import config as cg


def transform(file):
    data = pd.read_csv(cg.PATH_RAW_DATA_DIR)
    data.rename({
        "time": "date",
        "temperature_2m_max": "temp_max",
        "temperature_2m_min": "temp_min",
        "precipitation_sum": "precipitation"
    })
    data["date"]=pd.to_datetime(data["date"])
    data.to_csv(cg.PATH_CLEANED_DATA)
    return data

-- Vider la table clean.events avant insertion
TRUNCATE TABLE clean.events;

-- Insérer les données nettoyées et enrichies dans clean.events
INSERT INTO clean.events (
  event_id,
  game_id,
  user_id,
  event_time,
  event_type,
  duration_seconds,
  device_type,
  event_date,     -- Date sans l'heure (extraction de la partie date)
  event_hour,     -- Heure de l'événement (0 à 23)
  event_weekday,  -- Jour de la semaine (1 = lundi, 7 = dimanche)
  duration_minutes -- Durée de l'événement en minutes (arrondie)
)
SELECT
  event_id,
  game_id,
  user_id,
  
  -- Si event_time est NULL, on met une date/heure par défaut
  COALESCE(event_time, TIMESTAMP '2024-01-01 00:00:00') AS event_time,
  
  -- Nettoyage et uniformisation du type d'événement,
  -- valeurs vides remplacées par 'unknown'
  COALESCE(NULLIF(LOWER(TRIM(event_type)), ''), 'unknown') AS event_type,
  
  -- Durée en secondes, 0 si valeur manquante
  COALESCE(duration_seconds, 0) AS duration_seconds,
  
  -- Nettoyage du type d'appareil, valeurs vides remplacées par 'unknown'
  COALESCE(NULLIF(LOWER(TRIM(device_type)), ''), 'unknown') AS device_type,
  
  -- Extraction de la date (sans heure)
  CAST(event_time AS DATE) AS event_date,
  
  -- Extraction de l'heure (0 à 23)
  EXTRACT(HOUR FROM event_time) AS event_hour,
  
  -- Jour de la semaine : on remplace dimanche (0) par 7 pour avoir lundi=1
  CASE 
    WHEN EXTRACT(DOW FROM event_time) = 0 THEN 7
    ELSE EXTRACT(DOW FROM event_time)
  END AS event_weekday,
  
  -- Durée en minutes arrondie
  ROUND(COALESCE(duration_seconds, 0) / 60.0) AS duration_minutes

FROM raw.events
WHERE event_id IS NOT NULL;

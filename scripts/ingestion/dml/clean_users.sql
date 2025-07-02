-- Supprime les données existantes dans la table clean
TRUNCATE TABLE clean.users;

-- Insère les données nettoyées depuis raw.users
INSERT INTO clean.users (
  user_id,
  age_range,
  registration_date,
  email,
  workout_frequency,
  gender,
  location,
  subscription_type,
  registration_year,
  registration_month,
  registration_week
)
SELECT
  user_id,

  -- Nettoyage de l'âge : remplace NULL, vide ou 'unknown' par 'unknown'
  CASE
    WHEN age IS NULL OR LOWER(TRIM(age)) = '' OR LOWER(TRIM(age)) = 'unknown' THEN 'unknown'
    ELSE TRIM(age)
  END AS age_range,

  -- Conversion de la date d'inscription, valeur par défaut : 2024-01-01
  COALESCE(
    TO_DATE(registration_date, 'YYYY-MM-DD'),
    DATE '2024-01-01'
  ) AS registration_date,

  -- Nettoyage de l'email : trim, minuscule, valeur par défaut 'unknown'
  COALESCE(NULLIF(LOWER(TRIM(email)), ''), 'unknown') AS email,

  -- Nettoyage de workout_frequency : trim, minuscule, valeur par défaut 'flexible'
  CASE
    WHEN workout_frequency IS NULL OR LOWER(TRIM(workout_frequency)) = '' OR LOWER(TRIM(workout_frequency)) = 'unknown' THEN 'flexible'
    ELSE LOWER(TRIM(workout_frequency))
  END AS workout_frequency,

  -- Nettoyage du genre : trim, minuscule, valeur par défaut 'unknown'
  CASE
    WHEN gender IS NULL OR LOWER(TRIM(gender)) = '' OR LOWER(TRIM(gender)) = 'unknown' THEN 'unknown'
    ELSE LOWER(TRIM(gender))
  END AS gender,

  -- Nettoyage de la localisation : trim, valeur par défaut 'unknown'
  CASE
    WHEN location IS NULL OR TRIM(location) = '' THEN 'unknown'
    ELSE TRIM(location)
  END AS location,

  -- Nettoyage du type d'abonnement : trim, minuscule, valeur par défaut 'free'
  CASE
    WHEN subscription_type IS NULL OR LOWER(TRIM(subscription_type)) = '' OR LOWER(TRIM(subscription_type)) = 'unknown' THEN 'free'
    ELSE LOWER(TRIM(subscription_type))
  END AS subscription_type,

  -- Extraction de l'année d'inscription
  EXTRACT(YEAR FROM COALESCE(TO_DATE(registration_date, 'YYYY-MM-DD'), DATE '2024-01-01'))::INT AS registration_year,

  -- Extraction du mois d'inscription
  EXTRACT(MONTH FROM COALESCE(TO_DATE(registration_date, 'YYYY-MM-DD'), DATE '2024-01-01'))::INT AS registration_month,

  -- Extraction du numéro de semaine d'inscription
  EXTRACT(WEEK FROM COALESCE(TO_DATE(registration_date, 'YYYY-MM-DD'), DATE '2024-01-01'))::INT AS registration_week

FROM raw.users
-- Ne garde que les utilisateurs avec un ID valide
WHERE user_id IS NOT NULL;
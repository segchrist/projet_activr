DROP TABLE IF EXISTS clean.users;

-- Supprimer la table clean.users si elle existe déjà
DROP TABLE IF EXISTS clean.users;

-- Calcul de la moyenne des âges valides à partir de raw.users
WITH avg_age_cte AS (
  SELECT AVG(CAST(TRIM(age) AS INTEGER)) AS avg_age
  FROM raw.users
  WHERE TRIM(age) ~ '^\d+$'
)

-- Créer la table clean.users à partir de raw.users
CREATE TABLE clean.users AS
SELECT
    user_id,
    -- si age est bien un entier (après avoir retiré les espaces), on le garde, sinon on met la moyenne
    COALESCE(
        CASE
            WHEN TRIM(age) ~ '^\d+$' THEN CAST(TRIM(age) AS INTEGER)
            ELSE NULL
        END,
        ROUND(avg_age_cte.avg_age)
    ) AS age,
    
    -- Remplacer les valeurs manquantes ou mal formattées par '2024-01-01'
    COALESCE(
        TO_DATE(registration_date, 'YYYY-MM-DD'),
        DATE '2024-01-01'
    ) AS registration_date,
    
    -- Remplacer les valeurs manquantes par 'flexible' et forcer en minuscules sans espaces autour
    COALESCE(
        LOWER(TRIM(workout_frequency)),
        'flexible'
    ) AS workout_frequency

FROM raw.users, avg_age_cte
;

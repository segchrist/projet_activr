/*
-- Création de la table des indicateurs multi-dimension (utilisateur / mois / jeu / location)
-- Règles de gestion :
   - Un utilisateur est actif s’il a un événement dans les 6 derniers mois
   - Churned : actif dans le passé, inactif depuis 6 mois
   - Inactif : jamais eu d’événement
   - Données agrégées par mois (à partir de event_time)
*/

DROP TABLE IF EXISTS analytics.kpi_user_month_game_location;

CREATE TABLE analytics.kpi_user_month_game_location AS
SELECT
    u.user_id,
    COALESCE(u.age_range, 'unknown') AS age_range,
    COALESCE(u.gender, 'unknown') AS gender,
    COALESCE(u.subscription_type, 'flexible') AS subscription_type,
    COALESCE(u.location, 'unknown') AS location,
    DATE_TRUNC('month', e.event_time) AS month,
    g.game_id,
    COALESCE(g.game_type, 'unknown') AS game_type,
    COALESCE(g.game_name, 'unknown') AS game_name,

    COUNT(e.event_id) AS nb_events,
    AVG(e.duration_seconds) AS avg_duration,
    MAX(e.event_time) AS last_event_date,

    CASE
        WHEN MAX(e.event_time) IS NULL THEN 'inactif'
        WHEN MAX(e.event_time) >= CURRENT_DATE - INTERVAL '6 months' THEN 'actif'
        ELSE 'churned'
    END AS user_status

FROM raw.users u
LEFT JOIN raw.events e ON u.user_id = e.user_id
LEFT JOIN raw.games g ON e.game_id = g.game_id

GROUP BY
    u.user_id, u.age_range, u.gender, u.subscription_type, u.location,
    month, g.game_id, g.game_type, g.game_name;

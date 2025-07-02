/*
-- KPI Utilisateur --
Règles de gestion :
- Un utilisateur est actif si sa dernière date d'événement est dans les 6 derniers mois.
- Un utilisateur est churned s'il était actif avant mais ne l'est plus.
- Un utilisateur est inactif s'il n'a jamais eu d'événement.
Indicateurs calculés par utilisateur :
- statut (actif, churned, inactif)
- nombre total d'événements
- date de première activité
- date de dernière activité
- âge (age_range)
- genre (gender)
- type d'abonnement (subscription_type)
*/
DROP TABLE IF EXISTS analytics.kpis_user;
CREATE TABLE analytics.kpis_user AS
SELECT
    u.user_id,
    COALESCE(u.age_range, 'unknown') AS age_range,
    COALESCE(u.gender, 'unknown') AS gender,
    COALESCE(u.subscription_type, 'flexible') AS subscription_type,
    MIN(e.event_time) AS first_event_date,
    MAX(e.event_time) AS last_event_date,
    COUNT(e.event_id) AS total_events,
    CASE
        WHEN MAX(e.event_time) IS NULL THEN 'inactif'
        WHEN MAX(e.event_time) >= CURRENT_DATE - INTERVAL '6 months' THEN 'actif'
        ELSE 'churned'
    END AS user_status
FROM raw.users u
LEFT JOIN raw.events e ON u.user_id = e.user_id
GROUP BY u.user_id, u.age_range, u.gender, u.subscription_type;

/*
-- KPI par localisation --
Règles :
- On agrège les indicateurs par location utilisateur.
- Location est supposée dans la table users.
Indicateurs :
- nombre total d'utilisateurs
- nombre d'utilisateurs actifs (événements dans les 6 derniers mois)
- nombre total d'événements
*/

SELECT
    COALESCE(u.location, 'unknown') AS location,
    COUNT(DISTINCT u.user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN e.event_time >= CURRENT_DATE - INTERVAL '6 months' THEN u.user_id END) AS active_users,
    COUNT(e.event_id) AS total_events
FROM raw.users u
LEFT JOIN raw.events e ON u.user_id = e.user_id
GROUP BY u.location;

/*
-- KPI Mensuels --
Règles de gestion :
- Un utilisateur est actif pour un mois donné si il a eu au moins un événement ce mois.
- Les churned sont calculés globalement mois par mois selon la règle des 6 mois sans événement.
Indicateurs mensuels :
- nombre total d'événements dans le mois
- nombre d'utilisateurs actifs dans le mois
- nombre d'utilisateurs churned (selon la définition)
- nombre d'utilisateurs inactifs (jamais eu d'événement)
*/
DROP TABLE IF EXISTS analytics.kpis_month;
CREATE TABLE analytics.kpis_month AS
SELECT
    DATE_FORMAT(event_time, '%Y-%m') AS month,  -- Remplace DATE_FORMAT selon SGBD, sinon EXTRACT + concat
    COUNT(event_id) AS total_events,
    COUNT(DISTINCT CASE WHEN event_time >= CURRENT_DATE - INTERVAL '6 months' THEN user_id END) AS nb_active_users,
    -- Approximation churned : utilisateurs ayant eu activité il y a plus de 6 mois mais pas dans les 6 derniers mois
    (SELECT COUNT(DISTINCT user_id) FROM raw.events 
     WHERE event_time < DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)) -
    (SELECT COUNT(DISTINCT user_id) FROM raw.events
     WHERE event_time >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)) AS nb_churned_users,
    (SELECT COUNT(user_id) FROM raw.users u
     WHERE NOT EXISTS (SELECT 1 FROM raw.events e WHERE e.user_id = u.user_id)) AS nb_inactive_users
FROM raw.events
GROUP BY month
ORDER BY month;

/*
-- KPI par jeu --
Règles :
- Regroupement des événements et utilisateurs par jeu.
- Calcul des indicateurs d'engagement par jeu.
Indicateurs par jeu :
- nombre total d'événements
- nombre d'utilisateurs distincts ayant joué
- moyenne durée des événements
- nombre d'utilisateurs actifs (avec événement dans 6 derniers mois)
*/
DROP TABLE IF EXISTS analytics.kpis_game;
CREATE TABLE analytics.kpis_game AS
SELECT
    g.game_id,
    COALESCE(g.game_type, 'unknown') AS game_type,
    COALESCE(g.game_name, 'unknown') AS game_name,
    COUNT(e.event_id) AS total_events,
    COUNT(DISTINCT e.user_id) AS nb_users,
    AVG(e.duration_seconds) AS avg_event_duration,
    COUNT(DISTINCT CASE WHEN e.event_time >= CURRENT_DATE - INTERVAL '6 months' THEN e.user_id END) AS nb_active_users
FROM raw.games g
LEFT JOIN raw.events e ON g.game_id = e.game_id
GROUP BY g.game_id, g.game_type, g.game_name;

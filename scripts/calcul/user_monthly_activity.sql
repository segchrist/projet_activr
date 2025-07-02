-- Indicateur : nombre d'événements par utilisateur par mois

DROP TABLE IF EXISTS indicators.user_monthly_activity;

CREATE TABLE indicators.user_monthly_activity AS
SELECT
  user_id,
  DATE_TRUNC('month', event_time) AS month,
  COUNT(*) AS event_count
FROM clean.events
GROUP BY user_id, DATE_TRUNC('month', event_time)
ORDER BY user_id, month;

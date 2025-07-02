-- Indicateur : récence d'activité (jours depuis dernier événement)

DROP TABLE IF EXISTS indicators.user_recency;

WITH last_event AS (
  SELECT
    user_id,
    MAX(event_time) AS last_event_time
  FROM clean.events
  GROUP BY user_id
),
current_date AS (
  SELECT CURRENT_DATE AS today
)
CREATE TABLE indicators.user_recency AS
SELECT
  le.user_id,
  le.last_event_time,
  (CURRENT_DATE - DATE(le.last_event_time)) AS days_since_last_event
FROM last_event le;

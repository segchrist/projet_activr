DROP TABLE IF EXISTS indicators.user_avg_inter_event_time;

WITH event_gaps AS (
  SELECT
    user_id,
    event_time,
    LAG(event_time) OVER (PARTITION BY user_id ORDER BY event_time) AS prev_event_time
  FROM clean.events
),
event_durations AS (
  SELECT
    user_id,
    EXTRACT(EPOCH FROM (event_time - prev_event_time))/3600 AS hours_between_events -- durée en heures
  FROM event_gaps
  WHERE prev_event_time IS NOT NULL
)
CREATE TABLE indicators.user_avg_inter_event_time AS
SELECT
  user_id,
  ROUND(AVG(hours_between_events),2) AS avg_hours_between_events
FROM event_durations
GROUP BY user_id;

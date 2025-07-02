DROP TABLE IF EXISTS indicators.user_activity_segmentation;

WITH recent_events AS (
  SELECT
    user_id,
    COUNT(*) AS event_count_30d
  FROM clean.events
  WHERE event_time >= CURRENT_DATE - INTERVAL '30 days'
  GROUP BY user_id
)
CREATE TABLE indicators.user_activity_segmentation AS
SELECT
  user_id,
  event_count_30d,
  CASE
    WHEN event_count_30d >= 20 THEN 'intense'
    WHEN event_count_30d BETWEEN 5 AND 19 THEN 'regular'
    WHEN event_count_30d BETWEEN 1 AND 4 THEN 'occasional'
    ELSE 'inactive'
  END AS activity_segment
FROM recent_events;

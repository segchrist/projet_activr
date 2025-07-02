DROP TABLE IF EXISTS indicators.user_cumulative_events;

WITH user_events AS (
  SELECT
    e.user_id,
    e.event_time,
    ROW_NUMBER() OVER (PARTITION BY e.user_id ORDER BY e.event_time) AS event_number
  FROM clean.events e
)
CREATE TABLE indicators.user_cumulative_events AS
SELECT
  user_id,
  event_time,
  event_number AS cumulative_events
FROM user_events
ORDER BY user_id, event_time;

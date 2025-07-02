DROP TABLE IF EXISTS indicators.game_14day_weighted_moving_avg;

WITH daily_events AS (
  SELECT
    game_id,
    DATE(event_time) AS event_day,
    COUNT(*) AS daily_count
  FROM clean.events
  GROUP BY game_id, event_day
),
weights AS (
  SELECT
    generate_series(0,13) AS day_offset,
    -- poids décroissant linéairement
    (14 - generate_series(0,13))::FLOAT / 14 AS weight
)
SELECT
  de.game_id,
  de.event_day,
  SUM(de2.daily_count * w.weight) AS weighted_moving_avg_14d
INTO indicators.game_14day_weighted_moving_avg
FROM daily_events de
JOIN daily_events de2 ON de.game_id = de2.game_id 
  AND de2.event_day BETWEEN de.event_day - INTERVAL '13 days' AND de.event_day
JOIN weights w ON de.event_day - de2.event_day = w.day_offset * INTERVAL '1 day'
GROUP BY de.game_id, de.event_day
ORDER BY de.game_id, de.event_day;

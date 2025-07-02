DROP TABLE IF EXISTS indicators.event_distribution_day_hour;

CREATE TABLE indicators.event_distribution_day_hour AS
SELECT
  EXTRACT(DOW FROM event_time) AS day_of_week,  -- 0=dimanche, 6=samedi
  EXTRACT(HOUR FROM event_time) AS hour_of_day,
  COUNT(*) AS event_count
FROM clean.events
GROUP BY day_of_week, hour_of_day
ORDER BY day_of_week, hour_of_day;

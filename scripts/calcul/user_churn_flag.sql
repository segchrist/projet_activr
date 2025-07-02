DROP TABLE IF EXISTS indicators.user_churn_flag;

WITH last_event AS (
  SELECT user_id, MAX(event_time) AS last_event_time
  FROM clean.events
  GROUP BY user_id
),
current_date AS (
  SELECT CURRENT_DATE AS today
)
CREATE TABLE indicators.user_churn_flag AS
SELECT
  le.user_id,
  le.last_event_time,
  (cd.today - DATE(le.last_event_time)) AS days_since_last_event,
  CASE
    WHEN (cd.today - DATE(le.last_event_time)) > 30 THEN TRUE
    ELSE FALSE
  END AS is_churned
FROM last_event le, current_date cd;

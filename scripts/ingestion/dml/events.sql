-- Insérer les données dans raw.events depuis events.csv
COPY raw.events(event_id, game_id, user_id, device_id, event_time)
FROM 'data/events.csv'
DELIMITER ','
CSV HEADER;

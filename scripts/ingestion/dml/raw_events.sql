-- Insérer les données dans raw.events depuis events.csv
COPY raw.events(event_id,game_id,user_id,event_time,event_type,duration_seconds,device_type)
FROM '{{DATA_PATH}}/events.csv'
DELIMITER ','
CSV HEADER;

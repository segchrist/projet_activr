-- Insérer les données dans raw.games depuis games.csv
COPY raw.games(game_id,game_type,game_name,platform,difficulty)
FROM '{{DATA_PATH}}/games.csv'
DELIMITER ','
CSV HEADER;

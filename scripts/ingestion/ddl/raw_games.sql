-- DROP si existe
DROP TABLE IF EXISTS raw.games;

-- Création table raw.games (données brutes)
CREATE TABLE raw.games (
    game_id INTEGER PRIMARY KEY,
    game_type TEXT,
    game_name TEXT,
    platform TEXT,
    difficulty TEXT
);
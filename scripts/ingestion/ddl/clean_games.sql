-- DROP si existe
DROP TABLE IF EXISTS clean.games;

CREATE TABLE clean.games(
    game_id INTEGER PRIMARY KEY,
    game_type VARCHAR(255),
    game_name VARCHAR(255),
    platform VARCHAR(255),
    difficulty VARCHAR(255),
    CONSTRAINT chk_difficulty CHECK(difficulty IN ('easy', 'medium', 'hard'))
)



-- Nettoyage et création table clean.games
CREATE TABLE clean.games AS
SELECT
    game_id,
    -- Nettoyer les valeurs nulles ou vides dans game_type
    CASE 
        WHEN game_type IS NULL OR TRIM(game_type) = '' THEN 'unknown'
        ELSE LOWER(TRIM(game_type))
    END AS game_type,
    -- Nettoyer game_name, remplacer NULL par 'unknown'
    COALESCE(NULLIF(TRIM(game_name), ''), 'unknown') AS game_name
FROM raw.games;

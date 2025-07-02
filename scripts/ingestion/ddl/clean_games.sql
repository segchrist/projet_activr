-- DROP si existe
DROP TABLE IF EXISTS clean.games;

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

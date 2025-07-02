-- Supprime les données existantes dans la table clean
TRUNCATE TABLE clean.users;

-- Insère les données nettoyées depuis raw.users
INSERT INTO clean.games(
  game_id,
  game_type,
  game_name,
  platform,
  difficulty
)
SELECT 
game_id,
lower(trim(game_type)) AS game_type 
lower(trim(game_name)) AS game_name,
lower(trim(platform)) AS platform, 
lower(trim(difficulty)) AS difficulty
FROM raw.games
WHERE game_id IS NOT NULL;
-- DROP si existe
DROP TABLE IF EXISTS clean.events;

-- Nettoyage et création table clean.events
CREATE TABLE clean.events AS
SELECT
    event_id,
    game_id,
    user_id,
    device_id,
    -- Convertir event_time en timestamp, si impossible mettre une date par défaut
    COALESCE(
        TO_TIMESTAMP(event_time, 'YYYY-MM-DD HH24:MI:SS'),
        TO_TIMESTAMP('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
    ) AS event_time
FROM raw.events;

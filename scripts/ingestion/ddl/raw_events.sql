-- DROP si existe
DROP TABLE IF EXISTS raw.events;

CREATE TABLE raw.events (
    event_id SERIAL PRIMARY KEY,
    game_id INTEGER,
    user_id INTEGER,
    device_id INTEGER,
    event_time TEXT
);

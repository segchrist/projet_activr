DROP TABLE IF EXISTS raw.users;

CREATE TABLE raw.users (
    event_id INTEGER PRIMARY KEY,
    game_id INTEGER,
    user_id INTEGER,
    event_time TEXT,
    event_type TEXT,
    duration_seconds TEXT,
    device_type TEXT
    );
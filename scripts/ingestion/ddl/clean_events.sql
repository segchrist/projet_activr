-- DROP si existe
DROP TABLE IF EXISTS clean.events;

CREATE TABLE clean.events(
    event_id INTEGER PRIMARY KEY,
    game_id INTEGER,
    user_id INTEGER,
    event_time TIMESTAMP,
    event_type VARCHAR(255),
    duration_seconds INTEGER,
    device_type VARCHAR(255)
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_game FOREIGN KEY (game_id) REFERENCES games(game_id)
);
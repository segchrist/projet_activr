DROP TABLE IF EXISTS raw.users;

CREATE TABLE raw.users (
    user_id INTEGER PRIMARY KEY,
    age TEXT,
    registration_date DATE,
    email TEXT,
    workout_frequency TEXT
);
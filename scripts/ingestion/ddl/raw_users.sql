DROP TABLE IF EXISTS raw.users;

CREATE TABLE raw.users (
    user_id INTEGER PRIMARY KEY,
    age_range TEXT,
    gender TEXT,
    registration_date TEXT,
    email TEXT,
    workout_frequency TEXT,
    location TEXT,
    subscription_type TEXT
);
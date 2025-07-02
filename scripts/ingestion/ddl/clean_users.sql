-- Supprimer la table clean.users si elle existe déjà
DROP TABLE IF EXISTS clean.users;

CREATE TABLE clean.users(
    user_id INTEGER PRIMARY KEY,
    age VARCHAR(255),
    registration_date DATE,
    email VARCHAR(255),
    workout_frequency VARCHAR(255),
    location VARCHAR(255),
    subscription_type VARCHAR(255),
    registration_year INTEGER,
    registration_month INTEGER, 
    registration_week INTEGER,
    CONSTRAINT chk_workout CHECK(workout_frequency IN ('flexible', 'minimal', 'regular', 'maximal'))
);
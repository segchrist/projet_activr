-- Insérer les données dans raw.users depuis users.csv
COPY raw.users(user_id, age, registration_date, email, workout_frequency)
FROM 'data/users.csv'
DELIMITER ','
CSV HEADER;

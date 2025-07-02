-- Insérer les données dans raw.users depuis users.csv
COPY raw.users(user_id,age_range,registration_date,email,workout_frequency,gender,location,subscription_type)
FROM '{{DATA_PATH}}/users.csv'

DELIMITER ','
CSV HEADER;

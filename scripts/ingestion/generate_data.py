import csv
import random
from datetime import datetime, timedelta

# Pour générer des dates aléatoires entre deux dates
def random_date(start, end):
    delta = end - start
    random_days = random.randint(0, delta.days)
    random_seconds = random.randint(0, 86400 - 1)
    return start + timedelta(days=random_days, seconds=random_seconds)

# --- Générer users.csv ---

workout_freq_options = ['minimal', 'flexible', 'regular', 'maximal', None, 'Flexible', 'MINIMAL', 'MAXIMAL']

with open('../../data/users.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['user_id', 'age', 'registration_date', 'email', 'workout_frequency'])
    for user_id in range(1, 501):
        age = random.choice([random.randint(18, 60), None])  # Certaines ages manquantes
        reg_date = random_date(datetime(2023, 1, 1), datetime(2024, 6, 30)).date()
        if random.random() < 0.05:  # 5% missing registration_date
            reg_date = ''
        email = f'user{user_id}@example.com' if random.random() > 0.05 else ''  # 5% missing email
        workout = random.choice(workout_freq_options)
        if workout is None:
            workout = ''
        writer.writerow([user_id, age if age is not None else '', reg_date, email, workout])

# --- Générer games.csv ---

game_types = ['biking', 'running', 'yoga', 'swimming', 'walking']

with open('../../data/games.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['game_id', 'game_type'])
    for game_id in range(1, 21):
        writer.writerow([game_id, random.choice(game_types)])

# --- Générer events.csv ---

with open('../../data/events.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['event_id', 'user_id', 'game_id', 'event_time'])
    for event_id in range(1, 2001):
        user_id = random.randint(1, 500)
        # 5% des game_id sont NULL (manquants)
        if random.random() < 0.05:
            game_id = ''
        else:
            game_id = random.randint(1, 20)
        event_time = random_date(datetime(2023, 1, 1), datetime(2024, 6, 30))
        event_time_str = event_time.strftime('%Y-%m-%d %H:%M:%S')
        writer.writerow([event_id, user_id, game_id, event_time_str])

print("Fichiers CSV générés : users.csv, games.csv, events.csv")

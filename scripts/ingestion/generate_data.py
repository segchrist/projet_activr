import csv
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()
random.seed(42)
Faker.seed(42)

# === Paramètres ===
NUM_USERS = 500
NUM_EVENTS = 100000
NUM_GAMES = 50

# === Données possibles ===
workout_levels = ['flexible', 'minimal', 'regular', 'maximal']
subscription_types = ['free', 'premium', 'trial']
genders = ['M', 'F', 'Other']
locations = ['Paris', 'Lyon', 'Berlin', 'Madrid', 'Rome']
device_types = ['mobile', 'web', 'console']
event_types = ['login', 'start_game', 'finish_game', 'purchase']
game_types = ['cardio', 'strategy', 'puzzle', 'arcade', 'action']
platforms = ['iOS', 'Android', 'Web']
difficulties = ['easy', 'medium', 'hard']

def age_to_range(age_str):
    if not age_str.isdigit():
        return ""  # vide si inconnu ou vide
    age = int(age_str)
    if age < 18:
        return "<18"
    elif age <= 25:
        return "18-25"
    elif age <= 35:
        return "26-35"
    elif age <= 50:
        return "36-50"
    else:
        return "50+"

# === Generation USERS ===
user_ids = []
with open('users.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['user_id', 'age_range', 'registration_date', 'email', 'workout_frequency', 'gender', 'location', 'subscription_type'])

    for i in range(1, NUM_USERS + 1):
        user_ids.append(i)
        age = random.choice(['25', '30', '35', '40',''])  # erreurs possibles : vide
        age_range = age_to_range(age)
        reg_date = fake.date_between(start_date='-2y', end_date='today').isoformat()
        email = fake.email()
        workout = random.choice(workout_levels + ['Regular', 'FLEXIBLE', 'maxiMal'])  # casse variee
        gender = random.choice(genders + [''])  # vide possible
        location = random.choice(locations + [''])  # vide possible
        sub = random.choice(subscription_types + ['trial', 'Trial'])  # casse incoherente

        writer.writerow([i, age_range, reg_date, email, workout, gender, location, sub])

# === Generation GAMES ===
game_ids = list(range(100, 100 + NUM_GAMES))
game_names = [f"{fake.word().capitalize()} Quest" for _ in range(NUM_GAMES)]

with open('games.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['game_id', 'game_type', 'game_name', 'platform', 'difficulty'])

    for i, name in zip(game_ids, game_names):
        g_type = random.choice(game_types + ['Actionn', '', 'PuzZle'])  # erreurs
        plat = random.choice(platforms + ['WEB', 'androiid', ''])       # erreurs
        diff = random.choice(difficulties + ['Medium', 'HARD', ''])     # erreurs

        writer.writerow([i, g_type, name, plat, diff])

# === Generation EVENTS ===
with open('events.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['event_id', 'game_id', 'user_id', 'event_time', 'event_type', 'duration_seconds', 'device_type'])

    for i in range(1, NUM_EVENTS + 1):
        game_id = random.choice(game_ids + [9999])  # 9999 = erreur FK
        user_id = random.choice(user_ids + [9999])  # 9999 = erreur FK
        event_time = (datetime.now() - timedelta(days=random.randint(0, 365), seconds=random.randint(0, 86400))).isoformat()

        event_type = random.choice(event_types + ['Start_Game', 'login', ''])  # casse ou vide
        duration = random.choice([30, 60, 90, '', -10])  # vide ou negatif
        device = random.choice(device_types + ['tablet', 'MOBILE'])  # casse / inconnu

        writer.writerow([i, game_id, user_id, event_time, event_type, duration, device])

print("Fichiers generes : users.csv, events.csv, games.csv (avec erreurs)")

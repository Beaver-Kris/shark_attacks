import pandas as pd
import psycopg2
from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

load_dotenv()  

DB_PASSWORD = os.getenv('POSTGRES_PASSWORD')
DB_NAME = os.getenv('DB_NAME')
DB_USER = os.getenv('DB_USER')
DB_HOST = os.getenv('DB_HOST')
TABLE_NAME = 'shark_attacks'  


# Get data
current_folder = os.path.dirname(os.path.abspath(__file__))
csv_path = os.path.join(current_folder, '../data/processed/shark_attacks_clean.csv')
csv_path = os.path.normpath(csv_path)
df = pd.read_csv(csv_path)
print(f"Loaded {len(df)} rows")

# columns to lower plus no spaces/dashes
df.columns = df.columns.str.lower().str.replace(' ', '_').str.replace('-', '_')
print("Column names:", df.columns.tolist())

# Create data base if doesnt exist
conn_string_system = f'postgresql://postgres:{DB_PASSWORD}@localhost:5432/postgres'
engine_system = create_engine(conn_string_system)

try:
    with engine_system.connect() as conn:
        conn.execute(text("COMMIT"))
        conn.execute(text(f"CREATE DATABASE {DB_NAME}"))
        print(f"Database '{DB_NAME}' created")
except Exception as e:
    print(f"Database probably exists: {e}")

# Connect database
conn_string = f'postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:5432/{DB_NAME}'
engine = create_engine(conn_string)

# Import data
df.to_sql(TABLE_NAME, engine, if_exists='replace', index=False)
print(f"Data imported successfully into '{TABLE_NAME}'!")

#test if worked 

with engine.connect() as conn:
    result = conn.execute(text(f"SELECT COUNT(*) FROM {TABLE_NAME}"))
    print(f"Rows in PostgreSQL: {result.fetchone()[0]}")
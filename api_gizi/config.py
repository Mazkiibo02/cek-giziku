import os
from dotenv import load_dotenv

# Load file .env
load_dotenv()

class Config:
    SECRET_KEY = os.getenv("SECRET_KEY")
    JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY")
    
    # Database
    SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Email Config
    MAIL_SERVER = os.getenv("MAIL_SERVER")
    MAIL_PORT = int(os.getenv("MAIL_PORT", 587))  # default ke 587 jika MAIL_PORT tidak ada
    MAIL_USERNAME = os.getenv("MAIL_USERNAME")
    MAIL_PASSWORD = os.getenv("MAIL_PASSWORD")
    MAIL_USE_TLS = os.getenv("MAIL_USE_TLS") == "True"
    MAIL_USE_SSL = os.getenv("MAIL_USE_SSL") == "True"
    GOOGLE_CLIENT_ID = os.environ.get('GOOGLE_CLIENT_ID', '1033015610648-cpohg0sg95jbms0380c5s37380tqi767.apps.googleusercontent.com')
    GOOGLE_CLIENT_SECRET = os.environ.get('GOOGLE_CLIENT_SECRET', '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')
    GOOGLE_REDIRECT_URI = os.environ.get('GOOGLE_REDIRECT_URI', 'http://localhost:5000/api/auth/google/callback')
    FACEBOOK_CLIENT_ID = os.environ.get('FACEBOOK_CLIENT_ID', '3844990322480627')
    FACEBOOK_CLIENT_SECRET = os.environ.get('FACEBOOK_CLIENT_SECRET', '37665bfebb91344cdce38d48928330ad')
    FACEBOOK_REDIRECT_URI = os.environ.get('FACEBOOK_REDIRECT_URI', 'http://localhost:5000/api/auth/facebook/callback')

from flask import Flask
from config import Config
from extensi import db, migrate, bcrypt, jwt, mail
from routes.authRoute import auth_bp
from routes.MakananRoute import Makanan_bp
from routes.profileRoute import profile_bp


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    db.init_app(app)
    migrate.init_app(app, db)
    bcrypt.init_app(app)
    jwt.init_app(app)
    mail.init_app(app)

    app.register_blueprint(auth_bp, url_prefix="/api/auth")
    app.register_blueprint(Makanan_bp, url_prefix="/api/makanan")
    app.register_blueprint(profile_bp, url_prefix="/api/profile")


    return app

if __name__ == "__main__":
    app = create_app()
    app.run(debug=True, host="0.0.0.0")
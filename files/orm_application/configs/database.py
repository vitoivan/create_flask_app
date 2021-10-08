from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from dotenv import load_dotenv
from sqlalchemy_utils import create_database, database_exists
from sqlalchemy import create_engine
import os

load_dotenv()
db_uri = os.environ.get("DB_URI")
engine = create_engine(db_uri)
if not database_exists(engine.url):
    create_database(engine.url)
db = SQLAlchemy()


def init_app(app: Flask):
    app.config["SQLALCHEMY_DATABASE_URI"] = db_uri
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    app.config["JSON_SORT_KEYS"] = False
    app.config["JWT_SECRET_KEY"] = os.environ.get("SECRET_KEY")
    db.init_app(app)
    app.db = db

    # import models

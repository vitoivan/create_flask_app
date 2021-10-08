from dotenv import load_dotenv
from os import environ
from flask import Flask

load_dotenv()

def init_app(app: Flask):
    
    app.config['JSON_SORT_KEYS'] = False
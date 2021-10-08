from flask import Flask

def init_app(app: Flask):

    from . import env

    env.init_app(app)
from flask import Flask

def init_app(app: Flask):

    from . import database, env, migrations

    env.init_app(app)
    database.init_app(app)
    migrations.init_app(app)
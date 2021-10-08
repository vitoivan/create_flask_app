from flask import Flask

def create_app():
    app = Flask(__name__)

    from . import configs, blueprints

    configs.init_app(app)
    blueprints.init_app(app)

    return app
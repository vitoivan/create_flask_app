from flask import Flask

def init_app(app: Flask):
    
    from .index_blueprint import index_bp
    app.register_blueprint(index_bp)

    return app
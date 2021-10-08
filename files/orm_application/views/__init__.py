from flask import Flask

def init_app(app: Flask):
    
    from app.views.index import index_view
    index_view(app)

    return app

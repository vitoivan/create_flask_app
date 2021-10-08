from flask import Flask

def index_view(app: Flask):

    @app.route("/", methods=["GET"])
    def home():
        return "Yaay! CFA is working :)"

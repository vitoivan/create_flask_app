from flask import Blueprint

index_bp = Blueprint('index_bp', __name__)

@index_bp.get('/')
def index():
    return 'Yaaay, CFA is running! :)'
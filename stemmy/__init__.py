# Import flask
from flask import Flask

# Define the WSGI application object
app = Flask(__name__, instance_relative_config=True)

# Configurations
app.config.from_object('config')
app.config.from_pyfile('config.py', silent=True)

from . import views
from .util import assets

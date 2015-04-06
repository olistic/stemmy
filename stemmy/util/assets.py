from flask.ext.assets import Bundle, Environment
from .. import app

bundles = {

    'js_all': Bundle(
        'js/lib/jquery-1.11.2.js',
        Bundle(
            'js/app.coffee',
            filters='coffeescript'),
        output='gen/app.js',
        filters='rjsmin'),

    'css_all': Bundle(
        'css/lib/normalize.css',
        Bundle(
            'css/main.scss',
            filters='pyscss'),
        output='gen/min.css',
        filters='cssmin')
}

assets = Environment(app)

assets.register(bundles)

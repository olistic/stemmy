from flask import render_template, request
from stemming.porter2 import stem as porter2_stem

from . import app


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/stem')
def stem():
    source = request.args.get('source')
    stemmed_words = [porter2_stem(w) for w in source.split()]
    return ' '.join(stemmed_words)

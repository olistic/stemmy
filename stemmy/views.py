from flask import render_template, request
from stemming.lovins import stem as lovins_stem
from stemming.paicehusk import stem as paicehusk_stem
from stemming.porter import stem as porter_stem
from stemming.porter2 import stem as porter2_stem

from . import app

ALGORITHMS = {
    'lovins': lovins_stem,
    'paicehusk': paicehusk_stem,
    'porter': porter_stem,
    'porter2': porter2_stem
}


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/stem')
def stem_words():
    algorithm = request.args.get('algorithm')
    stem = ALGORITHMS[algorithm]
    source = request.args.get('source')
    stemmed_words = [stem(w) for w in source.split()]
    return ' '.join(stemmed_words)

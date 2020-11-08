from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort

from stickersend.auth import login_required
from stickersend.db import get_db

bp = Blueprint('chat', __name__)

@bp.route('/')
@login_required
def index():
    db = get_db()
    contacts = db.execute(
        'SELECT * FROM users'
    ).fetchall()

    sticker_packs = db.execute(
        'SELECT DISTINCT pack_name FROM stickers'
    ).fetchall()
    stickers = db.execute(
        'SELECT * FROM stickers'
    ).fetchall()

    messages = db.execute(
        'SELECT M.* FROM messages M INNER JOIN users U ON U.id = M.sender_id WHERE U.id = 1'
    ).fetchall()
    return render_template('chat/index.html', contacts=contacts, sticker_packs=sticker_packs, stickers=stickers)


@bp.route('/update/<int:id>', methods=('GET', 'POST'))
@login_required
def update(id):

    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        personal_message = request.form['personal_message']
        facebook_url = request.form['facebook_url']
        twitter_url = request.form['twitter_url']
        birth_date = request.form['birth_date']
        error = None

        if not username:
            error = "Nom d'utilisateur requis"
        elif not email:
            error = "Adresse email requise"

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'UPDATE users SET username = ?, email = ?, personal_message = ?, facebook_url = ?, twitter_url = ?, birth_date = ? WHERE id = ?',
                (username, email, personal_message, facebook_url, twitter_url, birth_date, id,)
            )
            db.commit()
            return redirect(url_for('chat.index'))

    return render_template("chat/update.html")
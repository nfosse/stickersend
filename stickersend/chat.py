from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for, session
)
from werkzeug.exceptions import abort

from stickersend.auth import login_required
from stickersend.db import get_db

bp = Blueprint('chat', __name__)


def get_result_message():
    userId = session['user_id']
    db = get_db()

    stickers_sent = db.execute(
        'SELECT S. *, U.username, R.username as receiver_name, M.receiver_id, M.send_date FROM messages M '
        'INNER JOIN users U ON U.id = M.sender_id '
        'INNER JOIN users R ON R.id = M.receiver_id '
        'INNER JOIN stickers S ON S.id = M.sticker_id '
        'WHERE M.sender_id = ? OR M.receiver_id = ?',
        (userId, userId,)
    ).fetchall()
    return stickers_sent


@bp.route('/')
@login_required
def index():
    # Calls Database
    db = get_db()

    # Fetch all data from users table
    contacts = db.execute(
        'SELECT * FROM users'
    ).fetchall()

    # Fetch all data from stickers table but pack_name won't repeat
    sticker_packs = db.execute(
        'SELECT DISTINCT pack_name FROM stickers'
    ).fetchall()
    stickers = db.execute(
        'SELECT * FROM stickers'
    ).fetchall()

    send_message = get_result_message()

    return render_template('chat/index.html', stickers_message=send_message, contacts=contacts, sticker_packs=sticker_packs, stickers=stickers)


# Update user information
@bp.route('/update/<int:id>', methods=('GET', 'POST'))
@login_required
def update(id):

    if request.method == 'POST':
        # Get name input from the update form
        username = request.form['username']
        email = request.form['email']
        personal_message = request.form['personal_message']
        facebook_url = request.form['facebook_url']
        twitter_url = request.form['twitter_url']
        birth_date = request.form['birth_date']
        error = None

        # When the user modifies the values, he can't leave the username and email empty
        if not username:
            error = "Nom d'utilisateur requis"
        elif not email:
            error = "Adresse email requise"

        if error is not None:
            flash(error)
        # If there is no error, call database
        else:
            db = get_db()
            # Execute an update request to retrieve data that was inserted in the form
            db.execute(
                'UPDATE users'
                ' SET username = ?, email = ?, personal_message = ?, facebook_url = ?, twitter_url = ?, birth_date = ?'
                ' WHERE id = ?',
                (username, email, personal_message, facebook_url, twitter_url, birth_date, id,)
            )
            db.commit()
            return redirect(url_for('chat.index'))

    return render_template("chat/update.html")


@bp.route('/send_sticker/<int:stickerId>', methods=('GET', 'POST'))
def send_sticker(stickerId):
    userId = session['user_id']
    db = get_db()
    session['sticker_id'] = stickerId

    if request.method == 'POST':
        contactId = request.form['contactid']
        db.execute(
            'INSERT INTO messages (sender_id, receiver_id, sticker_id) VALUES (?, ?, ?)',
            (userId, contactId, stickerId,)
        )
        db.commit()
        return redirect(url_for('chat.index'))
    return index()

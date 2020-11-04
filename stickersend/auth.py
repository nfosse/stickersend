import functools

from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash, generate_password_hash

from stickersend.db import get_db

bp = Blueprint('auth', __name__)

@bp.route('/register', methods=('GET', 'POST'))
def register():
    if request.method == 'POST':
        newusername = request.form['newusername']
        newemail = request.form['newemail']
        newpassword = request.form['newpassword']
        db = get_db()
        error = None

        if not newusername:
            error = "Nom d'utilisateur requis"
        elif not newemail:
            error = "Adresse email requise"
        elif not newpassword:
            error = "Mot de passe requis"
        elif db.execute(
            'SELECT id FROM users WHERE username = ? AND email = ?', (newusername, newemail,)
        ).fetchone() is not None:
            error = 'User {} is already registered.'.format(newusername)

        if error is None:
            db.execute(
                'INSERT INTO users (role_id, username, email, password_hash) VALUES (?, ?, ?, ?)',
                ('3', newusername, newemail, generate_password_hash(newpassword))
            )
            db.commit()
            return redirect(url_for('auth.login'))

        flash(error)

    return render_template('auth/register.html')


@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password_hash = request.form['password_hash']
        db = get_db()
        error = None
        user = db.execute(
            'SELECT * FROM users WHERE username = ?', (username,)
        ).fetchone()

        if user is None:
            error = "Nom d'utilisateur incorrect"
        elif not check_password_hash(user['password_hash'], password_hash):
            error = "Mot de passe incorrect"

        if error is None:
            session.clear()
            session['user_id'] = user['id']
            return redirect(url_for('index'))

        flash(error)

    return render_template('auth/register.html')


@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None
    else:
        g.user = get_db().execute(
            'SELECT * FROM users WHERE id = ?', (user_id,)
        ).fetchone()

@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))


def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for('auth.login'))

        return view(**kwargs)

    return wrapped_view
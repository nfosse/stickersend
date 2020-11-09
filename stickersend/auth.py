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
        # Get name input from the form
        new_username = request.form['newusername']
        new_email = request.form['newemail']
        new_password = request.form['newpassword']

        # Call database and define error default value
        db = get_db()
        error = None

        # Requirements for the data to be send : username, email and password are required
        if not new_username:
            error = "Nom d'utilisateur requis"
        elif not new_email:
            error = "Adresse email requise"
        elif not new_password:
            error = "Mot de passe requis"

        # Execute an SQL request. If it returns a value, the user will be informed that he's already registered
        elif db.execute(
            'SELECT id FROM users WHERE username = ?', (new_username,)
        ).fetchone() is not None:
            error = "L'utilisateur {} est déjà inscrit.".format(new_username)
        elif db.execute(
                'SELECT id FROM users WHERE email = ?', (new_email,)
        ).fetchone() is not None:
            error = "L'email {} est déjà utilisé.".format(new_email)

        # Add user to database if there is no error
        if error is None:
            db.execute(
                'INSERT INTO users (role_id, username, email, password_hash) VALUES (?, ?, ?, ?)',
                ('3', new_username, new_email, generate_password_hash(new_password))
            )
            db.commit()
            # If everything is a success, it redirects the user to the login form
            return redirect(url_for('auth.login'))

        flash(error)

    return render_template('auth/register.html')


@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        # Get name input from the form
        username = request.form['username']
        password_hash = request.form['password_hash']

        # Call database and execute an SQL request
        db = get_db()
        error = None

        # Tries to fetch the data corresponding to what the user wrote
        user = db.execute(
            'SELECT * FROM users WHERE username = ?', (username,)
        ).fetchone()

        # If the username or/and the password don't match, he will get an error
        if user is None:
            error = "Nom d'utilisateur incorrect"
        elif not check_password_hash(user['password_hash'], password_hash):
            error = "Mot de passe incorrect"

        # A new session gets created if there is no error
        if error is None:
            session.clear()
            session['user_id'] = user['id']
            return redirect(url_for('index'))

        flash(error)

    return render_template('auth/register.html')


@bp.before_app_request
def load_logged_in_user():
    # Fetch data related to the user session
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None
    else:
        g.user = get_db().execute(
            'SELECT * FROM users WHERE id = ?', (user_id,)
        ).fetchone()

@bp.route('/logout')
def logout():
    # Clear the session and redirect the user to the login page
    session.clear()
    return redirect(url_for('auth.login'))


def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        # Session required to access the chat
        if g.user is None:
            return redirect(url_for('auth.login'))

        return view(**kwargs)

    return wrapped_view
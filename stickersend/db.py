import sqlite3

import click
from flask import current_app, g
from flask.cli import with_appcontext


# Establishes a connection to the database
def get_db():
    if 'db' not in g:
        g.db = sqlite3.connect(
            current_app.config['DATABASE'],
            detect_types=sqlite3.PARSE_DECLTYPES
        )
        g.db.row_factory = sqlite3.Row

    return g.db


# Checks if a connection was created
def close_db(e=None):
    db = g.pop('db', None)

    if db is not None:
        db.close()


# Runs SQL commands
def init_db():
    db = get_db()

    # Opens an sql file
    with current_app.open_resource('stickersend.sql') as f:
        db.executescript(f.read().decode('utf8'))


# Defines a command that calls the init_db function
@click.command('init-db')
@with_appcontext
def init_db_command():
    """Clear the existing data and create new tables."""
    init_db()
    click.echo('Initialized the database.')


def init_app(app):
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)
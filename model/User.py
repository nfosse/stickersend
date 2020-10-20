from Profile import Profile

class User(Profile):
    def __init__(self, id, username, email, password_hash, picture_url, personal_message, facebook_url, twitter_url, birth_date, friends, creation_date):
        Profile.__init__(self, id, username, email, picture_url, personal_message, facebook_url, twitter_url, birth_date, creation_date)
        self.password_hash = password_hash
        self.friends = friends
from User import User

class UserPremium:
    def __init__(self, id, username, email, password_hash, picture_url, personal_message, facebook_url, twitter_url, birth_date, friends, creation_date):
        User.__init__(self, id, username, email, password_hash, picture_url, personal_message, facebook_url, twitter_url, birth_date, friends, creation_date)
        self.is_premium = 1
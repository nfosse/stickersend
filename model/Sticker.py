from Image import Image

class Sticker:
    def __init__(self, id, image_link, emoji, upload_date):
        Image.__init__(self, id, image_link, upload_date)
        self.emoji = emoji
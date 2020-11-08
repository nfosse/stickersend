DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS stickers;
DROP TABLE IF EXISTS sticker_packs;

CREATE TABLE users (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	role_id INTEGER NOT NULL,
	username VARCHAR(20) NOT NULL UNIQUE,
	email VARCHAR(50) NOT NULL UNIQUE,
	password_hash TEXT NOT NULL,
	picture_url TEXT,
	personal_message TEXT,
	facebook_url TEXT,
	twitter_url TEXT,
	birth_date DATE,
	creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (role_id) REFERENCES roles (id)
);

CREATE TABLE friends (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	user_id INTEGER NOT NULL,
	friend_id INTEGER,
	FOREIGN KEY (user_id) REFERENCES users (id),
	FOREIGN KEY (friend_id) REFERENCES users (id)
);

CREATE TABLE messages (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	sender_id INTEGER NOT NULL,
	receiver_id INTEGER NOT NULL,
	image_link TEXT NOT NULL,
	send_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (sender_id) REFERENCES users (id),
	FOREIGN KEY (receiver_id) REFERENCES users (id)
);

CREATE TABLE roles (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(20) NOT NULL,
	can_upload_images INTEGER,
	can_delete_other_images INTEGER,
	can_create_stickers INTEGER,
	creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stickers (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pack_name VARCHAR(30) NOT NULL,
	image_link VARCHAR(30) NOT NULL,
	upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('admin','1','1','1');

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('premium','1','0','0');

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('member','0','0','0');

INSERT INTO stickers (pack_name,image_link)
VALUES
('baby_yoda','sticker_1.webp'),
('baby_yoda','sticker_2.webp'),
('baby_yoda','sticker_3.webp'),
('baby_yoda','sticker_4.webp'),
('baby_yoda','sticker_5.webp'),
('baby_yoda','sticker_6.webp'),
('baby_yoda','sticker_7.webp'),
('baby_yoda','sticker_8.webp'),
('baby_yoda','sticker_9.webp'),
('memes','sticker_1.webp'),
('memes','sticker_2.webp'),
('memes','sticker_3.webp'),
('memes','sticker_4.webp'),
('memes','sticker_5.webp'),
('memes','sticker_6.webp'),
('memes','sticker_7.webp'),
('memes','sticker_8.webp'),
('memes','sticker_9.webp'),
('memes','sticker_10.webp'),
('memes','sticker_11.webp'),
('molang','sticker_1.webp'),
('molang','sticker_2.webp'),
('molang','sticker_3.webp'),
('molang','sticker_4.webp'),
('molang','sticker_5.webp'),
('molang','sticker_6.webp'),
('molang','sticker_7.webp'),
('molang','sticker_8.webp'),
('molang','sticker_9.webp'),
('molang','sticker_10.webp'),
('molang','sticker_11.webp'),
('molang','sticker_12.webp'),
('molang','sticker_13.webp'),
('molang','sticker_14.webp'),
('molang','sticker_15.webp'),
('molang','sticker_16.webp'),
('molang','sticker_17.webp'),
('molang','sticker_18.webp'),
('molang','sticker_19.webp'),
('molang','sticker_20.webp'),
('molang','sticker_21.webp'),
('molang','sticker_22.webp'),
('molang','sticker_23.webp'),
('molang','sticker_24.webp'),
('molang','sticker_25.webp'),
('molang','sticker_26.webp'),
('molang','sticker_27.webp'),
('molang','sticker_28.webp'),
('molang','sticker_29.webp'),
('molang','sticker_30.webp'),
('polar','sticker_1.webp'),
('polar','sticker_2.webp'),
('polar','sticker_3.webp'),
('polar','sticker_4.webp'),
('polar','sticker_5.webp'),
('polar','sticker_6.webp'),
('polar','sticker_7.webp'),
('polar','sticker_8.webp'),
('polar','sticker_9.webp'),
('polar','sticker_10.webp'),
('polar','sticker_11.webp'),
('polar','sticker_12.webp'),
('polar','sticker_13.webp'),
('polar','sticker_14.webp'),
('polar','sticker_15.webp'),
('polar','sticker_16.webp'),
('pummeleinhorn','sticker_1.webp'),
('pummeleinhorn','sticker_2.webp'),
('pummeleinhorn','sticker_3.webp'),
('pummeleinhorn','sticker_4.webp'),
('pummeleinhorn','sticker_5.webp'),
('pummeleinhorn','sticker_6.webp'),
('pummeleinhorn','sticker_7.webp'),
('pummeleinhorn','sticker_8.webp'),
('pummeleinhorn','sticker_9.webp'),
('pummeleinhorn','sticker_10.webp'),
('pummeleinhorn','sticker_11.webp'),
('pummeleinhorn','sticker_12.webp'),
('pummeleinhorn','sticker_13.webp'),
('pummeleinhorn','sticker_14.webp'),
('pummeleinhorn','sticker_15.webp'),
('pummeleinhorn','sticker_16.webp'),
('pummeleinhorn','sticker_17.webp'),
('pummeleinhorn','sticker_18.webp'),
('pummeleinhorn','sticker_19.webp'),
('pummeleinhorn','sticker_20.webp'),
('pummeleinhorn','sticker_21.webp'),
('pummeleinhorn','sticker_22.webp'),
('stitch','sticker_1.webp'),
('stitch','sticker_2.webp'),
('stitch','sticker_3.webp'),
('stitch','sticker_4.webp'),
('stitch','sticker_5.webp'),
('stitch','sticker_6.webp'),
('stitch','sticker_7.webp'),
('stitch','sticker_8.webp'),
('stitch','sticker_9.webp'),
('stitch','sticker_10.webp'),
('stitch','sticker_11.webp'),
('stitch','sticker_12.webp'),
('stitch','sticker_13.webp'),
('texte','sticker_1.webp'),
('texte','sticker_2.webp'),
('texte','sticker_3.webp'),
('texte','sticker_4.webp'),
('texte','sticker_5.webp'),
('texte','sticker_6.webp'),
('texte','sticker_7.webp'),
('texte','sticker_8.webp'),
('texte','sticker_9.webp'),
('texte','sticker_10.webp'),
('texte','sticker_11.webp');
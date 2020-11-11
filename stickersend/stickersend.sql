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

CREATE TABLE stickers (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pack_name VARCHAR(30) NOT NULL,
	image_link VARCHAR(30) NOT NULL,
	upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE messages (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	sender_id INTEGER NOT NULL,
	receiver_id INTEGER NOT NULL,
	sticker_id INTEGER NOT NULL,
	send_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (sender_id) REFERENCES users (id),
	FOREIGN KEY (receiver_id) REFERENCES users (id),
	FOREIGN KEY (sticker_id) REFERENCES stickers (id)
);

CREATE TABLE roles (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(20) NOT NULL,
	can_upload_images INTEGER,
	can_delete_other_images INTEGER,
	can_create_stickers INTEGER,
	creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('admin','1','1','1');

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('premium','1','0','0');

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('member','0','0','0');

INSERT INTO stickers (pack_name,image_link)
VALUES
('baby_yoda','yoda_1.webp'),
('baby_yoda','yoda_2.webp'),
('baby_yoda','yoda_3.webp'),
('baby_yoda','yoda_4.webp'),
('baby_yoda','yoda_5.webp'),
('baby_yoda','yoda_6.webp'),
('baby_yoda','yoda_7.webp'),
('baby_yoda','yoda_8.webp'),
('baby_yoda','yoda_9.webp'),
('memes','memes_1.webp'),
('memes','memes_2.webp'),
('memes','memes_3.webp'),
('memes','memes_4.webp'),
('memes','memes_5.webp'),
('memes','memes_6.webp'),
('memes','memes_7.webp'),
('memes','memes_8.webp'),
('memes','memes_9.webp'),
('memes','memes_10.webp'),
('memes','memes_11.webp'),
('molang','molang_1.webp'),
('molang','molang_2.webp'),
('molang','molang_3.webp'),
('molang','molang_4.webp'),
('molang','molang_5.webp'),
('molang','molang_6.webp'),
('molang','molang_7.webp'),
('molang','molang_8.webp'),
('molang','molang_9.webp'),
('molang','molang_10.webp'),
('molang','molang_11.webp'),
('molang','molang_12.webp'),
('molang','molang_13.webp'),
('molang','molang_14.webp'),
('molang','molang_15.webp'),
('molang','molang_16.webp'),
('molang','molang_17.webp'),
('molang','molang_18.webp'),
('molang','molang_19.webp'),
('molang','molang_20.webp'),
('molang','molang_21.webp'),
('molang','molang_22.webp'),
('molang','molang_23.webp'),
('molang','molang_24.webp'),
('molang','molang_25.webp'),
('molang','molang_26.webp'),
('molang','molang_27.webp'),
('molang','molang_28.webp'),
('molang','molang_29.webp'),
('molang','molang_30.webp'),
('polar','polar_1.webp'),
('polar','polar_2.webp'),
('polar','polar_3.webp'),
('polar','polar_4.webp'),
('polar','polar_5.webp'),
('polar','polar_6.webp'),
('polar','polar_7.webp'),
('polar','polar_8.webp'),
('polar','polar_9.webp'),
('polar','polar_10.webp'),
('polar','polar_11.webp'),
('polar','polar_12.webp'),
('polar','polar_13.webp'),
('polar','polar_14.webp'),
('polar','polar_15.webp'),
('polar','polar_16.webp'),
('pummeleinhorn','pummeleinhorn_1.webp'),
('pummeleinhorn','pummeleinhorn_2.webp'),
('pummeleinhorn','pummeleinhorn_3.webp'),
('pummeleinhorn','pummeleinhorn_4.webp'),
('pummeleinhorn','pummeleinhorn_5.webp'),
('pummeleinhorn','pummeleinhorn_6.webp'),
('pummeleinhorn','pummeleinhorn_7.webp'),
('pummeleinhorn','pummeleinhorn_8.webp'),
('pummeleinhorn','pummeleinhorn_9.webp'),
('pummeleinhorn','pummeleinhorn_10.webp'),
('pummeleinhorn','pummeleinhorn_11.webp'),
('pummeleinhorn','pummeleinhorn_12.webp'),
('pummeleinhorn','pummeleinhorn_13.webp'),
('pummeleinhorn','pummeleinhorn_14.webp'),
('pummeleinhorn','pummeleinhorn_15.webp'),
('pummeleinhorn','pummeleinhorn_16.webp'),
('pummeleinhorn','pummeleinhorn_17.webp'),
('pummeleinhorn','pummeleinhorn_18.webp'),
('pummeleinhorn','pummeleinhorn_19.webp'),
('pummeleinhorn','pummeleinhorn_20.webp'),
('pummeleinhorn','pummeleinhorn_21.webp'),
('pummeleinhorn','pummeleinhorn_22.webp'),
('stitch','stitch_1.webp'),
('stitch','stitch_2.webp'),
('stitch','stitch_3.webp'),
('stitch','stitch_4.webp'),
('stitch','stitch_5.webp'),
('stitch','stitch_6.webp'),
('stitch','stitch_7.webp'),
('stitch','stitch_8.webp'),
('stitch','stitch_9.webp'),
('stitch','stitch_10.webp'),
('stitch','stitch_11.webp'),
('stitch','stitch_12.webp'),
('stitch','stitch_13.webp'),
('texte','texte_1.webp'),
('texte','texte_2.webp'),
('texte','texte_3.webp'),
('texte','texte_4.webp'),
('texte','texte_5.webp'),
('texte','texte_6.webp'),
('texte','texte_7.webp'),
('texte','texte_8.webp'),
('texte','texte_9.webp'),
('texte','texte_10.webp'),
('texte','texte_11.webp');
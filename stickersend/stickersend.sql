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
	pack_id INTEGER NOT NULL,
	image_link TEXT NOT NULL,
	emoji VARCHAR(30) NOT NULL,
	upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (pack_id) REFERENCES sticker_packs (id)
);

CREATE TABLE sticker_packs (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(30) NOT NULL,
	creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (role_id,username,email,password_hash,picture_url,personal_message,facebook_url,twitter_url,birth_date)
VALUES('1','Shawoo','shawoo@gmail.com', 'passwordtest', 'https://i.pinimg.com/originals/f3/a8/3d/f3a83d21f06c28a5fd999abec5cc0f94.jpg', 'Bonjour, je suis Julie', 'https://www.facebook.com/', 'https://twitter.com/home', '2000-09-23');

INSERT INTO users (role_id,username,email,password_hash,picture_url,personal_message,facebook_url,twitter_url,birth_date)
VALUES('2','Tamky','tamky@gmail.com', 'thebestpassword', 'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs2/112692698/original/31a5d2469689575beee06ffcf4e9e76abab3abe2/logo-design-for-profile-picture-dessin-pour-photo-de-profil.png', 'Coucou, je cherche des gens avec qui discuter', 'https://www.facebook.com/', 'https://twitter.com/home', '1998-02-17');

INSERT INTO friends (user_id,friend_id)
VALUES('1','2');

INSERT INTO friends (user_id,friend_id)
VALUES('2','1');

INSERT INTO messages (sender_id,receiver_id,image_link)
VALUES('1','2','1');

INSERT INTO messages (sender_id,receiver_id,image_link)
VALUES('2','1','2');

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('admin','1','1','1');

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('premium','1','0','0');

INSERT INTO roles (name,can_upload_images,can_delete_other_images,can_create_stickers)
VALUES('member','0','0','0');

INSERT INTO stickers (pack_id,image_link,emoji)
VALUES('1','suspicious.png','suspicious');

INSERT INTO stickers (pack_id,image_link,emoji)
VALUES('1','love.png','in_love');

INSERT INTO sticker_packs (name)
VALUES('yellow_n_wings');
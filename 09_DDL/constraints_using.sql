-- ===== ОДИН-КО-МНОГИМ ============
DROP TABLE users;
DROP TABLE roles;

CREATE TABLE roles (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(50) NOT NULL
);

CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(50) NOT NULL,
	role_id int NOT NULL,

	CONSTRAINT FK_users_role FOREIGN KEY(role_id) REFERENCES roles(id)
);


-- ===== ОДИН-К-ОДНОМУ =========

-- Классический способ

DROP TABLE users;
DROP TABLE roles;

CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(50) UNIQUE NOT NULL,
);

CREATE TABLE profiles (
	id int PRIMARY KEY NOT NULL,
	photo_path varchar(128) NULL,

	CONSTRAINT FK_profiles_id FOREIGN KEY(id) REFERENCES users(id)
);

INSERT INTO users (email)
OUTPUT inserted.id
VALUES ('vasia@mail.com');

INSERT INTO profiles(id, photo_path)
VALUES (1, '/path/imh.jpg')


-- Неклассический способ
DROP TABLE profiles;
DROP TABLE users;


CREATE TABLE profiles (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	photo_path varchar(128) NULL
);

CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(50) UNIQUE NOT NULL,
	profile_id int UNIQUE,

	CONSTRAINT FK_users_profile FOREIGN KEY (profile_id) REFERENCES profiles(id)
);




-- ===== МНОГИЕ-КО-МНОГИМ ============

CREATE TABLE teachers(
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	full_name varchar(50) UNIQUE NOT NULL
);

CREATE TABLE groups(
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	title varchar(50) UNIQUE NOT NULL
);

CREATE TABLE groups_teachers (
	teacher_id int, 
	group_id int,

	CONSTRAINT PK_groups_teachers PRIMARY KEY (teacher_id, group_id),

	CONSTRAINT FK_groups_teachers_teacher FOREIGN KEY (teacher_id) REFERENCES teachers(id),
	CONSTRAINT FK_groups_teachers_group FOREIGN KEY (group_id) REFERENCES groups(id),
);
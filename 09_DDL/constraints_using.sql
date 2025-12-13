-- ===== ОДИН-КО-МНОГИМ ============
--DROP TABLE users;
--DROP TABLE roles;

--CREATE TABLE roles (
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	title varchar(50) NOT NULL
--);

--CREATE TABLE users (
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	email varchar(50) NOT NULL,
--	role_id int NOT NULL,

--	CONSTRAINT FK_users_role FOREIGN KEY(role_id) REFERENCES roles(id)
--);


-- ===== ОДИН-К-ОДНОМУ =========

-- Классический способ

--DROP TABLE users;
--DROP TABLE roles;

--CREATE TABLE users (
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	email varchar(50) UNIQUE NOT NULL,
--);

--CREATE TABLE profiles (
--	id int PRIMARY KEY NOT NULL,
--	photo_path varchar(128) NULL,

--	CONSTRAINT FK_profiles_id FOREIGN KEY(id) REFERENCES users(id)
--);

--INSERT INTO users (email)
--OUTPUT inserted.id
--VALUES ('vasia@mail.com');

--INSERT INTO profiles(id, photo_path)
--VALUES (1, '/path/imh.jpg')


---- Неклассический способ
--DROP TABLE profiles;
--DROP TABLE users;


--CREATE TABLE profiles (
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	photo_path varchar(128) NULL
--);

--CREATE TABLE users (
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	email varchar(50) UNIQUE NOT NULL,
--	profile_id int UNIQUE,

--	CONSTRAINT FK_users_profile FOREIGN KEY (profile_id) REFERENCES profiles(id)
--);




-- ===== МНОГИЕ-КО-МНОГИМ ============

--CREATE TABLE teachers(
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	full_name varchar(50) UNIQUE NOT NULL
--);

--CREATE TABLE groups(
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	title varchar(50) UNIQUE NOT NULL
--);

--CREATE TABLE groups_teachers (
--	teacher_id int, 
--	group_id int,

--	CONSTRAINT PK_groups_teachers PRIMARY KEY (teacher_id, group_id),

--	CONSTRAINT FK_groups_teachers_teacher FOREIGN KEY (teacher_id) REFERENCES teachers(id),
--	CONSTRAINT FK_groups_teachers_group FOREIGN KEY (group_id) REFERENCES groups(id),
--);




--DROP TABLE groups_teachers;
--DROP TABLE teachers;
--DROP TABLE groups;
--DROP TABLE groups_teachers_statuse;


--CREATE TABLE teachers(
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	full_name varchar(50) NOT NULL
--);

--CREATE TABLE groups(
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	title varchar(50) UNIQUE NOT NULL
--);

--CREATE TABLE groups_teachers_statuses (
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	title varchar(50) NOT NULL,					-- in vacation
--	slug varchar(50) NOT NULL,					-- in_vac
--	description varchar(128) NULL,
--	translit varchar(32) NOT NULL
--);

--CREATE TABLE groups_teachers (
--	id int NOT NULL,
--	teacher_id int NOT NULL, 
--	group_id int NOT NULL,
--	start_date date NOT NULL,
--	end_date date NULL,
--	status_id int NOT NULL,

--	CONSTRAINT PK_groups_teachers PRIMARY KEY(id),

--	CONSTRAINT FK_groups_teachers_teacher FOREIGN KEY (teacher_id) REFERENCES teachers(id),
--	CONSTRAINT FK_groups_teachers_group FOREIGN KEY (group_id) REFERENCES groups(id),
--	CONSTRAINT FK_groups_teachers_status FOREIGN KEY (status_id) REFERENCES groups_teachers_statuses(id),
--);


---- TASK
---- Получить информацию об активных группах преподавателя с id = 17

--SELECT
--	g.id,
--	g.title
--FROM 
--	groups_teachers gt 
--		LEFT JOIN groups g ON gt.group_id = g.id
--WHERE 
--	gt.teacher_id = 17 AND
--	gt.status_id = 1;




----------------  Интересные случаи -------------
-- 1. Задача про категории
--class Category
--{
--	public int id;
--	public int title;
--	// public List<Category> children
--	public Category? parent
--}

--CREATE TABLE categories (
--	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	title varchar(50) NOT NULL,
--	parent_id int NULL,

--	CONSTRAINT FK_categories_parent FOREIGN KEY (parent_id) REFERENCES categories (id),
--	CHECK(parent_id <> id)
--);


-- 2. Задача о подписчиках
CREATE TABLE users (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	email varchar(32) UNIQUE NOT NULL
);

CREATE TABLE subscriptions (
	user_id int NOT NULL,
	subscriber_id int NOT NULL,

	CONStrAINT PK_subscriptions PRIMARY KEY (user_id, subscriber_id),

	CONSTRAINT FK_subscriptions_user FOREIGN KEY (user_id) REFERENCES users (id),
	CONSTRAINT FK_subscriptions_user_subscriber FOREIGN KEY (subscriber_id) REFERENCES users (id),

	CHECK(user_id <> subscriber_id)
);






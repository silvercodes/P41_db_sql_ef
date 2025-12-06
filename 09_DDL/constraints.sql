-- ============= PRIMARY KEY =============== --
-- Не допускается NULL
-- Не допускаются дубликаты (значения должны быть уникальными)

---------
-- 1. Допускается 1 ограничение PRIMARY KEY на таблицу
-- 2. Обеспечивается кластеризованным индексом (по-умолчанию)


-- Определение PK при объявлении столбца
--CREATE TABLE units (
--	id int PRIMARY KEY,
--	...
--);


-- Определение вне объявления столбца
--CREATE TABLE units (
--	id int,
--	title varchar(50),
--	clan varchar(50),

--	-- PRIMARY KEY (id)				-- Одиночный PK
--	-- PRIMARY KEY (title, clan)	-- Составной PK

--	CONSTRAINT PK_units_id PRIMARY KEY (id)		-- Полная форма определения PK
--);


-- Добавление PK после создания таблицы
--CREATE TABLE units (
--	id int NOT NULL,
--	title varchar(50)
--);

--ALTER TABLE units
--ADD CONSTRAINT PK_units_id PRIMARY KEY (id)

--DROP TABLE units;

------ EXP -----
--INSERT INTO units(id, title)
--VALUES (101, 'warrior');

--INSERT INTO units(title)			-- ERROR
--VALUES ('warrior');

--INSERT INTO units(id, title)		-- ERROR
--VALUES (101, 'archer');

--INSERT INTO units(id, title)
--VALUES (102, 'archer');

--UPDATE units						-- ERROR
--SET id = 101
--WHERE title = 'archer';






-- ============= FOREIGN KEY =============== --
-- Проверяет значение на принадлежность множеству

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









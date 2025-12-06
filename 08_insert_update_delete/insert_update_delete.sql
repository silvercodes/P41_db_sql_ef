-- =============== INSERT ==============

-- INSERT [INTO] <table> [(<fields...>)] VALUES (<values>);
-- INSERT [INTO] <table> [(<fields...>)] SELECT ....

INSERT INTO albums (title, creation_date, user_id, rate)
	VALUES ('fall_2025', GETDATE(), 7, 1);

INSERT INTO albums (title, creation_date, user_id, rate)
VALUES 
	('temp_10', GETDATE(), 7, 1),
	('temp_20', GETDATE(), 7, 1),
	('temp_30', GETDATE(), 1000000, 1),
	('temp_40', GETDATE(), 7, 1);



-- Вставка в автоинкрементируемое поле (id)
SET IDENTITY_INSERT albums ON;

INSERT INTO albums (id, title, creation_date, user_id, rate)
	VALUES (100, 'party', GETDATE(), 7, 1);

SET IDENTITY_INSERT albums OFF;


-- Получение id вставленной записи
INSERT INTO albums (title, creation_date, user_id, rate)
OUTPUT inserted.id
VALUES
	('party_2024', GETDATE(), 7, 1);


-- CTE
INSERT INTO reports (nickname, email)
SELECT nickname, email
FROM users
WHERE nickname LIKE 'm%';



WITH src AS (
	SELECT nickname, email
	FROM users
	WHERE nickname LIKE 'm%'
)

INSERT INTO reports (nickname, email)
SELECT nickname, email
FROM src;



-- =============== UPDATE ==============
UPDATE albums
SET rate = 12
WHERE id = 2;


UPDATE albums
SET rate = 11
WHERE rate = 10;


UPDATE albums
SET deleted_at = GETDATE()
WHERE id = 2;


-- =============== DELETE ===============
DELETE FROM reports;

DELETE FROM reports
WHERE nickname = 'mcottle1';

-- Полный сброс таблицы
TRUNCATE TABLE reports;

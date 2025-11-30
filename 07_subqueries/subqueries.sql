
-- TASK
-- Посчитать кол-во сотрудников по всем должностям

--SELECT
--	p.title,
--	COUNT(e.id) as [count]
--FROM positions p LEFT JOIN employees e ON p.id = e.position_id
--GROUP BY p.id, p.title;


--SELECT
--	p.title,
--	(
--		SELECT COUNT(id)
--		FROM employees e
--		WHERE e.position_id = p.id
--	) AS [count],
--	(
--		SELECT COUNT(id)
--		FROM employees
--	)
--FROM positions p;



--==============  EXISTS / NOT EXISTS
-- TASK
-- Показать пользователей, которые создавали альбомы
SELECT DISTINCT
	u.id,
	u.nickname
FROM albums a
	LEFT JOIN users u ON a.user_id = u.id



SELECT
	u.id,
	u.nickname
FROM albums a
	LEFT JOIN users u ON a.user_id = u.id
GROUP BY
	u.id, u.nickname



SELECT
	u.id,
	u.nickname
FROM users u
WHERE EXISTS (
	SELECT a.id
	FROM albums a
	WHERE a.user_id = u.id
);


-- TASK
-- Показать пользователей, которые НЕ создавали альбомы

SELECT
	u.id,
	u.nickname
FROM users u
WHERE NOT EXISTS (
	SELECT a.id
	FROM albums a
	WHERE a.user_id = u.id
);



-- TASK
-- Показать пользователей, у которых 2 и более альбома

SELECT u.id, u.nickname
FROM users u
WHERE (
	SELECT COUNT(id)
	FROM albums a
	WHERE a.user_id = u.id
) > 1;



-- for fun
SELECT u.id, u.nickname
FROM users u
WHERE EXISTS (
	SELECT a.user_id
	FROM albums a
	WHERE a.user_id = u.id
	GROUP BY a.user_id
	HAVING COUNT(a.user_id) > 1
);




--======================== ALL / ANY / IN ====================
-- TASK
-- Вывести пользователей у которых есть альбомы с рейтингом 8

SELECT
	id, email
FROM users u
WHERE EXISTS (
	SELECT a.id
	FROM albums a
	WHERE a.rate = 8 AND a.user_id = u.id
);


SELECT
	id, email
FROM users u
WHERE u.id = ANY (
	SELECT a.user_id
	FROM albums a
	WHERE a.rate = 8
);


SELECT
	id, email
FROM users u
WHERE u.id IN (
	SELECT a.user_id
	FROM albums a
	WHERE a.rate = 8
);


-- TASK
-- Для каждого отдела выбрать сотрудника
-- у которого ЗП больше, чем ЗП каждого сотрудника этого отдела

SELECT
	d.title AS [department],
	ISNULL(e.name, '---') AS [employee],
	ISNULL(e.salary, 0) AS [salary]
FROM departments d
	LEFT JOIN employees e ON d.id = e.department_id
WHERE
	e.salary > ALL (
		SELECT emp.salary
		FROM employees emp
		WHERE emp.id <> e.id
			AND emp.department_id = e.department_id
			AND emp.salary IS NOT NULL
	);

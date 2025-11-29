-- Типы JOIN --

-- JOIN				(INNER JOIN)			<--------
-- LEFT JOIN		(LEFT OUTER JOIN)		<--------
-- RIGHT JOIN		(RIGHT OUTER JOIN)
-- FULL JOIN		(FULL OUTER JOIN)		<---
-- CROSS JOIN		(CROSS OUTER JOIN)		<---


--SELECT *
--FROM employees, departments;
---- >>> EQUALS <<<
--SELECT *
--FROM employees CROSS JOIN departments;


-- ========= LEFT JOIN ===============
SELECT *
FROM employees AS e LEFT JOIN departments d ON e.department_id = d.id

SELECT *
FROM departments d LEFT JOIN employees e ON d.id = e.department_id


-- ========= RIGHT JOIN ===============
SELECT *
FROM employees AS e RIGHT JOIN departments d ON e.department_id = d.id

SELECT *
FROM departments d RIGHT JOIN employees e ON d.id = e.department_id


-- ========= FULL JOIN ===============
SELECT *
FROM employees AS e FULL JOIN departments d ON e.department_id = d.id

SELECT *
FROM departments d FULL JOIN employees e ON d.id = e.department_id



-- ========= JOIN ===============
SELECT *
FROM employees AS e JOIN departments d ON e.department_id = d.id

SELECT *
FROM departments d JOIN employees e ON d.id = e.department_id




-- TASK
-- Вернуть кол-во служащих по всем должностям
-- | position | count |

SELECT
	p.title AS [position],
	COUNT(e.id) AS [count]
FROM positions p LEFT JOIN employees e ON p.id = e.position_id
GROUP BY p.id, p.title


-- TASK
-- Вернуть служащих, которые родились 1982 году с информацией об их должности и отделе
-- | emp_id | emp_name | emp_birthday | position | department |

DECLARE @b_year INT = 1982;

SELECT
	e.id							AS [emp_id],
	e.name							AS [emp_name],
	e.birthday						AS [emp_birthday],
	ISNULL(p.title, '---')			AS [position],
	ISNULL(d.title, '---')			AS [department]
FROM employees e
	LEFT JOIN positions p ON e.position_id = p.id
	LEFT JOIN departments d ON d.id = e.department_id
WHERE YEAR(e.birthday) = @b_year;



-- TASK
-- Для нужного отдела вывести дату найма последнего нанятого сотрудника
SELECT
	d.title,
	MAX(e.hire_date)
	-- AX(IIF(e.hire_date = MAX(e.hire_date), e.name, ''))			:-(
FROM departments d LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.id, d.title
HAVING MAX(e.hire_date) IS NOT NULL
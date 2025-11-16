-- Получить инфу по работникам из деп 3
SELECT
	id,
	last_name,
	first_name,
	salary,
	department_id
FROM employees
WHERE department_id = 3

-- Получить работников топ-менеджеров
SELECT *
FROM employees
WHERE manager_id IS NULL;



SELECT
	id,
	email,
	ISNULL(salary, 0) / 100 * bonus_percent AS [amount]
FROM employees
-- WHERE bonus_percent >= 0 AND bonus_percent IS NOT NULL
-- WHERE NOT(bonus_percent < 0 OR bonus_percent IS NULL)
WHERE ISNULL(bonus_percent, 0) <> 0 AND bonus_percent >= 0
ORDER BY amount DESC;



---------- BETWEEN IN LIKE ---------
SELECT id, name, salary
FROM employees

-- WHERE salary >= 2000 AND salary <= 3000;
-- WHERE salary BETWEEN 2000 AND 3000;

-- WHERE NOT (salary >= 2000 AND salary <= 3000);
-- WHERE salary NOT BETWEEN 2000 AND 3000;

--WHERE salary BETWEEN 2000 AND 3000
--		AND department_id = 3;


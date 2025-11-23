
SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 6000;


SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 6000 AND COUNT(id) >= 2;


-- :-(((
SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
GROUP BY department_id
HAVING department_id = 3;

-- :-)))
SELECT
	department_id,
	SUM(salary) AS [salary_sum]
FROM employees
WHERE department_id = 3
GROUP BY department_id;			-- можно опустить

-- SELECT [DISTINCT] [TOP] <statements>
-- [FROM <source>]
-- [WHERE <condition>]
-- [ORDER BY <sorting>]



--SELECT
--	'Vasia',
--	123,
--	550 / 100 * 10,
--	SYSDATETIME(),
--	SIN(0) + COS(0);



--SELECT
--	id,
--	id / 100,
--	id / 100.0,
--	CAST(id as float) / 100,
--	CONVERT(float, id) / 100
--FROM users;



--SELECT 
--	users.id,
--	users.email
--FROM users;


--SELECT 
--	u.id,
--	u.email
--FROM users AS u;


--SELECT id, email, age	-- :-)
--FROM users;
---- >>> EQUALS <<<
--SELECT *				-- :-(
--FROM users;


USE p41_company_db;
----------- DISTINCT -------------------

SELECT DISTINCT
	id,
	department_id
FROM employees;

-- В каких отделах какие должности задействованы?
SELECT DISTINCT
	position_id,
	department_id
FROM employees;

-- Какие отдела задействованы в компании?
SELECT DISTINCT
	department_id
FROM employees;


-------------- Псевдонимы столбцов / расчётные столбцы --------------

SELECT * FROM employees;

SELECT
	100 AS [constant],
	last_name + ' ' + first_name AS [full_name],
	hire_date AS [Дата приёма],
	salary AS ЗП
FROM employees;


SELECT
	last_name + ' ' + first_name + ' ' + middle_name AS [full_name],
	ISNULL(last_name, '') + ' ' + ISNULL(first_name, '') + ' ' + ISNULL(middle_name, '') AS [full_name_2],
	CONCAT(last_name, ' ', first_name, ' ', middle_name) AS [full_name_3]
FROM employees;


SELECT
	id,
	name,
	salary / 100 * bonus_percent AS [res_1],
	salary / 100 * ISNULL(bonus_percent, 0) AS [res_2],
	salary / 100 * COALESCE(bonus_percent, extra_percent, 0) AS [res_3]
FROM employees;



----------------  ORDER BY ------------------

SELECT
	last_name,
	first_name,
	salary
FROM employees
ORDER BY last_name DESC;


SELECT
	last_name,
	first_name,
	salary
FROM employees
ORDER BY salary DESC, last_name;



------- необднозначность результата -----------
-- Вывести первых 3-х работников с наибольшей ЗП
-- :-(((
SELECT TOP 3
	id,
	last_name,
	first_name,
	salary
FROM employees
ORDER BY salary DESC;

-- :-)))
SELECT TOP 3
	id,
	last_name,
	first_name,
	salary
FROM employees
ORDER BY salary DESC, id;



SELECT
	id,
	first_name,
	last_name
FROM employees
ORDER BY CONCAT(first_name, last_name);




SELECT 
	CONCAT(last_name, first_name) AS [full_name]
FROM employees
ORDER BY full_name




SELECT bonus_percent
FROM employees
ORDER BY ISNULL(bonus_percent, 100);



-- Выбрать 2 наиболее маленькие ЗП
-- :-|||
--declare @max_salary float = (SELECT MAX(salary) from employees);
--SELECT @max_salary;

--SELECT DISTINCT TOP 2
--	salary,
--	(SELECT MAX(salary) from employees) AS [xxx]
--FROM employees
--ORDER BY ISNULL(salary, (SELECT MAX(salary) from employees));



SELECT DISTINCT TOP 2
	salary
FROM employees
ORDER BY ISNULL(salary, 999999);


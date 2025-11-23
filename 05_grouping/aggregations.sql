-- COUNT(*)
-- COUNT(<expr>)
-- COUNT(DISTINCT <expr>)
-- SUM(<expr>)
-- AVG(<expr>)
-- MIN(<expr>)
-- MAX(<expr>)

SELECT
	'const_string',
	COUNT(*)							AS [Общее кол-во записей],
	COUNT(bonus_percent)				AS [Количество не NULL значений в поле bonus_percent],
	COUNT(DISTINCT department_id)		AS [Кол-во уникальных не NULL значений],
	MAX(bonus_percent)					AS [Размер максимального bonus_percent],
	SUM(salary / 100 * bonus_percent)	AS [Сумма денег на бонусы],
	AVG(salary / 100 * bonus_percent)	AS [Средняя сумма бонуса]
FROM employees;


SELECT
	'const_string',
	COUNT(*)							AS [Общее кол-во записей],
	COUNT(bonus_percent)				AS [Количество не NULL значений в поле bonus_percent],
	COUNT(DISTINCT department_id)		AS [Кол-во уникальных не NULL значений],
	MAX(bonus_percent)					AS [Размер максимального bonus_percent],
	SUM(salary / 100 * bonus_percent)	AS [Сумма денег на бонусы],
	AVG(salary / 100 * bonus_percent)	AS [Средняя сумма бонуса]
FROM employees
WHERE department_id = 3;


SELECT
	ISNULL(SUM(salary), 0),
	ISNULL(AVG(salary), 0)
FROM employees
WHERE department_id = 100;


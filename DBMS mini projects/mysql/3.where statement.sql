SELECT *
FROM employee_salary
WHERE salary <= 50000;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- AND OR NOT -- Logical Operators
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Male'
; 

-- LIKE Statement
-- % and _

SELECT *
FROM employee_salary
WHERE dept_id is not null
;

SELECT *
FROM employee_demographics
WHERE birth_date like '1989%'
;
-- Temporary Tables
CREATE TEMPORARY TABLE temp_table
(frist_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES('Alex','Ferberg','Lord Of The Rings: The Tow Towers');

SELECT *
FROM employee_salary;

CREATE TEMPORARY TABLE salry_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

SELECT *
FROM salry_over_50k;

















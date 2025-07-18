--SQL CASE & CTE – School Management System
--Context:
--You’re working with a school's student performance database. You have access to a table that records student test scores.

CREATE DATABASE School_Management_System;
USE School_Management_System;

--Table: StudentScores
--StudentID	StudentName	Subject	Marks
--1	        'Alice',	    'Math',    78
--2	        'Bob',	        'Science', 45
--3	        'Charlie',	    'Math',	   88
--4	        'Diana',	    'English', 92
--5	        'Bob',	        'English', 53
--6	        'Alice',	    'Science', 40
--7	        'Charlie',	    'Science', 76
--8     	'Diana',	    'Math',    85
--9	        'Bob',	        'Math',    60


CREATE TABLE StudentScores
(
StudentID INT PRIMARY KEY IDENTITY(1,1), 
StudentName VARCHAR(50),
Subject VARCHAR(50),
Marks DECIMAL(10,2)
);

INSERT INTO StudentScores (StudentName, Subject, Marks)
VALUES
('Robert',      'Math',    39),
('Alice',	    'Math',    78),
('Bob',	        'Science', 45),
('Charlie',	    'Math',	   88),
('Diana',	    'English', 92),
('Bob',	        'English', 53),
('Alice',	    'Science', 40),
('Charlie',	    'Science', 76),
('Diana',	    'Math',    85),
('Bob',	        'Math',    60);
							 
SELECT * FROM StudentScores;

-- Assignment Questions (Simple Level)
--?? CASE Statement Questions
--1. Categorize Student Performance
--Add a column ResultCategory:

--'Distinction' if Marks ? 75

--'Pass' if Marks between 40 and 74

--'Fail' if Marks < 40

SELECT StudentName, Subject, Marks,
CASE 
	WHEN Marks >= 75 THEN 'Distinction'
	WHEN Marks between 40 and 74 THEN 'Pass'
	ELSE 'Fail'
END AS ResultCategory
FROM StudentScores;

--Expected Columns: StudentName, Subject, Marks, ResultCategory

--2. Add Grade Letter Based on Marks
--Using CASE, assign grades:

--A for Marks ? 85

--B for 70–84

--C for 55–69

--D for 40–54

--F for < 40

SELECT  StudentName, Subject, Marks, 
CASE
	WHEN Marks >= 85 THEN 'A'
	WHEN Marks between 70 and 84 THEN 'B'
	WHEN Marks between 55 and 69 THEN 'C'
	WHEN Marks between 40 and 54 THEN 'D'
	ELSE 'F'
END	AS Grade
FROM StudentScores;

-- Expected Columns: StudentName, Subject, Marks, Grade

--3. Filter Only "Pass" or "Distinction" Using CASE in WHERE
--Return only students with ResultCategory of 'Pass' or 'Distinction'.

WITH CTE_ResultCategory AS (
SELECT StudentName, Subject, Marks,
CASE 
	WHEN Marks >= 75 THEN 'Distinction'
	WHEN Marks between 40 and 74 THEN 'Pass'
	ELSE 'Fail'
END AS ResultCategory
FROM StudentScores
)
SELECT StudentName, Subject, Marks, ResultCategory FROM CTE_ResultCategory WHERE ResultCategory IN ('Pass', 'Distinction');

--?? CTE Questions
--4. CTE to Find Subject-Wise Average
--Create a CTE named SubjectAverage that calculates average marks per subject. Then, list only subjects where the average is ? 70.

SELECT AVG(Marks) FROM StudentScores GROUP BY Subject;

WITH SubjectAverage AS (
SELECT Subject, AVG(Marks) AS AverageMarks FROM StudentScores GROUP BY Subject
)
SELECT Subject, AverageMarks FROM SubjectAverage WHERE AverageMarks > 70;

-- Expected Columns: Subject, AverageMarks

--5. CTE for Student’s Total Marks
--Create a CTE to compute total marks scored by each student across all subjects. Then, fetch only students with total marks > 150.

SELECT StudentName, SUM(Marks) TotalMarks FROM StudentScores GROUP BY StudentName

WITH CTESTM AS (
SELECT StudentName, SUM(Marks) TotalMarks FROM StudentScores GROUP BY StudentName
) 
SELECT StudentName, TotalMarks FROM CTESTM WHERE TotalMarks > 150;

-- Expected Columns: StudentName, TotalMarks

--6. Combine CASE and CTE
--Create a CTE to calculate total marks per student. Then use a CASE to classify students:

--'Topper' if TotalMarks > 170

--'Average' if between 120 and 170

--'Needs Improvement' if < 120

WITH CTESTM AS (
SELECT StudentName, SUM(Marks) TotalMarks FROM StudentScores GROUP BY StudentName
) 
SELECT StudentName, TotalMarks,
CASE
	WHEN TotalMarks > 170 THEN 'Topper'
	WHEN TotalMarks between 120 and 170THEN 'Average'
	WHEN TotalMarks < 120 THEN 'Needs Improvement'
END AS Category
FROM CTESTM;

--Expected Columns: StudentName, TotalMarks, Category
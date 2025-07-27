--Assignment: SQL Views – University Student Management System

--Context:
CREATE DATABASE  University_Student_Management_System;
USE University_Student_Management_System;
--You are working with a university database that contains the following tables:

---- Students Table

--Students(StudentID, Name, Department, DOB, Gender)

 CREATE TABLE Students
 (
 StudentID INT PRIMARY KEY IDENTITY(1,1),
 Name VARCHAR(50),
 Department VARCHAR(100),
 DOB DATE,
 Gender VARCHAR(10),
 CONSTRAINT chk_gender CHECK(Gender IN ('Male', 'Female', 'Others'))
 );

 SELECT * FROM Students;

---- Marks Table

--Marks(MarkID, StudentID, Subject, Score)

 CREATE TABLE Marks
 (
 MarkID INT PRIMARY KEY IDENTITY(1,1),
 StudentID INT REFERENCES Students(StudentID),
 Subject VARCHAR(50),
 Score DECIMAL(10,2)
 );

 SELECT * FROM Marks;

---- Attendance Table

--Attendance(AttendanceID, StudentID, Date, Status)

CREATE TABLE Attendance
(
AttendanceID INT PRIMARY KEY IDENTITY(1,1),
StudentID INT REFERENCES Students(StudentID),
Date DATE,
Status VARCHAR(10),
CONSTRAINT chk_status CHECK (Status IN ('Present','Absent'))
);

--Assignment Questions by Subtopic

 

--1. Creating a View: CREATE VIEW

--Q1.1: Create a view named StudentSummary that shows the StudentID, Name, and Department of all students.

CREATE VIEW StudentSummary AS
SELECT StudentID AS StudID, Name AS Stud_name,  Department AS Stud_dept FROM Students;

SELECT * FROM StudentSummary;

--Q1.2: Create a view named HighScorers that shows students who scored more than 80 in any subject.

SELECT * FROM Students S INNER JOIN Marks M ON S.StudentID = M.StudentID WHERE Score > 80;

CREATE VIEW HighScorers AS
SELECT S.StudentID AS Stud_ID, S.Name AS Stud_name, M.Subject AS Stud_Subject, M.Score AS Stud_Score FROM Students S INNER JOIN Marks M ON S.StudentID = M.StudentID WHERE Score > 80;

SELECT * FROM HighScorers;

--2. Updating a View: CREATE OR REPLACE, ALTER VIEW

--Q2.1: Update the HighScorers view to also include the subject name.

ALTER VIEW HighScorers AS
SELECT S.StudentID AS Stud_ID, S.Name AS Stud_name, M.Subject AS Stud_Subject, M.Score AS Stud_Score FROM Students S INNER JOIN Marks M ON S.StudentID = M.StudentID WHERE Score > 80;

SELECT * FROM HighScorers;

CREATE OR ALTER VIEW HighScorers AS
SELECT S.StudentID AS Stud_ID, S.Name AS Stud_name, M.Subject AS Stud_Subject, M.Score AS Stud_Score FROM Students S INNER JOIN Marks M ON S.StudentID = M.StudentID WHERE Score > 80;


--Q2.2: Rename the view HighScorers to TopPerformers.

EXEC sp_rename HighScorers, TopPerformers;

--3. Using Views for Abstraction & Security

--Q3.1: Create a view DepartmentWiseStudentCount that shows the number of students in each department.

CREATE VIEW DepartmentWiseStudentCount AS
SELECT COUNT(StudentID) AS Student_count, Department FROM Students GROUP BY Department;

SELECT * FROM DepartmentWiseStudentCount;

--Q3.2: Create a view AttendanceView that only shows the StudentID, Name, and number of days present.

--(Hint: Count records where Status = 'Present')

CREATE VIEW AttendanceView AS
SELECT S.StudentID, S.Name, COUNT(A.StudentID) AS number_of_days_present FROM Attendance A INNER JOIN Students S ON A.StudentID = S.StudentID WHERE A.Status = 'Present' GROUP BY S.Name, S.StudentID;

SELECT * FROM AttendanceView;

--4. Read-only vs Updatable Views

--Q4.1: Create an updatable view named StudentNamesOnly that shows StudentID and Name from the Students table.
--Try inserting a new record into this view and check if it works.

CREATE VIEW StudentNamesOnly AS
SELECT StudentID, Name FROM Students;

SELECT * FROM StudentNamesOnly;

INSERT INTO StudentNamesOnly (Name) VALUES('Student_101')

--Q4.2: Create a read-only view AverageScorePerStudent that displays each student’s name and their average score.
--(Hint: Use GROUP BY in view definition)

CREATE VIEW AverageScorePerStudent  WITH SCHEMABINDING AS
SELECT S.StudentID, S.Name, AVG(M.Score) AS AVG_Marks FROM dbo.Students S JOIN dbo.Marks M ON S.StudentID = M.StudentID GROUP BY S.StudentID, S.Name;

SELECT * FROM AverageScorePerStudent;

--5. Dropping Views

--Q5.1: Drop the view TopPerformers only if it exists in the database.

DROP VIEW IF EXISTS TopPerformers

--6. Performance Implications of Views

--Q6.1: Create a view FullStudentProfile that joins all three tables (Students, Marks, and Attendance) to show the full academic and attendance record of each student

CREATE VIEW FullStudentProfile AS
SELECT S.StudentID, S.Name, S.Department, M.Subject, A.Date, A.Status, M.Score
FROM Students S INNER JOIN Marks M ON S.StudentID = M.StudentID INNER JOIN Attendance A ON S.StudentID = A.StudentID;

SELECT * FROM FullStudentProfile ORDER BY Name ASC, Status ASC;
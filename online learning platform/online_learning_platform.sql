--SQL Assignment: Subqueries in an Online Learning Platform

--Context:

--You are working on the backend database of an online learning platform. The platform supports students, instructors, courses, enrollments, and reviews.

CREATE DATABASE online_learning_platform;
USE online_learning_platform;

--Database Tables

--Students
--Column     Description
--student_id Unique student ID
--name       Full name
--city       Student’s city

CREATE TABLE Students
(
student_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(50),
city VARCHAR(100)
);

--Instructors
--Column        Description
--instructor_id Unique instructor ID
--name          Instructor name
--expertise     Area of specialization

CREATE TABLE Instructors
(
instructor_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(50),
expertise VARCHAR(100)
);

--Courses
--Column        Description
--course_id     Unique course ID
--title         Course title
--instructor_id Foreign key to Instructors
--price         Course fee

CREATE TABLE Courses
(
course_id INT PRIMARY KEY IDENTITY(1,1),
title VARCHAR(100),
instructor_id INT REFERENCES Instructors(instructor_id),
price DECIMAL(10,2)
);

--Enrollments
--Column          Description
--enrollment_id   Unique enrollment ID
--course_id       Foreign key to Courses
--student_id      Foreign key to Students
--enrollment_date Date of enrollment

CREATE TABLE Enrollments
(
enrollment_id INT PRIMARY KEY IDENTITY(1,1),
course_id INT REFERENCES Courses(course_id),
student_id INT REFERENCES Students(student_id),
enrollment_date DATETIME
);

--Reviews
--Column     Description
--review_id  Unique review ID
--student_id Foreign key to Students
--course_id  Foreign key to Courses
--rating     Rating (1–5)
--comment    Review text

CREATE TABLE Reviews
(
review_id INT PRIMARY KEY IDENTITY(1,1),
student_id INT REFERENCES Students(student_id),
course_id INT REFERENCES Courses(course_id),
rating INT CHECK (rating IN (1, 2, 3, 4, 5)),
comment VARCHAR(500)
);

SELECT * FROM Students;
SELECT * FROM Instructors;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Reviews;

--Assignment Problems by Subquery Type

--🔹 Scalar Subqueries (Single Value)

--Display the name of the course with the highest price.

SELECT * FROM Courses WHERE price = (SELECT MAX(price) FROM Courses);

--Find the average course price, then list all courses priced above that value.

SELECT AVG(price) FROM Courses;
SELECT * FROM Courses WHERE price > (SELECT AVG(price) FROM Courses);

--Show the name of the student who has given the highest-rated review.

SELECT * FROM Students WHERE student_id IN (SELECT student_id FROM Reviews WHERE rating = 4);

--🔹 Table Subqueries (IN, EXISTS)

--List all students who are enrolled in at least one course (use EXISTS).

SELECT * FROM Students WHERE EXISTS (SELECT student_id FROM Enrollments);

--Find the instructors who are teaching more than one course (use IN or EXISTS in a subquery).

SELECT * FROM Instructors WHERE EXISTS (SELECT instructor_id total FROM Courses GROUP BY instructor_id HAVING COUNT(course_id) > 1);

--List all students who have not written any reviews (using NOT IN or NOT EXISTS).

SELECT * FROM Students WHERE student_id NOT IN (SELECT student_id FROM Reviews);

--🔹 Subqueries in SELECT, WHERE, and FROM

--List all courses along with their average rating using a subquery in the SELECT clause.

SELECT course_id, title, price, (SELECT AVG(R.rating) FROM Reviews R WHERE R.course_id = C.course_id) AS AVG_Rating FROM Courses C;

--Display the students who enrolled in courses priced higher than ₹2,000 (use subquery in WHERE). making it 1000

SELECT * FROM Students WHERE student_id IN 
(
SELECT student_id FROM Enrollments WHERE course_id IN
(
SELECT course_id FROM Courses WHERE price > 1000
)
);

--Show a list of course titles and total enrollments using a subquery in the FROM clause.

SELECT C.title, ISNULL(E.total_enrollments,0) total_enrollments FROM Courses C 
LEFT JOIN (SELECT course_id, COUNT(*) AS total_enrollments FROM Enrollments GROUP BY course_id) AS E ON C.course_id = E.course_id;

--🔹 Nested Subqueries

--Get the names of students who enrolled in the top 3 most expensive courses.

SELECT * FROM Students WHERE student_id IN 
(
SELECT student_id FROM Enrollments WHERE course_id IN
(
SELECT TOP 3 course_id FROM Courses ORDER BY price DESC
)
);

--Show all instructors who taught courses with ratings above the platform’s average rating.

 
SELECT * FROM Instructors WHERE instructor_id IN (SELECT instructor_id FROM Courses WHERE course_id IN (SELECT course_id FROM Reviews));

SELECT * FROM Instructors 
WHERE instructor_id IN (SELECT instructor_id FROM Courses WHERE course_id IN (SELECT course_id FROM Reviews WHERE rating > (SELECT AVG(rating) FROM Reviews)));

SELECT * FROM Reviews WHERE rating > (SELECT AVG(rating) FROM Reviews);

--🔹 Correlated Subqueries

--Find students who have enrolled in more than 1 course.

SELECT * FROM Students S WHERE (SELECT COUNT(*) FROM Enrollments E WHERE E.student_id = S.student_id) > 1;

--Display courses that have an above-average rating compared to other courses taught by the same instructor.


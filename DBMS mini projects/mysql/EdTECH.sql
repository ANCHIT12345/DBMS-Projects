-- DROP DATABASE IF EXISTS `edtech`;
-- CREATE DATABASE `edtech`;
-- USE `edtech`;
USE `students_/_books`;

CREATE TABLE Users
(
User_ID INT PRIMARY KEY AUTO_INCREMENT,
User_Name VARCHAR (50) NOT NULL,
Email VARCHAR(641) UNIQUE NOT NULL,
Password  VARCHAR(100) NOT NULL,
Role ENUM ('Student', 'Instructor', 'Admin') DEFAULT 'Student',
Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE Users;
SELECT * FROM Users;

INSERT INTO Users (User_Name, Email, Password, Role) 
VALUES ('Allison Hill', 'jillrhodes@miller.com', 'T$dJL8Ti+a83', 'Student'),
('Andrew Stevens', 'smiller@montgomery.com', 'ypjGLn0E!dY3', 'Admin'),
('Joel Nelson', 'megan03@trujillo.com', 'Ba3SL76w@VsH', 'Student'),
('Anthony Rodriguez', 'ycarlson@carlson-mcdonald.com', '(0hix9+!(fVi', 'Instructor'),
('Katie Gonzalez', 'amberosborne@hotmail.com', '@u9nA%qp!NKi', 'Student'),
('Joseph Obrien', 'jenniferross@santos.com', '@SC!e%%#$38k', 'Student'),
('Dana Kennedy', 'clintonhopkins@yahoo.com', 'O6Z%fl(x&_1M', 'Student'),
('Kimberly Smith', 'gabrieltucker@hancock.com', '&k9dgiaO20%M', 'Student'),
('Thomas Schmidt', 'yorkcasey@leonard.biz', '@9JVQH3s5HbA', 'Student'),
('Kristine Garcia', 'david51@wood.info', 'a!m(bz)(*S4T', 'Instructor'),
('Deborah Freeman', 'waltersmaria@smith.com', '#!^RswnV_)7s', 'Instructor'),
('Brian Deleon', 'sarayoung@gmail.com', 'gCu#6A7f*qp4', 'Instructor'),
('Matthew Ross', 'rasmussenjoshua@hotmail.com', 'C(q6UyVWDrKy', 'Student'),
('Michael Smith', 'ryan59@alvarado-martinez.com', 'CdTVbGn0U(4A', 'Student'),
('Jeremy Lowe', 'donnacampbell@hotmail.com', 'mhb92@Kco^I_', 'Admin'),
('Charles Watts', 'zrobinson@holmes.com', 'bzW2ZXfonS*h', 'Student'),
('Richard Washington', 'scott43@rogers-orozco.com', '#e%ISIHms2dp', 'Student'),
('Elizabeth Price', 'tracynelson@yahoo.com', '!H6MKY@vT#Z_', 'Student'),
('Daniel Murphy', 'karen64@gmail.com', '$*40w##roX5N', 'Instructor'),
('Pamela Jackson', 'tamirodriguez@hickman.biz', '3Y*jos(y&DCF', 'Instructor'),
('Samantha Garcia', 'bzimmerman@gmail.com', 'XujMnUi6v+8h', 'Student'),
('Samuel White', 'lauren54@haynes.com', 'OidZOXn4@AV3', 'Student'),
('Heather Chavez', 'jerry35@gmail.com', '84YfwQ8*+41@', 'Student'),
('Kristen Terry', 'agarcia@mitchell.com', 'H^Y7+TDc%iWk', 'Student'),
('Elizabeth Chapman', 'ashley09@hotmail.com', '7@5UgIdM#93p', 'Admin'),
('Lori Guerrero', 'owilson@hernandez.com', '#xKMTH8RK4rg', 'Instructor'),
('Michael Valencia', 'barbara27@pearson.org', 'D7bpCCpv&SLB', 'Instructor'),
('April Booth', 'hbrown@yahoo.com', 'i7SUKdoy)5+S', 'Admin'),
('Susan Murray MD', 'scantu@thornton.info', 'GuPrR8kev$78', 'Student'),
('Jill Washington', 'ugibson@gmail.com', '5m$heSGb+3O#', 'Student'),
('Jessica Fox', 'bowenrobert@hotmail.com', '#zdPpppGB1iq', 'Student'),
('Tammie Bright', 'wgood@padilla.com', '%E0KIc1zX!cO', 'Instructor'),
('Julia Estrada', 'erica21@yahoo.com', '^dLAJpuGE99@', 'Student'),
('Melissa Garner', 'swall@lawson.com', 'cfao3TiAKUg_', 'Instructor'),
('Carlos Ryan', 'maria47@yahoo.com', 'M+h4cZHdT&57', 'Student'),
('Deborah James', 'leonardthomas@hotmail.com', 'ZZMda5Thz((R', 'Instructor'),
('Melissa Fernandez', 'fpena@russell.com', '$*cSyhH2)7Ob', 'Student'),
('Cameron Cunningham', 'brendali@murphy.org', 'R!(q)Eke@7)4', 'Student'),
('Ashley Gordon', 'stephen00@boone-simmons.com', 'B7)YVeGW*PCc', 'Admin'),
('Jessica Beasley', 'maria66@hotmail.com', 'b5+u%k&*@mNV', 'Admin'),
('Shane Pugh', 'schmittcaroline@yahoo.com', '9NoDT(84@gQY', 'Admin'),
('Sandra Adams', 'jacqueline45@smith-kane.org', '_xCRFL+BC6er', 'Instructor'),
('Jeremy Coleman', 'wnelson@hotmail.com', '@5Ob$NWdA3_6', 'Student'),
('Casey James', 'charles06@stevens.com', 'em(@ClSn)6o6', 'Instructor'),
('Eric Morgan', 'charlesschultz@hotmail.com', 'DwZ_*Y0li(3Y', 'Instructor'),
('Lori Hernandez', 'tramos@vargas-bell.com', '%n^OpbPMT%7L', 'Instructor'),
('Kathryn Rosario', 'shepherdmary@hotmail.com', '#8zQXftG@cUY', 'Student'),
('David York', 'christopher25@ponce-hale.biz', 'AF#9WcgcQZJE', 'Admin'),
('Ralph Lee', 'chrisrichard@romero.net', ')F0!Yl0tIc55', 'Instructor'),
('Emily Stokes', 'michealvalentine@yahoo.com', 'P*42Yq$mFveQ', 'Student'),
('Brittany Kim', 'bwilkerson@brown-shaw.com', '&1oLh_9nd_eL', 'Student'),
('Kimberly Acosta', 'parsonsjohn@gmail.com', 'k!3sW@u5_JN5', 'Admin'),
('Heather Ashley', 'cmarks@hughes.com', 'a@5h)EDxncyH', 'Admin'),
('Dakota Moody', 'sarah86@kennedy.com', '8^KHKwU1dkk0', 'Instructor'),
('Catherine Carter MD', 'kirk96@gmail.com', '+qLz8yw^Z7oc', 'Student'),
('Amanda Jones', 'patrick90@hotmail.com', 'K^_#L8xl1Qt7', 'Student'),
('Donna Hendricks DDS', 'melissahayes@wallace.com', '_9A+eW0c5yk5', 'Student'),
('Julie Bird', 'jonesraymond@higgins.org', '^M2)KuVi@Pqn', 'Student'),
('Courtney Meza', 'kingcynthia@hotmail.com', '%2ZVU0YsCjUp', 'Student'),
('Daniel Armstrong', 'ismall@may-turner.com', '^6KJ3oBf_py)', 'Student'),
('Derek Wright', 'robertspatrick@barnes.com', '+zMrG&Hy5)58', 'Instructor'),
('Sarah Jordan', 'kathryn50@yahoo.com', 'E99RSgYX!*Fz', 'Instructor'),
('Jennifer Williams', 'jenniferbrock@bryant.com', 'zgACmReAm)5F', 'Instructor'),
('John Coffey', 'silvageorge@griffith.com', '2KII3WXd!f9Q', 'Student'),
('Emily Thompson', 'erica49@yahoo.com', 'AvyjedrN$3I9', 'Student'),
('Jennifer Reed', 'bobby15@douglas-burgess.com', '$_IV5brZ8If*', 'Student'),
('Shirley Alvarez', 'manuel01@andrews.com', 'zHFvxuqb#*69', 'Student'),
('Julie Lee', 'francisco74@lopez.org', 'psnQFt1_B_73', 'Student'),
('Deborah Ward', 'contrerassteven@sullivan.com', 'FjwULzFdt+1n', 'Student'),
('Kelsey Cox', 'poolerebecca@armstrong.com', '^fOsO%dITTb8', 'Student');



CREATE TABLE Courses
(
Course_ID INT PRIMARY KEY AUTO_INCREMENT,
Course_Name VARCHAR(100) NOT NULL,
Description TEXT,
Instructor_ID INT,
Start_Date DATE,
End_Date DATE,
FOREIGN KEY (Instructor_ID) REFERENCES Users(User_ID)
);

DROP TABLE Courses;
SELECT * FROM Courses;

INSERT INTO Courses (Course_Name, Description, Instructor_ID, Start_Date, End_Date) VALUES
('Python', 'Learn Python fundamentals fast.', 41, '2023-01-01', '2023-03-01'),
('Java', 'Object-oriented Java basics.', 42, '2023-02-01', '2023-04-01'),
('SQL', 'Master basic SQL queries.', 43, '2023-03-01', '2023-05-01'),
('HTML', 'Build static websites quickly.', 44, '2023-04-01', '2023-06-01'),
('CSS', 'Styling web pages effectively.', 45, '2023-05-01', '2023-07-01'),
('JavaScript', 'Learn JS from scratch.', 46, '2023-06-01', '2023-08-01'),
('React', 'Frontend with React.js.', 47, '2023-07-01', '2023-09-01'),
('Node.js', 'Backend fundamentals.', 48, '2023-08-01', '2023-10-01'),
('Django', 'Python web framework intro.', 49, '2023-09-01', '2023-11-01'),
('Flask', 'Lightweight backend dev.', 50, '2023-10-01', '2023-12-01'),
('C++', 'Strongly typed language intro.', 51, '2023-01-01', '2023-03-01'),
('Git', 'Version control with Git.', 52, '2023-02-01', '2023-04-01'),
('Linux', 'Using the Linux terminal.', 53, '2023-03-01', '2023-05-01'),
('PHP', 'Scripting for web development.', 54, '2023-04-01', '2023-06-01'),
('MySQL', 'Database system basics.', 55, '2023-05-01', '2023-07-01'),
('Kotlin', 'Modern Android programming.', 56, '2023-06-01', '2023-08-01'),
('Swift', 'iOS app development.', 57, '2023-07-01', '2023-09-01'),
('TypeScript', 'Typed superset of JS.', 58, '2023-08-01', '2023-10-01'),
('Ruby', 'Quick-start Ruby language.', 59, '2023-09-01', '2023-11-01'),
('Bash', 'Shell scripting in Linux.', 60, '2023-10-01', '2023-12-01');

INSERT INTO Courses (Course_Name, Description, Instructor_ID, Start_Date, End_Date) VALUES
('AI', 'Intro to artificial intelligence.', 41, '2024-01-10', '2024-03-10'),
('ML', 'Machine learning essentials.', 42, '2024-02-15', '2024-04-15'),
('DataSci', 'Fundamentals of data science.', 43, '2024-03-20', '2024-05-20'),
('Cloud', 'Cloud computing basics.', 44, '2024-04-25', '2024-06-25'),
('DevOps', 'CI/CD pipeline practices.', 45, '2024-05-30', '2024-07-30'),
('CyberSec', 'Cybersecurity principles.', 46, '2024-07-05', '2024-09-05'),
('UX', 'User experience design.', 47, '2024-08-10', '2024-10-10'),
('Blockchain', 'Understanding blockchain.', 48, '2024-09-15', '2024-11-15'),
('IoT', 'Internet of Things intro.', 49, '2024-10-20', '2025-01-20'),
('VR', 'Virtual reality development.', 50, '2024-11-25', '2025-02-25'),
('Python', 'Advanced Python programming.', 51, '2025-01-05', '2025-03-05'),
('JavaScript', 'Full-stack JavaScript.', 52, '2025-02-10', '2025-04-10'),
('SQL', 'Advanced SQL techniques.', 53, '2025-03-15', '2025-05-15'),
('Kubernetes', 'Container orchestration.', 54, '2025-04-20', '2025-06-20'),
('React', 'React.js deep dive.', 55, '2025-05-25', '2025-07-25'),
('Angular', 'Building with Angular.', 56, '2025-06-30', '2025-08-30'),
('Node.js', 'Node.js backend systems.', 57, '2025-08-04', '2025-10-04'),
('DevSecOps', 'Secure DevOps workflows.', 58, '2025-09-08', '2025-11-08'),
('Scala', 'Functional programming Scala.', 59, '2025-10-12', '2026-01-12'),
('Go', 'Systems programming with Go.', 60, '2025-11-16', '2026-02-16');


CREATE TABLE Enrollments 
(
Enrollment_ID INT PRIMARY KEY AUTO_INCREMENT,
User_ID INT,
Course_ID INT,
Enrolled_On DATE,
Last_Access_Date DATE,
Progress DECIMAL(5,2) DEFAULT 0.00,
Status ENUM('Enrolled', 'Completed', 'Dropped') DEFAULT 'Enrolled',
FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);

ALTER TABLE Enrollments
MODIFY COLUMN Status ENUM('Enrolled', 'Completed', 'Dropped', 'Not Enrolled') DEFAULT 'Not Enrolled';

DROP TABLE Enrollments;
SELECT * FROM Enrollments;

INSERT INTO Enrollments (User_ID, Course_ID, Enrolled_On, Last_Access_Date, Progress, Status) VALUES
(1, 1, '2023-01-10', '2023-02-15', 10.5, 'Enrolled'),
(2, 2, '2023-02-10', '2023-03-15', 20.1, 'Completed'),
(3, 3, '2023-03-10', '2023-04-15', 30.9, 'Dropped'),
(4, 4, '2023-04-10', '2023-05-15', 40.2, 'Enrolled'),
(5, 5, '2023-05-10', '2023-06-15', 50.7, 'Completed'),
(6, 6, '2023-06-10', '2023-07-15', 60.3, 'Dropped'),
(7, 7, '2023-07-10', '2023-08-15', 70.0, 'Enrolled'),
(8, 8, '2023-08-10', '2023-09-15', 80.1, 'Completed'),
(9, 9, '2023-09-10', '2023-10-15', 90.2, 'Dropped'),
(10, 10, '2023-10-10', '2023-11-15', 100.0, 'Enrolled'),
(11, 11, '2023-01-10', '2023-02-15', 15.3, 'Completed'),
(12, 12, '2023-02-10', '2023-03-15', 28.4, 'Enrolled'),
(13, 13, '2023-03-10', '2023-04-15', 63.5, 'Dropped'),
(14, 14, '2023-04-10', '2023-05-15', 92.2, 'Completed'),
(15, 15, '2023-05-10', '2023-06-15', 35.6, 'Enrolled'),
(16, 16, '2023-06-10', '2023-07-15', 67.7, 'Completed'),
(17, 17, '2023-07-10', '2023-08-15', 23.4, 'Dropped'),
(18, 18, '2023-08-10', '2023-09-15', 89.1, 'Enrolled'),
(19, 19, '2023-09-10', '2023-10-15', 74.3, 'Completed'),
(20, 20, '2023-10-10', '2023-11-15', 42.8, 'Dropped'),
(21, 1, '2023-01-10', '2023-02-15', 11.5, 'Enrolled'),
(22, 2, '2023-02-10', '2023-03-15', 21.1, 'Completed'),
(23, 3, '2023-03-10', '2023-04-15', 31.9, 'Dropped'),
(24, 4, '2023-04-10', '2023-05-15', 41.2, 'Enrolled'),
(25, 5, '2023-05-10', '2023-06-15', 51.7, 'Completed'),
(26, 6, '2023-06-10', '2023-07-15', 61.3, 'Dropped'),
(27, 7, '2023-07-10', '2023-08-15', 71.0, 'Enrolled'),
(28, 8, '2023-08-10', '2023-09-15', 81.1, 'Completed'),
(29, 9, '2023-09-10', '2023-10-15', 91.2, 'Dropped'),
(30, 10, '2023-10-10', '2023-11-15', 99.9, 'Enrolled'),
(31, 11, '2023-01-10', '2023-02-15', 13.5, 'Completed'),
(32, 12, '2023-02-10', '2023-03-15', 29.4, 'Enrolled'),
(33, 13, '2023-03-10', '2023-04-15', 65.5, 'Dropped'),
(34, 14, '2023-04-10', '2023-05-15', 90.2, 'Completed'),
(35, 15, '2023-05-10', '2023-06-15', 36.6, 'Enrolled'),
(36, 16, '2023-06-10', '2023-07-15', 68.7, 'Completed'),
(37, 17, '2023-07-10', '2023-08-15', 22.4, 'Dropped'),
(38, 18, '2023-08-10', '2023-09-15', 86.1, 'Enrolled'),
(39, 19, '2023-09-10', '2023-10-15', 76.3, 'Completed'),
(40, 20, '2023-10-10', '2023-11-15', 49.8, 'Dropped'),
(1, 11, '2023-01-10', '2023-02-15', 33.2, 'Enrolled'),
(2, 12, '2023-02-10', '2023-03-15', 25.6, 'Completed'),
(3, 13, '2023-03-10', '2023-04-15', 78.4, 'Dropped'),
(4, 14, '2023-04-10', '2023-05-15', 88.1, 'Completed'),
(5, 15, '2023-05-10', '2023-06-15', 58.5, 'Enrolled'),
(6, 16, '2023-06-10', '2023-07-15', 40.0, 'Completed'),
(7, 17, '2023-07-10', '2023-08-15', 11.1, 'Dropped'),
(8, 18, '2023-08-10', '2023-09-15', 36.6, 'Enrolled'),
(9, 19, '2023-09-10', '2023-10-15', 79.5, 'Completed'),
(10, 20, '2023-10-10', '2023-11-15', 66.2, 'Dropped');

INSERT INTO Enrollments (User_ID, Course_ID, Enrolled_On, Last_Access_Date, Progress, Status) VALUES
(1, 1, '2024-01-12', '2024-02-20', 15.0, 'Enrolled'),
(2, 2, '2024-02-17', '2024-04-10', 100.0, 'Completed'),
(3, 3, '2024-03-22', '2024-05-18', 67.5, 'Enrolled'),
(4, 4, '2024-04-28', '2024-06-25', 82.3, 'Completed'),
(5, 5, '2024-05-31', '2024-07-20', 45.0, 'Dropped'),
(6, 6, '2024-07-08', '2024-09-02', 90.0, 'Completed'),
(7, 7, '2024-08-13', '2024-10-05', 27.0, 'Enrolled'),
(8, 8, '2024-09-17', '2024-11-10', 56.7, 'Completed'),
(9, 9, '2024-10-21', '2025-01-15', 34.5, 'Enrolled'),
(10, 10, '2024-11-26', '2025-02-10', 66.2, 'Enrolled'),
(11, 11, '2025-01-07', '2025-03-08', 23.4, 'Enrolled'),
(12, 12, '2025-02-12', '2025-04-10', 78.9, 'Enrolled'),
(13, 13, '2025-03-17', '2025-05-15', 100.0, 'Completed'),
(14, 14, '2025-04-22', '2025-06-20', 12.8, 'Enrolled'),
(15, 15, '2025-05-27', '2025-07-25', 50.5, 'Enrolled'),
(16, 16, '2025-07-02', '2025-08-30', 88.8, 'Completed'),
(17, 17, '2025-08-06', '2025-10-01', 37.2, 'Enrolled'),
(18, 18, '2025-09-10', '2025-11-07', 72.4, 'Enrolled'),
(19, 19, '2025-10-14', '2026-01-10', 41.1, 'Enrolled'),
(20, 20, '2025-11-18', '2026-02-14', 59.3, 'Enrolled'),
(21, 1, '2024-01-15', '2024-03-01', 25.7, 'Completed'),
(22, 2, '2024-02-19', '2024-04-12', 35.9, 'Dropped'),
(23, 3, '2024-03-24', '2024-05-20', 47.3, 'Enrolled'),
(24, 4, '2024-05-01', '2024-06-27', 78.4, 'Completed'),
(25, 5, '2024-06-03', '2024-07-22', 60.0, 'Enrolled'),
(26, 6, '2024-07-12', '2024-09-04', 82.1, 'Dropped'),
(27, 7, '2024-08-17', '2024-10-07', 29.6, 'Enrolled'),
(28, 8, '2024-09-21', '2024-11-12', 55.5, 'Enrolled'),
(29, 9, '2024-10-25', '2025-01-18', 49.8, 'Enrolled'),
(30, 10, '2024-11-29', '2025-02-12', 68.9, 'Completed'),
(31, 11, '2025-01-10', '2025-03-10', 90.1, 'Completed'),
(32, 12, '2025-02-14', '2025-04-12', 20.4, 'Enrolled'),
(33, 13, '2025-03-19', '2025-05-17', 33.7, 'Enrolled'),
(34, 14, '2025-04-24', '2025-06-22', 57.2, 'Completed'),
(35, 15, '2025-06-01', '2025-07-28', 14.9, 'Dropped'),
(36, 16, '2025-07-06', '2025-10-03', 75.5, 'Completed'),
(37, 17, '2025-08-11', '2025-10-08', 18.6, 'Enrolled'),
(38, 18, '2025-09-15', '2025-11-13', 66.3, 'Enrolled'),
(39, 19, '2025-10-19', '2026-01-14', 39.7, 'Enrolled'),
(40, 20, '2025-11-23', '2026-02-20', 80.0, 'Enrolled'),
(1, 11, '2025-01-09', '2025-03-07', 45.8, 'Enrolled'),
(2, 12, '2025-02-13', '2025-04-11', 56.4, 'Enrolled'),
(3, 13, '2025-03-18', '2025-05-16', 67.9, 'Completed'),
(4, 14, '2025-04-23', '2025-06-21', 78.0, 'Enrolled'),
(5, 15, '2025-06-02', '2025-07-30', 88.2, 'Enrolled'),
(6, 16, '2025-07-07', '2025-08-31', 15.3, 'Dropped'),
(7, 17, '2025-08-12', '2025-10-09', 29.7, 'Enrolled'),
(8, 18, '2025-09-16', '2025-11-14', 38.4, 'Enrolled'),
(9, 19, '2025-10-20', '2026-01-15', 49.5, 'Enrolled'),
(10, 20, '2025-11-24', '2026-02-21', 60.9, 'Enrolled');

INSERT INTO Enrollments (User_ID, Course_ID, Enrolled_On, Last_Access_Date, Progress, Status) VALUES
(4, 1, NULL, NULL, 0.00, 'Not Enrolled'),
(6, 2, NULL, NULL, 0.00, 'Not Enrolled'),
(8, 3, NULL, NULL, 0.00, 'Not Enrolled'),
(12, 4, NULL, NULL, 0.00, 'Not Enrolled'),
(15, 5, NULL, NULL, 0.00, 'Not Enrolled'),
(18, 1, NULL, NULL, 0.00, 'Not Enrolled'),
(20, 2, NULL, NULL, 0.00, 'Not Enrolled');


-- SELECT * FROM ENROLLMENTS WHERE User_ID = 3;
-- SELECT * FROM Courses WHERE Course_ID = 3;

-- SELECT * FROM ENROLLMENTS WHERE Course_ID = 1;
-- SELECT * FROM Courses WHERE Course_ID = 1;
-- SELECT * FROM Courses WHERE Course_Name Like '%Python%';

-- SELECT * FROM Users WHERE Role LIKE 'Instructor';

-- SELECT * FROM Enrollments WHERE Course_ID = 1;

-- SELECT * FROM Enrollments WHERE Enrolled_On BETWEEN '2025-01-01' AND '2025-03-31';

-- SELECT * FROM Enrollments WHERE Course_ID = 23 OR Course_ID = 21 OR Course_ID = 4 OR Course_ID = 5 OR Course_ID = 6;

-- SELECT Course_ID, Course_Name, Description FROM Courses WHERE Course_Name LIKE 'DataSci' OR Course_Name LIKE 'AI' OR Course_Name LIKE 'Web Development';

SELECT * FROM Enrollments WHERE Status LIKE 'Not Enrolled';

SELECT * FROM Users WHERE ROLE = 'Instructor';

SELECT * FROM Enrollments WHERE Status = 'Not Enrolled';







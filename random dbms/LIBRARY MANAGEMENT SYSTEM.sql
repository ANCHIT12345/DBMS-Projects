DROP DATABASE IF EXISTS `Library_Management_System`;
CREATE DATABASE `Library_Management_System`;
USE `Library_Management_System`;
-- Mini Project: Library Management System (CRUD-Focused)
-- Objective:
-- Practice full lifecycle data handling (Create, Read, Update, Delete) using a realistic library database structure.
-- Tables to Use:
-- - Books (book_id, title, author, genre, price)
-- - Members (member_id, name, email, join_date, city)
-- - Issues (issue_id, book_id, member_id, issue_date, return_date, late_fee)

CREATE TABLE Books
(
book_id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(250) NOT NULL,
author VARCHAR(50) NOT NULL DEFAULT 'Not Defined',
genre VARCHAR(100) NOT NULL DEFAULT 'Not Defined',
price DECIMAL NOT NULL DEFAULT 0.0
);

DROP TABLE Books;

CREATE TABLE Members
(
member_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
email VARCHAR(645) NOT NULL UNIQUE,
CHECK (email LIKE '___%@___%.__%'),
join_date DATETIME NOT NULL,
city VARCHAR(60) DEFAULT NULL
);

ALTER TABLE Members
MODIFY COLUMN city VARCHAR(60) DEFAULT NULL;

DROP TABLE Members;

CREATE TABLE Issues
(
issue_id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT NOT NULL,
FOREIGN KEY (book_id) REFERENCES Books(book_id),
member_id INT NOT NULL,
FOREIGN KEY (member_id) REFERENCES Members(member_id),
issue_date DATETIME NOT NULL,
return_date DATETIME DEFAULT NULL,
late_fee DECIMAL(10,2) NOT NULL DEFAULT 0.0
);

ALTER TABLE Issues
MODIFY COLUMN return_date DATETIME DEFAULT NULL;

ALTER TABLE Issues
MODIFY COLUMN late_fee DECIMAL(10,2) NOT NULL DEFAULT 0.0;

DROP TABLE Issues;

-- ✅ Part 1: CREATE (Insert Records)
-- Task 1: Insert Operations
-- 1.	Insert a new book titled “Data Systems Simplified” into the Books table.
-- 2.	Add three new members from different cities in a single query.
-- 3.	Add five new book issue records for current and older dates into Issues.

INSERT INTO Books(title, author, genre, price)
VALUES 
('Book1', 'Author1', 'GENER1', 112.51),
('Book2', 'Author1', 'GENER1', 500.62),
('Book3', 'Author1', 'GENER1', 2214.00),
('Book4', 'Author1', 'GENER1', 210.38),
('Book5', 'Author1', 'GENER1', 140.38);

INSERT INTO Books(title, author, genre, price)
VALUES ('Data Science', 'Author2', 'random', 2223.01),
('Science', 'Author2', 'xyz data related', 0.0);

SELECT * FROM Books;

INSERT INTO Members(name, email, join_date, city)
VALUES 
('member1', 'xyz@gmail.com', '2024-02-09 02:21:22', 'Mumbai'),
('member2', 'random@example.com', '2024-03-23 13:22:58', DEFAULT),
('member3', 'foadoh@example.com', '2025-03-23 14:22:58', 'Kolkata'),
('member4', 'afpdsijf@werds.to', '2023-03-24 15:21:58', DEFAULT),
('member5', 'gakjhgkgopfj@newemail.com', '2025-03-24 15:22:58', 'Lucknow');

INSERT INTO Members(name, email, join_date, city)
VALUES ('member6','aflidgafilagzfhnskh@gmail.com','2025-06-01 00:00:00','Banglor');

SELECT * FROM Members;

INSERT INTO Issues (book_id, member_id, issue_date, return_date, late_fee)
VALUES
(1, 1, '2025-03-08 20:44:29', '2025-4-18 20:33:22', 53.28),
(2, 1, '2025-03-08 20:44:29' , '2025-4-18 20:33:22', 23.2),
(3, 2, '2024-09-02 22:43:29', '2024-11-03 15:33:21', 230.30),
(4, 3, '2025-03-23 14:29:56', '2025-4-18 22:33:22', DEFAULT),
(5, 4, '2024-02-19 15:22:33', '2024-03-19 12:22:42', DEFAULT),
(1, 5, '2024-09-02 22:43:29', '2024-10-19 12:22:42', 10.22);

INSERT INTO Issues (book_id, member_id, issue_date, return_date, late_fee)
VALUES
(5, 6, '2025-06-18', DEFAULT, DEFAULT);

SELECT * FROM Issues;

-- ✅ Part 2: READ (Retrieve Data)
-- Task 2: Query Operations
-- 4.	Fetch all books priced above ₹500.
-- 5.	Get the list of members who joined in the last 30 days.
-- 6.	Display all books currently issued to member “member1”.
-- 7.	List all overdue books (assume issue date + 30 days = due).
-- 8.	Get all books with 'Data' in the title or genre.

SELECT * FROM Books WHERE price > 500;

SELECT * FROM Members WHERE join_date BETWEEN '2025-05-22 00:00:00' AND NOW();

SELECT * FROM Issues WHERE member_id = 1;

SELECT DATEDIFF(return_date, issue_date) AS Diff, Issues.* FROM Issues WHERE  DATEDIFF(return_date, issue_date) > 30;
SELECT DATEDIFF(return_date, issue_date) AS Diff, Issues.* FROM Issues WHERE  DATEDIFF(return_date, issue_date) < 30 OR return_date IS NULL;

SELECT * FROM Books WHERE title LIKE '%Data%' OR genre LIKE '%Data%';

-- ✅ Part 3: UPDATE (Modify Data)
-- Task 3: Update Operations
-- 9.	Add a new column late_fees to Issues table and set its default value to 0.
-- 10.	Update the late_fee to ₹50 for all issues returned more than 7 days after issue date.
-- 11.	Add a new column member_status to Members table and set all values to 'Active'.
-- 12.	Copy the title of each book to a new column book_title_backup.

ALTER TABLE Issues
ADD COLUMN late_fees DECIMAL(10,2) DEFAULT 0.0;

SELECT * FROM Issues;

SELECT DATEDIFF(return_date, issue_date) AS Diff, Issues.* FROM Issues WHERE  DATEDIFF(return_date, issue_date) > 7;

UPDATE Issues 
SET late_fees = 50
WHERE  DATEDIFF(return_date, issue_date) > 7;

ALTER TABLE Members 
ADD COLUMN member_status ENUM('Active','InActive') NOT NULL DEFAULT 'Active';

SELECT * FROM Members;

ALTER TABLE Books
ADD COLUMN book_title_backup VARCHAR(250) NOT NULL;

ALTER TABLE Books
MODIFY COLUMN book_title_backup VARCHAR(250);

SELECT * FROM Books;

UPDATE Books
SET book_title_backup = title;


-- ✅ Part 4: DELETE (Remove Records)
-- Task 4: Delete Operations
-- 13.	Delete all books from the Books table whose titles contain the word “Data”.
-- 14.	Remove all issues dated between '2023-01-01' and '2023-06-30'.
-- 15.	Delete members whose city is in ('Oldtown', 'Testville', 'DummyCity').
-- 16.	Remove books not in genres 'Science', 'Technology', 'Fiction'.

SELECT * FROM Books;

SELECT * FROM Books WHERE Title LIKE '%Data%';

DELETE
FROM Books WHERE Title LIKE '%Data%';

INSERT INTO Issues (book_id, member_id, issue_date, return_date, late_fee)
VALUES (1, 1, '2023-01-24 00:00:00', DEFAULT, DEFAULT);

SELECT * FROM Issues;
SELECT * FROM Issues WHERE issue_date BETWEEN '2023-01-01 00:00:00' AND '2023-06-30 23:59:59';
DELETE FROM Issues WHERE issue_date BETWEEN '2023-01-01 00:00:00' AND '2023-06-30 23:59:59';

INSERT INTO Members(name, email, join_date, city)
VALUES 
('member7', 'x34yz@g2463mail.com', '2024-02-09 02:21:22', 'DummyCity'),
('member8', 'randofgsm@example.com', '2024-03-23 13:22:58', 'Oldtown'),
('member9', 'foa5374doh@example.com', '2025-03-23 14:22:58', 'DummyCity'),
('member10', 'afp2634gzfdsijf@werds.to', '2023-03-24 15:21:58', DEFAULT),
('member11', 'gakjhgkhsfd236gopfj@newemail.com', '2025-03-24 15:22:58', 'Testville');

SELECT * FROM Members;
SELECT * FROM Members WHERE city IN('Oldtown', 'Testville', 'DummyCity');
DELETE FROM Members WHERE city IN('Oldtown', 'Testville', 'DummyCity');

SELECT * FROM BOOKS;

SELECT * FROM BOOKS WHERE genre NOT IN('Science', 'Technology', 'Fiction');
DELETE FROM BOOKS WHERE genre NOT IN('Science', 'Technology', 'Fiction');


-- ✅ Part 5: BONUS (Backup & Restore)
-- Task 5: Backup
-- 17.	Create a backup table OldIssuesBackup with all issues older than 6 months.
-- 18.	Create a backup table HighValueBooks from Books where price > ₹1000.

CREATE TABLE  OldIssuesBackup SELECT * FROM Issues WHERE DATEDIFF(NOW(), issue_date) > 178;
SELECT * FROM OldIssuesBackup;
SELECT * FROM Issues;

SELECT * FROM Books WHERE price > 1000;
CREATE TABLE HighValueBooks SELECT * FROM Books WHERE price > 1000;
SELECT * FROM HighValueBooks;

SELECT Issues.issue_id, Members.member_id, Books.book_id,Issues.issue_date, Issues.return_date, Books.price, Issues.late_fee
FROM Issues
JOIN Members ON Members.member_id = Issues.member_id 
JOIN Books ON Books.book_id = Issues.book_id;

SELECT i.issue_id, i.book_id, i.member_id, i.issue_date, i.return_date, i.late_fee, m.member_id FROM Issues i JOIN Members m WHERE m.member_id = 1;

SELECT * FROM Books;

SELECT * FROM Issues WHERE book_id IN (SELECT book_id FROM Books WHERE price > 2000 );








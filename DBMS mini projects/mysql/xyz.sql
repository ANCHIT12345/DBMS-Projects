DROP DATABASE IF EXISTS `librarymanagementsystem`;
CREATE DATABASE `librarymanagementsystem`;
USE `librarymanagementsystem`;

CREATE TABLE Authors 
(
AuthorID INT PRIMARY KEY,
AuthorName VARCHAR(50),
Country VARCHAR(60)
);

SELECT * FROM Authors;

INSERT INTO Authors (AuthorID, AuthorName, Country)
VALUES ();

SELECT * FROM Authors;

ALTER TABLE Authors RENAME COLUMN Author_Name TO AuthorName;

CREATE TABLE Members
(
MemberID INT PRIMARY KEY,
MemberName VARCHAR(50),
JoinDate DATE
);

SELECT * FROM Members;

INSERT INTO Members (MemberID, MemberName, JoinDate)
VALUE ();

SELECT * FROM Members;



CREATE TABLE Books
(
BookID INT PRIMARY KEY,
Title VARCHAR(100),
AuthorID INT,
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
Genre VARCHAR(50),
PublishedYear INT
);

SELECT * FROM Books;

INSERT INTO Books (BookID, Title, AuthorID, Genre, PublishedYear)
VALUE ();

SELECT * FROM Books;



CREATE TABLE BorrowRecords 
(
RecordID INT PRIMARY KEY,
MemberID INT,
FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
BookID INT,
FOREIGN KEY (BookID) REFERENCES Books(BookID),
BorrowDate DATE,
ReturnDate DATE
);

SELECT * FROM BorrowRecords;

INSERT INTO BorrowRecords (RecordID, MemberID, BookID, BorrowDate, ReturnDate)
VALUE ();

SELECT * FROM BorrowRecords


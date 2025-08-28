DROP DATABASE IF EXISTS `Students_/_Books`;
CREATE DATABASE `Students_/_Books`;
USE `Students_/_Books`;


CREATE TABLE Students 
(
Student_id INT PRIMARY KEY auto_increment,
Student_name VARCHAR(50),
AGE INT,
Email VARCHAR(254) NOT NULL UNIQUE
);

INSERT INTO Students (Student_name, AGE, Email)
VALUES
('Amit', 19, 'gaihaigh@gmail.com'),
('Alok', 21, 'oaiyhopitho@gmail.com'),
('Manish', 20, 'agohao4yhe@gmail.com'),
('Nidha', 18, 'agljalpgj@gmail.com'),
('Shubham', 22, 'gkjahuyhhagbiab@gmail.com'),
('Rina', 19, 'htahbaifgbiafb@examle.com')
;

DROP TABLE Students;

SELECT * FROM Students;

UPDATE Students
SET AGE = 20 
WHERE Student_id = 1 ;

DELETE FROM Students WHERE Student_name LIKE 'Nidha';

SELECT * 
FROM students
WHERE AGE >= 20;



CREATE TABLE Books 
(
Book_ID INT PRIMARY KEY AUTO_INCREMENT,
Book_Name VARCHAR(100),
ISBN VARCHAR(25) UNIQUE NOT NULL,
Book_Origin VARCHAR(56) NOT NULL DEFAULT 'INDIA',
Author VARCHAR(50) NOT NULL
);

INSERT INTO Books (Book_Name, ISBN, Book_Origin, Author)
VALUES
('To Kill a Mockingbird', '978-0-06-112008-4', 'United States', 'Harper Lee'),
('1984', '978-0-452-28423-4', ' United Kingdom', 'George Orwell'),
('One Hundred Years of Solitude (Cien años de soledad)', '978-0-06-088328-7', 'Colombia', 'Gabriel García Márquez'),
('The Alchemist (O Alquimista)', '978-0-06-112241-5', 'Brazil', 'Paulo Coelho')
;
SELECT * FROM Books;

INSERT INTO Books (Book_Name, ISBN, Author)
VALUES
('The God of Small Things', '978-0-679-78129-9', 'Arundhati Roy');


ALTER TABLE Students ADD COLUMN Course VARCHAR(20);
SELECT * FROM Students;

DELETE FROM Students WHERE Course IS NULL;

ALTER TABLE Students 
ADD CONSTRAINT Valid_Email CHECK (Email LIKE '%___@_%._%');











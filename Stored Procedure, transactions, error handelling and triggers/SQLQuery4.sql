USE Stored_Procedure_Assignment;
--Trigger Assignment – SQL Server
--1. Log every new student added
--Task: Create a trigger that inserts the student’s ID and name into a StudentLog table whenever a new student is added to the Students table.

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName NVARCHAR(100),
    Age INT,
    Course NVARCHAR(50)
);

CREATE TABLE Studlog
(
LogID INT PRIMARY KEY IDENTITY(1,1),
Stud_ID INT,
Stud_Name VARCHAR(25),
LogDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER Trg_LogNewStudent
ON Students
AFTER INSERT
AS BEGIN
	INSERT INTO Studlog(Stud_ID, Stud_Name)
	SELECT StudentID, StudentName
	FROM inserted
END



INSERT INTO Students(StudentID,StudentName,Age,Course)
VALUES(101,'student_1',22,'test');

SELECT * FROM Studlog;

--2. Prevent inserting orders with zero quantity
--Task: Create a trigger that stops the insert if Quantity <= 0 in the Orders table.



CREATE TRIGGER trg_PreventZeroQuantity
ON Orders
AFTER INSERT
AS
BEGIN
    IF EXISTS(SELECT 1 FROM inserted WHERE Quantity <=0)
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Order quantity must be grater than zero.',16,1)
    END
END

INSERT INTO Orders(BookID,Quantity,OrderDate)
VALUES(1,0,GETDATE());

--3. Automatically set CreatedDate
--Task: When a new row is inserted into Employees, automatically set the CreatedDate column to the current date if it’s not provided.

CREATE TABLE Employees
(
Emp_ID INT PRIMARY KEY IDENTITY(1,1),
NAME VARCHAR(25),
Design VARCHAR(20),
CreatedDate DATETIME
);

CREATE TRIGGER trg_SetCreatedDate
ON Employees
AFTER INSERT
AS
BEGIN
    UPDATE e SET e.CreatedDate = GETDATE() FROM Employees e INNER JOIN inserted i ON e.Emp_ID = i.Emp_ID WHERE i.CreatedDate IS NULL;
END

INSERT INTO Employees(Name,Design)
VALUES('test1','Manager');
 
 SELECT * FROM Employees;

--4. Keep track of deleted products
--Task: When a row is deleted from Products, insert the deleted product’s ID and name into DeletedProducts table.

CREATE TABLE Products
(
ProductID INT PRIMARY KEY IDENTITY(1,1),
ProductName VARCHAR(25),
Price DECIMAL(10,2)
);

INSERT INTO Products(ProductName,Price)
VALUES('Laptop',55000),
('Mouse',500);

CREATE TABLE detedproducts
(
deletedID INT PRIMARY KEY IDENTITY(1,1),
ProductID INT,
ProductName VARCHAR(25),
DeletedDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trd_trackdeletedproduct
ON Products
AFTER DELETE
AS
BEGIN
    INSERT INTO detedproducts(ProductID,ProductName)
    SELECT d.ProductID, d.ProductName FROM deleted d
END;

DELETE FROM Products WHERE ProductName = 'Laptop';

SELECT * FROM detedproducts;

--5. Log salary changes
--Task: When an employee’s salary changes in the Employees table, log the old and new salary into SalaryAudit table.

ALTER TABLE Employees ADD Salary DECIMAL(10,2);

CREATE TABLE SalaryAudit
(
AuditID INT PRIMARY KEY IDENTITY(1,1),
EmployeeID INT,
OldSalary DECIMAL(10,2),
NewSalary DECIMAL(10,2),
ChangeDate DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER Trg_SalaryLog
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO SalaryAudit(EmployeeID,OldSalary,NewSalary)
    SELECT d.Emp_ID, d.Salary AS OldSalary, i.Salary AS NewSalary
    FROM deleted d
    INNER JOIN inserted i ON d.Emp_ID = i.Emp_ID
    WHERE d.Salary <> i.Salary;
END;

INSERT INTO Employees(Name,Salary)
VALUES('test1',50000)

UPDATE Employees SET Salary = 65000
Where Name = 'test1';

SELECT * FROM SalaryAudit

--6. Count how many students got updated
--Task: Create a trigger that counts the number of rows updated in the Students table and stores this count in a StudentUpdateLog table.

CREATE TRIGGER trg_CountStudnentUpdates
ON Students
AFTER UPDATE
AS 
BEGIN
    DECLARE @Count INT
    SET @Count = (SELECT COUNT(*) FROM inserted)
    INSERT INTO Studlog(UpdateCount)
    VALUES(@Count)
END;

SELECT * FROM Students

INSERT INTO Students(StudentID,StudentName,Age,Course)
VALUES(1,'Alice',20,'Cse'),(2,'Brad',22,'Ece'),(3,'Frank',25,'Meca')

SELECT * FROM Studlog

UPDATE Students SET Age = 23 WHERE StudentName = 'Alice'

--7. Auto-change NULL city to ‘Unknown’
--Task: When inserting a new customer in Customers, if the city is NULL, automatically change it to ‘Unknown’.

CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY IDENTITY(1,1),
CustomerName VARCHAR(25),
City VARCHAR(60)
)

CREATE TRIGGER trg_SetUnkownCity
ON Customers
AFTER INSERT
AS
BEGIN
    UPDATE Customers SET City = 'Unknown'
    WHERE City IS NULL AND CustomerID IN(SELECT CustomerID FROM inserted)
END

INSERT INTO Customers(CustomerName,City)
VALUES('test',NULL)

SELECT * FROM Customers

--8. Prevent deletion of Admin users
--Task: Create a trigger that prevents deleting any row in Users table where Role = 'Admin'.

CREATE TABLE Users
(
UserID INT PRIMARY KEY IDENTITY(1,1),
UserName VARCHAR(25),
Role VARCHAR(50)
)
INSERT INTO Users (UserName, Role) VALUES
('John', 'Admin'),
('Alice', 'User'),
('Bob', 'Moderator');


--9. Log who inserted the record
--Task: Create a trigger that stores the username (SUSER_SNAME()) into an InsertedBy column when a new order is inserted in Orders table.

CREATE TABLE Ordertest
(
OrderID INT PRIMARY KEY IDENTITY(1,1),
ProductName VARCHAR(100),
Quantity INT,
InsertedBy VARCHAR(100) NULL
);

CREATE TRIGGER TRG_loginsertedby
ON Ordertest
AFTER INSERT
AS
BEGIN
    UPDATE o SET InsertedBY = SUSER_SNAME() FROM Ordertest o INNER JOIN inserted i ON o.OrderID = i.OrderID
END;


INSERT INTO Ordertest (ProductName, Quantity) VALUES ('test', 2);

SELECT * FROM Ordertest

--10. Backup updated data before change
--Task: When updating a row in Books, insert the old data into BooksBackup table before the update happens.

CREATE TABLE BooksBackup
(
    BackupID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT,
    Title VARCHAR(200),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Price DECIMAL(10,2),
    StockQty INT,
    DiscountApplied BIT,
    BackupDate DATETIME DEFAULT GETDATE()
);


CREATE TRIGGER TRG_backupbooks
ON Books
FOR UPDATE
AS
BEGIN
    INSERT INTO BooksBackup(BookID, Title, Author, Genre, Price, StockQty, DiscountApplied)
    SELECT BookID, Title, Author, Genre, Price, StockQty, DiscountApplied FROM Books
END;

UPDATE Books SET Price = Price + 100, DiscountApplied = 1 WHERE BookID = 1;

SELECT * FROM BooksBackup
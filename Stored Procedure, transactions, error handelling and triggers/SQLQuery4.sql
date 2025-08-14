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



--5. Log salary changes
--Task: When an employee’s salary changes in the Employees table, log the old and new salary into SalaryAudit table.

--6. Count how many students got updated
--Task: Create a trigger that counts the number of rows updated in the Students table and stores this count in a StudentUpdateLog table.

--7. Auto-change NULL city to ‘Unknown’
--Task: When inserting a new customer in Customers, if the city is NULL, automatically change it to ‘Unknown’.

--8. Prevent deletion of Admin users
--Task: Create a trigger that prevents deleting any row in Users table where Role = 'Admin'.

--9. Log who inserted the record
--Task: Create a trigger that stores the username (SUSER_SNAME()) into an InsertedBy column when a new order is inserted in Orders table.

--10. Backup updated data before change
--Task: When updating a row in Books, insert the old data into BooksBackup table before the update happens.
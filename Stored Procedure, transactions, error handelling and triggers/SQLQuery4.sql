--Trigger Assignment – SQL Server
--1. Log every new student added
--Task: Create a trigger that inserts the student’s ID and name into a StudentLog table whenever a new student is added to the Students table.

--2. Prevent inserting orders with zero quantity
--Task: Create a trigger that stops the insert if Quantity <= 0 in the Orders table.

--3. Automatically set CreatedDate
--Task: When a new row is inserted into Employees, automatically set the CreatedDate column to the current date if it’s not provided.

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
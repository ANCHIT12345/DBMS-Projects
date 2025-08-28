CREATE DATABASE Stored_Procedure_Assignment;
USE  Stored_Procedure_Assignment;

--Online Bookstore – Stored Procedure Assignment
--Tables:

--Books(BookID, Title, Author, Genre, Price, StockQty)

CREATE TABLE Books
(
BookID INT PRIMARY KEY IDENTITY(1,1),
Title VARCHAR(100),
Author VARCHAR(50),
Genre VARCHAR(100),
Price DECIMAL(10,2),
StockQty INT
);

--DROP TABLE Books;

INSERT INTO Books(Title,Author,Genre,Price,StockQty)
VALUES('book1','author1','comedy',200.33,25),
('book2','author2','tech',240.33,25),
('book3','author1','comedy,thriller',340.33,25),
('book4','author3','ComputerScience',1050.33,25),
('book5','author4','Technical,Fantacy,Action,Comedy',1200.33,25);

--Orders(OrderID, BookID, Quantity, OrderDate)

CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY(1,1),
BookID INT REFERENCES Books(BookID),
Quantity INT,
OrderDate DATE
);

--DROP TABLE Orders;

INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (1, 2, '2025-07-20');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (3, 1, '2025-07-15');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (5, 3, '2025-07-10');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (2, 2, '2025-06-30');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (4, 1, '2025-06-25');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (2, 4, '2025-06-20');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (1, 2, '2025-06-10');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (3, 5, '2025-05-30');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (5, 1, '2025-05-25');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (4, 3, '2025-05-15');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (3, 2, '2025-05-05');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (2, 1, '2025-04-30');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (1, 3, '2025-04-20');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (5, 2, '2025-04-10');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (3, 4, '2025-04-01');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (4, 2, '2025-03-20');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (2, 3, '2025-03-10');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (1, 1, '2025-03-01');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (5, 5, '2025-02-25');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (2, 2, '2025-02-15');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (4, 1, '2025-02-05');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (3, 3, '2025-01-25');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (1, 4, '2025-01-15');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (5, 2, '2025-01-05');
INSERT INTO Orders (BookID, Quantity, OrderDate) VALUES (2, 5, '2024-12-30');


-- Assignment Questions
--Create a stored procedure GetBooksByAuthor that accepts an author name as input and returns all books written by that author.

CREATE PROC USP_getbooksbyauthor 
@authorname VARCHAR(50) 
AS
BEGIN
SELECT * FROM Books WHERE Author = @authorname
END;

EXEC USP_getbooksbyauthor 'author2';

--Create a stored procedure GetTotalOrdersByBook that takes a BookID as input and returns the total quantity of orders placed for that book using an output parameter.

CREATE PROCEDURE USP_GetTotalOrdersByBook
@BookID INT,
@TotalQuantity INT OUTPUT
AS
BEGIN 
SELECT @TotalQuantity = SUM(Quantity) FROM Orders WHERE BookID = @BookID;
END;

DECLARE @TotalQuantity INT
EXEC USP_GetTotalOrdersByBook @BookID = 2, @TotalQuantity = @TotalQuantity OUTPUT
PRINT 'Total Quantity Of Books =' + CAST(@TotalQuantity AS VARCHAR);

--Write a stored procedure ApplyGenreDiscount that applies a 10% discount on books from a specific genre (genre passed as input).

ALTER TABLE Books DROP COLUMN DiscountApplied BIT DEFAULT 0;

CREATE PROC USP_ApplyGenreDiscount
	@Genre VARCHAR(100)
AS
BEGIN
	UPDATE Books 
	SET Price = Price * 0.9,
		DiscountApplied = 1
	WHERE ',' + Genre + ','  LIKE '%,' + @Genre + ',%' AND DiscountApplied = 0;
END;

EXEC USP_ApplyGenreDiscount '%comedy%';
SELECT * FROM Books

--Write a stored procedure CheckBookStock that checks whether a book is in stock (BookID as input). If StockQty >= 1, return 'Available'; otherwise, return 'Out of Stock'.

CREATE PROC USP_CheckBookStock
	@Book_title VARCHAR(100),
	@stockcheck VARCHAR(20) OUTPUT
AS
BEGIN
	SELECT 
	@stockcheck = CASE
		WHEN StockQty >= 1 THEN 'Available'
		ELSE 'Out of Stock'
	END FROM Books WHERE Title = @Book_title
END;

DECLARE @stockcheck VARCHAR(20)
EXEC USP_CheckBookStock 'book1', @stockcheck = @stockcheck OUTPUT
PRINT 'The book is ' + @stockcheck;

--Create a stored procedure that returns the top 5 best-selling books (based on total quantity sold in the Orders table).

--SELECT B.BookID,B.Title,SUM(Quantity)AS TotalSold ,
--CASE
--	WHEN SUM(O.Quantity) >= 10 THEN 'Best Selling'
--    WHEN SUM(O.Quantity) >= 5 THEN 'Good Seller'
--	ELSE 'Low Sales'
--END AS SalesCategory
--FROM Orders O INNER JOIN Books B ON O.BookID = B.BookID GROUP BY B.BookID, B.Title ORDER BY TotalSold DESC;

CREATE PROC USP_best_selling_books
AS 
BEGIN
	SELECT B.BookID,B.Title,SUM(Quantity) AS TotalSold,
	CASE
		WHEN SUM(O.Quantity) >= 10 THEN 'Best Selling'
		WHEN SUM(O.Quantity) >= 5 THEN 'Good Seller'
		ELSE 'Low Sales'
	END AS SalesCategory
	FROM Orders O INNER JOIN Books B ON O.BookID = B.BookID GROUP BY B.BookID, B.Title ORDER BY TotalSold DESC
END;

EXEC USP_best_selling_books;

--Write a stored procedure to list all books in stock where Price BETWEEN @MinPrice AND @MaxPrice (pass both values as input parameters).

CREATE PROC USP_BookSearchByPrice
	@MinPrice DECIMAL(10,2), @MaxPrice DECIMAL(10,2)
AS
BEGIN
	SELECT * FROM Books WHERE Price BETWEEN @MinPrice AND @MaxPrice
END;

EXEC USP_BookSearchByPrice 10,1000;

--Create a procedure RestockBooksByGenre that adds 10 units to the StockQty of all books belonging to a specific genre.

CREATE PROC USP_RestockBooksByGenre
	@genre VARCHAR(100)
AS
BEGIN
	UPDATE Books SET StockQty = StockQty+10 WHERE ','+ Genre +',' LIKE '%,' + @genre + ',%'
END;

EXEC USP_RestockBooksByGenre comedy

SELECT * FROM Books

--Write a stored procedure that shows total sales (quantity * price) per genre.

--SELECT B.Genre, SUM(O.Quantity * B.Price) AS TotalSales FROM Orders O INNER JOIN Books B ON O.BookID = B.BookID Group BY B.Genre

CREATE PROC USP_TotalSalesPerGenre
AS
BEGIN
	SELECT B.Genre, SUM(O.Quantity * B.Price) AS TotalSales FROM Orders O INNER JOIN Books B ON O.BookID = B.BookID Group BY B.Genre
END;

EXEC USP_TotalSalesPerGenre;

--Create a stored procedure that deletes all books from the Books table where stock is zero and no orders exist for them.

CREATE PROC USP_Del_Books_with_no_stock_And_No_Orders
AS
BEGIN
DELETE FROM Books WHERE StockQty = 0 AND BookID NOT IN (SELECT DISTINCT BookID FROM Orders)
END;

EXEC USP_Del_Books_with_no_stock_And_No_Orders;

--Write a stored procedure PlaceOrder that:

--Accepts BookID and Quantity as input.

--Checks if the stock is sufficient.

--If yes, inserts a new row in the Orders table and updates StockQty.

--If not, returns a message like "Not enough stock"

SELECT Stockqty FROM Books WHERE BookID = @BookID;

CREATE PROC USP_PlaceOrder
	@BookID INT,
	@Quantity INT
AS
BEGIN
	DECLARE @AvailableStock INT;

	BEGIN TRY
		BEGIN TRANSACTION 
		SELECT @AvailableStock = Stockqty FROM Books WHERE BookID = @BookID
		IF @AvailableStock IS NULL
		BEGIN
			ROLLBACK
			PRINT 'Book not found'
			RETURN
		END
		IF @AvailableStock < @Quantity
		BEGIN 
			ROLLBACK
			PRINT 'Not enough stock'
			RETURN
		END
		INSERT INTO Orders(BookID, Quantity, OrderDate)
		VALUES(@BookID, @Quantity,GETDATE())
		UPDATE Books
		SET Stockqty = Stockqty - @Quantity
		WHERE BookID = @BookID
		COMMIT
		PRINT 'Order placed successfully'
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK;
		PRINT 'An error occured' + ERROR_MESSAGE()
	END CATCH
END;

EXEC USP_PlaceOrder 3,50;
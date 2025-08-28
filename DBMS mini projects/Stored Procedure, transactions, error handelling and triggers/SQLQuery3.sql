--Assignments – Error Handling

USE Stored_Procedure_Assignment;

--Basic TRY-CATCH block
--Write a stored procedure that attempts to insert a new book record into the Books table.
--If the Price is less than or equal to 0, raise an error and handle it using a TRY-CATCH block.

CREATE PROC USP_addbook
	@Title VARCHAR(100),
	@Author VARCHAR(50),
	@Genre VARCHAR(100),
	@Price DECIMAL(10,2),
	@StockQty INT
AS
BEGIN
	BEGIN TRY
		IF @Price <=0
		BEGIN
			THROW 50001, 'Price must be grater than 0.',1;
		END
		INSERT INTO Books(Title,Author,Genre,Price,StockQty)
		VALUES (@Title,@Author,@Genre,@Price,@StockQty);
		PRINT 'Book inserted successfully'
	END TRY
	BEGIN CATCH
		PRINT 'Error Occured while inserting the book';
		PRINT 'Error Number:' + CAST(ERROR_NUMBER() AS VARCHAR);
		PRINT 'Error Message:' + ERROR_MESSAGE();
	END CATCH
END

EXEC USP_addbook    
	@Title = 'test',
    @Author = 'test1',
    @Genre = 'Fiction',
    @Price = 0,
    @StockQty = 10;

--Throwing a custom error
--Create a stored procedure BorrowBook that takes a BookID and MemberID.
--If the book is out of stock, throw a custom error with a message: "Book is currently unavailable".

CREATE TABLE BorrowedBooks
(
    BorrowID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT REFERENCES Books(BookID),
    MemberID INT,
    BorrowDate DATETIME
);

CREATE PROC UPS_BorrowBook
	@BooksID INT,
	@MemberID INT
AS
BEGIN
	DECLARE @AvailableQty INT;
	SELECT @AvailableQty = StockQty FROM Books WHERE BookID = @BooksID
	IF @AvailableQty IS NULL OR @AvailableQty <=0
	BEGIN 
		THROW 50002, 'Books is currently unavailable', 1;
	END
	UPDATE Books SET StockQty = StockQty - 1 WHERE BookID = @BooksID;

	INSERT INTO BorrowedBooks (BookID, MemberID, BorrowDate)
    VALUES (@BooksID, @MemberID, GETDATE());
		
	PRINT 'Book borrowed successfully.';
END;

EXEC UPS_BorrowBook 1,101;

--Using RAISERROR (SQL Server) or SIGNAL (MySQL/PostgreSQL)
--Write a procedure that prevents deleting a book if it has pending orders.
--Use RAISERROR or SIGNAL to stop execution with an appropriate message.

CREATE PROC UPS_DeleteBook_NoOrders
	@BookID INT
AS
BEGIN
	DECLARE @PendingOrders INT;
	SELECT @PendingOrders = COUNT(*) FROM Orders WHERE BookID = @BookID
	IF @PendingOrders >0
	BEGIN
		RAISERROR('Cannot delete the book there are pending orders',16,1);
		RETURN
	END
	DELETE FROM Books WHERE BookID = @BookID;
	PRINT 'Book Deleted'
END

EXEC UPS_DeleteBook_NoOrders @BookID = 3;


--Logging errors to an audit table
--Create an ErrorLog table with fields: ErrorID, ErrorMessage, ErrorDate, ProcedureName.
--Modify any of the above stored procedures to log the error details into this table when an exception occurs.

CREATE TABLE ErrorLog
(
ErrorID INT PRIMARY KEY IDENTITY(1,1),
ErrorMessage NVARCHAR(4000),
ErrorDate DATETIME DEFAULT GETDATE(),
ProcedureName SYSNAME
);

--CREATE PROC USP_addbook
--	@Title VARCHAR(100),
--	@Author VARCHAR(50),
--	@Genre VARCHAR(100),
--	@Price DECIMAL(10,2),
--	@StockQty INT
--AS
--BEGIN
--	BEGIN TRY
--		IF @Price <=0
--		BEGIN
--			THROW 50001, 'Price must be grater than 0.',1;
--		END
--		INSERT INTO Books(Title,Author,Genre,Price,StockQty)
--		VALUES (@Title,@Author,@Genre,@Price,@StockQty);
--		PRINT 'Book inserted successfully'
--	END TRY
--	BEGIN CATCH
--		PRINT 'Error Occured while inserting the book';
--		PRINT 'Error Number:' + CAST(ERROR_NUMBER() AS VARCHAR);
--		PRINT 'Error Message:' + ERROR_MESSAGE();
--	END CATCH
--END

ALTER PROC USP_addbook
	@Title VARCHAR(100),
	@Author VARCHAR(50),
	@Genre VARCHAR(100),
	@Price DECIMAL(10,2),
	@StockQty INT
AS
BEGIN
    BEGIN TRY
        IF @Price <= 0
        BEGIN
            THROW 50001, 'Price must be greater than zero.', 1;
        END
        INSERT INTO Books (Title, Author, Genre, Price, StockQty)
        VALUES (@Title, @Author, @Genre, @Price, @StockQty);
        PRINT 'Book inserted successfully.';
    END TRY
    BEGIN CATCH
        INSERT INTO ErrorLog (ErrorMessage, ProcedureName)
        VALUES (ERROR_MESSAGE(), 'AddBook');
        PRINT 'Error occurred. Check ErrorLog table for details.';
    END CATCH
END

EXEC USP_addbook 'test1', 'test', 'fiction', 0, 5;

SELECT * FROM ErrorLog;

--Return codes for success/failure
--Write a stored procedure to update book stock.
--Return 0 if the update is successful, 1 if the book does not exist, and 2 if the stock quantity is invalid.

CREATE PROC USP_UpdateBookStock
	@BookID INT,
	@NewStockQty INT
AS
BEGIN
	IF @NewStockQty < 0
	BEGIN
		RETURN 2;
	END
	IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
	BEGIN
		RETURN 1;
	END
	UPDATE Books SET StockQty = @NewStockQty WHERE BookID = @BookID
	RETURN 0;
END

DECLARE @Result INT;
EXEC @Result = USP_UpdateBookStock @bookID = 1, @NewStockQty = 25;
IF @Result = 0
    PRINT 'Stock updated successfully.';
ELSE IF @Result = 1
    PRINT 'Error: Book does not exist.';
ELSE IF @Result = 2
    PRINT 'Error: Invalid stock quantity.';

--Error handling with nested procedures
--Create two stored procedures:
--ProcessOrder (calls ReduceStock)
--ReduceStock (updates Books.StockQty)
--Simulate an error in ReduceStock and ensure it’s handled gracefully in ProcessOrder.

CREATE PROC USP_Reduce_Stock
	@BookID INT,
	@QtyToReduce INT
AS
BEGIN
	DECLARE @CurrentStock INT
	SELECT @CurrentStock = StockQty FROM Books WHERE BookID = @BookID
	IF @CurrentStock IS NULL
	BEGIN
		THROW 50010, 'Book not found in ReduceStock',1;
	END
	IF @CurrentStock < @QtyToReduce
	BEGIN
		THROW 50011, 'Inssuficent Stock',1;
	END
	UPDATE Books SET StockQty = StockQty - @QtyToReduce WHERE BookID = @BookID
	PRINT 'Stock reduced'
END;

CREATE PROC ProcessOrder
	@BookID INT,
	@OrderQty INT
AS
BEGIN
	BEGIN TRY
		EXEC USP_Reduce_Stock @BookID = @BookID, @QtyToReduce = @OrderQty
		INSERT INTO Orders(BookID,Quantity,OrderDate)
		VALUES(@BookID,@OrderQty,GETDATE())
		PRINT 'Order Processed'
	END TRY
	BEGIN CATCH
		PRINT 'Error occured in ProcessOrder.';
		PRINT 'Error Number:' + CAST(Error_Number() AS VARCHAR);
		PRINT 'Error Message:' + Error_Message()
	END CATCH
END;

EXEC ProcessOrder @BookID = 1, @OrderQty = 2;
EXEC ProcessOrder @BookID = 999, @OrderQty = 2;
EXEC ProcessOrder @BookID = 1, @OrderQty = 9999;

--TRY-CATCH with transaction rollback
--Write a stored procedure that processes multiple book orders in a transaction.
--If any one book is out of stock, rollback the entire transaction and log the error.

	

--Validate input parameters
--Create a stored procedure UpdateBookPrice that checks:
--Price > 0
--Book exists
--If invalid, throw a custom error and prevent execution.

CREATE PROC USP_UpdateBookPrice
	@BookID INT,
	@NewPrice DECIMAL(10,2)
AS
BEGIN
	IF @NewPrice <=0
	BEGIN
		THROW 70001,'Invalid price',1
	END
	IF NOT EXISTS(SELECT 1 FROM Books WHERE BookID = @BookID)
	BEGIN
		THROW 70002, 'Book Not Found',1;
	END
	UPDATE Books SET Price = @NewPrice WHERE BookID = @BookID
	PRINT 'Book price updated'
END


EXEC USP_UpdateBookPrice @BookID = 1, @NewPrice = 299.99;
EXEC USP_UpdateBookPrice @BookID = 1, @NewPrice = 0;
EXEC USP_UpdateBookPrice @BookID = 999, @NewPrice = 150;


--Error handling for division by zero
--Write a query that calculates the average price per book in a genre.
--Wrap it in TRY-CATCH to handle cases where the number of books in that genre is zero.

CREATE PROC UPS_getavgpricebygener
	@Genre VARCHAR(100)
AS
BEGIN
	BEGIN TRY
		DECLARE @BookCount INT
		DECLARE @TotalPrice DECIMAL(10,2)
		DECLARE @AvgPrice DECIMAL(10,2)
		SELECT @BookCount = COUNT(*), @TotalPrice = SUM(Price) FROM Books WHERE Genre = @Genre
		IF @BookCount = 0
		BEGIN
			THROW 80001, 'Division by zero err',1
		END
		SET @AvgPrice = @TotalPrice / @BookCount
		PRINT 'Avg price for genre "' + @Genre + '" Is ' + CAST(@AvgPrice AS VARCHAR(20))
	END TRY
	BEGIN CATCH
		PRINT 'Err Calculating the avg price'
		PRINT 'Err Number' + CAST(ERROR_NUMBER() AS VARCHAR)
		PRINT 'Err message' + ERROR_MESSAGE()
	END CATCH
END

EXEC UPS_getavgpricebygener 'Fiction'

--Comprehensive error handling case
--Create a stored procedure CompleteBookPurchase that:
--Starts a transaction
--Deducts stock
--Inserts into Orders table
--Logs any error (custom or system) to ErrorLog
--Rolls back if any step fails

CREATE PROC UPS_CompleteBookPurchase
	@BookID INT,
	@OrderQty INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION 
		DECLARE @currentstock INT
		SELECT @currentstock = StockQty FROM Books WHERE BookID = @BookID
		IF @currentstock IS NULL
		BEGIN 
			THROW 90001, 'Book not found',1
		END
		IF @currentstock < @OrderQty
		BEGIN 
			THROW 90002, 'Insufficent stock',1
		END
		UPDATE Books SET StockQty = StockQty - @OrderQty WHERE BookID = @BookID
		INSERT INTO Orders(BookID,Quantity,OrderDate)
		VALUES (@BookID,@OrderQty,GETDATE())
		COMMIT
		PRINT 'Purchase Completed'
	END TRY
	BEGIN CATCH
	IF @@TRANCOUNT > 0
		ROLLBACK;
		INSERT INTO ErrorLog(ErrorMessage, ProcedureName)
		VALUES (ERROR_MESSAGE(),' UPS_CompleteBookPurchase')
		PRINT 'An err occured, transaction rolledback'
	END CATCH
END;

EXEC UPS_CompleteBookPurchase @BookID = 1, @OrderQty = 2;


EXEC UPS_CompleteBookPurchase @BookID = 999, @OrderQty = 1;

SELECT * FROM ErrorLog;


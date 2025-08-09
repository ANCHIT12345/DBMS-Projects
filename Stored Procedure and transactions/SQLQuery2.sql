USE Stored_Procedure_Assignment;

SELECT * FROM Books;

--Transaction with Commit
--Simulate a bookstore order placement. Write a transaction that:
--Decreases StockQty in Books table,
--Inserts a new record in the Orders table.
--Commits the transaction only if stock is available.

CREATE PROC USP_BookOrderPlacement
	@BookID INT,
	@Quantity INT
AS
BEGIN
	DECLARE @AvailableStock INT
	BEGIN TRANSACTION
		SELECT @AvailableStock = StockQty FROM Books WHERE BookID = @BookID
		IF @AvailableStock IS NOT NULL AND @AvailableStock >= @Quantity
		BEGIN
			UPDATE Books SET StockQty = StockQty - @Quantity WHERE BookID = @BookID
			INSERT INTO Orders(BookID,Quantity,OrderDate)
			VALUES(@BookID,@Quantity,GETDATE());
			COMMIT
			PRINT 'Order Placed'
		END
		ELSE
		BEGIN
			ROLLBACK;
			PRINT 'Order Failed'
		END
END;

EXEC USP_BookOrderPlacement 1,2

--Transaction with Rollback
--Simulate a bank transfer transaction:
--Debit amount from AccountA,
--Credit amount to AccountB.
--If either operation fails, rollback the transaction.

CREATE TABLE BankAccounts
(
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(100),
    Balance DECIMAL(10,2)
);

INSERT INTO BankAccounts (AccountID, AccountHolder, Balance) VALUES
(101, 'Alice', 1000.00),
(202, 'Bob', 300.00);

CREATE PROCEDURE USP_TransferAmount
    @FromAccountID INT,
    @ToAccountID INT,
    @Amount DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @FromBalance DECIMAL(10,2);

    BEGIN TRANSACTION;

    -- Step 1: Check if sender has enough balance
    SELECT @FromBalance = Balance FROM BankAccounts WHERE AccountID = @FromAccountID;

    IF @FromBalance IS NULL
    BEGIN
        ROLLBACK;
        PRINT 'Transfer failed: Sender account does not exist.';
        RETURN;
    END

    IF @FromBalance < @Amount
    BEGIN
        ROLLBACK;
        PRINT 'Transfer failed: Insufficient funds in sender account.';
        RETURN;
    END

    -- Step 2: Debit from sender
    UPDATE BankAccounts
    SET Balance = Balance - @Amount
    WHERE AccountID = @FromAccountID;

    IF @@ROWCOUNT <> 1
    BEGIN
        ROLLBACK;
        PRINT 'Transfer failed: Debit operation failed.';
        RETURN;
    END

    -- Step 3: Credit to receiver
    UPDATE BankAccounts
    SET Balance = Balance + @Amount
    WHERE AccountID = @ToAccountID;

    IF @@ROWCOUNT <> 1
    BEGIN
        ROLLBACK;
        PRINT 'Transfer failed: Receiver account does not exist.';
        RETURN;
    END

    -- Step 4: Commit if everything is successful
    COMMIT;
    PRINT 'Transfer completed successfully.';
END;


EXEC USP_TransferAmount @FromAccountID = 101, @ToAccountID = 202, @Amount = 500.00;


--Savepoints Usage
--Simulate a stock update with 2 updates:
--Update stock for Genre = 'Fiction' → Savepoint1
--Update stock for Genre = 'Science' → Savepoint2
--If the second update fails, rollback to Savepoint1.

CREATE PROC USP_UpdateStockGenre
	@Genre1 VARCHAR(100),
	@stcup1 INT,
	@Genre2 VARCHAR(100),
	@stcup2 INT
AS
BEGIN
	BEGIN TRANSACTION;
	SAVE TRANSACTION SP1
		UPDATE Books SET StockQty = StockQty + @stcup1  WHERE Genre = @Genre1;
	SAVE TRANSACTION SP2
		UPDATE Books SET StockQty = StockQty + @stcup2  WHERE Genre = @Genre2;
	SAVE TRANSACTION SP3
	ROLLBACK TRANSACTION SP2
	COMMIT TRANSACTION
END

DROP PROC USP_UpdateStockGenre

EXEC USP_UpdateStockGenre 'comedy',10,'tech',20

SELECT * FROM Books

--41
--25

--Error Handling
--Wrap a transaction in TRY...CATCH:
--If any error occurs (e.g., updating a non-existent book), rollback and display a user-friendly message like "Transaction failed due to invalid data".



--       5. Inventory Refill with Transaction
--Create a transaction to refill stock for books that have StockQty < 5 and log each restock in a RestockLog table. Rollback if any insert into RestockLog fails.

--USE E_commerce_Databases;

--ALTER PROC USP_CreateOrder AS
--BEGIN
--	DECLARE @newOrderId int
--	BEGIN TRY
--		BEGIN Transaction
--		INSERT INTO Orders(customer_id,order_date,total_amount)
--		VALUES(1,'2025-07-19',5005.20)
--		select @newOrderId=SCOPE_IDENTITY()
--		INSERT INTO Order_Items(order_id,product_id,quantity)
--		VALUES(@newOrderId,75,3)
--		Commit;
--		PRINT 'commited'
--	END TRY
--	BEGIN CATCH
--		Rollback;
--		PRINT ERROR_MESSAGE();
--	END CATCH
--END;

--EXEC USP_CreateOrder;

--SELECT * FROM Customers;
--SELECT * FROM Orders;
--SELECT * FROM Order_Items;
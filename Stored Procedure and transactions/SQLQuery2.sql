USE E_commerce_Databases;

ALTER PROC USP_CreateOrder AS
BEGIN
	DECLARE @newOrderId int
	BEGIN TRY
		BEGIN Transaction
		INSERT INTO Orders(customer_id,order_date,total_amount)
		VALUES(1,'2025-07-19',5005.20)
		select @newOrderId=SCOPE_IDENTITY()
		INSERT INTO Order_Items(order_id,product_id,quantity)
		VALUES(@newOrderId,75,3)
		Commit;
		PRINT 'commited'
	END TRY
	BEGIN CATCH
		Rollback;
		PRINT ERROR_MESSAGE();
	END CATCH
END;

EXEC USP_CreateOrder;

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Order_Items;
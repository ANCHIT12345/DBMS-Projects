USE Ticketing_Tool;

CREATE PROC USP_UserRegistration
	@User_name VARCHAR(25),
	@Email VARCHAR(320),
	@Ph_No VARCHAR(15),
	@Password VARCHAR(100)
AS
BEGIN
	BEGIN TRY
		INSERT INTO [User]([User_name], UT_ID, Dept_ID, Email, Ph_No, [Password], Join_Date)
		VALUES (@User_name, 1, NULL, @Email, @Ph_No, @Password, GETDATE())
	END TRY
	BEGIN CATCH
		IF ERROR_NUMBER() = 2627 OR ERROR_NUMBER() = 2601
		BEGIN
			PRINT 'Error: Email address OR Phone_Number already exists. Pleas try with another Email Phone_Number';
		END
		ELSE
		BEGIN
			PRINT 'An unxexpected error occured: ' + ERROR_MESSAGE();
		END
	END CATCH
END

EXEC USP_UserRegistration 'Anish','anish123@gmail.com', '9569141412' ,'Anish1234$';



CREATE PROC USP_CreateTicket



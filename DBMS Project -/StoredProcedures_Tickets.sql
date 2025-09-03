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

EXEC USP_UserRegistration 'Ani','ani123@gmail.com', '9568141412' ,'Ani1234$';

SELECT * FROM [User]

CREATE PROC USP_CreateTicket
    @Status_ID INT,
    @Ticket_Title VARCHAR(100),
    @Ticket_Desc VARCHAR(250),
    @Ticket_Prio_ID INT,
    @Ticket_Category INT,
    @Agent_ID INT,
    @User_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ticket_id INT;
    INSERT INTO Tickets(Status_ID, Ticket_Title, Ticket_Desc, Ticket_Prio_ID, Ticket_Category, Create_Date, Agent_ID)
    VALUES(@Status_ID, @Ticket_Title, @Ticket_Desc, @Ticket_Prio_ID, @Ticket_Category, GETDATE(), @Agent_ID);
    SET @ticket_id = SCOPE_IDENTITY();
    INSERT INTO UserTicketMaping (User_ID, Ticket_ID)
    VALUES (@User_ID, @ticket_id);
    SELECT @ticket_id AS NewTicketID;
END;


EXEC USP_CreateTicket
    @Status_ID = 1,
    @Ticket_Title = 'Login not working',
    @Ticket_Desc = 'User cannot log into system',
    @Ticket_Prio_ID = 3,
    @Ticket_Category = 1,
    @Agent_ID = 7,
    @User_ID = 4;

    --SELECT * FROM Tickets
    --SELECT * FROM UserTicketMaping


CREATE PROC USP_AttachDocToTicket
    @Ticket_ID INT,
    @File_Url VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket does not exist.', 16, 1);
        RETURN;
    END;
    INSERT INTO Document (Ticket_ID, File_Url)
    VALUES (@Ticket_ID, @File_Url);
    SELECT SCOPE_IDENTITY() AS NewDocID;
END;

EXEC USP_AttachDocToTicket 8, 'xyzurl.xyz';

--SELECT * FROM Document

CREATE PROC USP_CommentAddTicket
    @Ticket_ID INT,
    @Content VARCHAR(2000)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket does not exist.', 16, 1);
        RETURN;
    END;
    INSERT INTO Comment (Ticket_ID, Content)
    VALUES (@Ticket_ID, @Content);
    SELECT SCOPE_IDENTITY() AS NewDocID;
END;

EXEC USP_CommentAddTicket 8, 'test comment'

--SELECT * FROM Comment

CREATE PROC USP_ReviewTicket
    @Ticket_ID INT,
    @Review VARCHAR(2000),
    @Rating INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket does not exist.', 16, 1);
        RETURN;
    END;
    IF @Rating <1 OR @Rating >5
    BEGIN 
        RAISERROR('Rating must be between 1 and 5.', 16, 1);
        RETURN;
    END
    DECLARE @Review_ID INT;
    INSERT INTO Reviews (Review, Rating)
    VALUES (@Review, @Rating);
    SET @Review_ID = SCOPE_IDENTITY();
    UPDATE Tickets
    SET Review_ID = @Review_ID
    WHERE Ticket_ID = @Ticket_ID;
    SELECT @Review_ID AS NewReviewID;
END;   

EXEC USP_ReviewTicket 8, 'test review', 5

--SELECT * FROM Tickets
--SELECT * FROM Reviews

CREATE PROC USP_Login
    @Email VARCHAR(320),
    @Password VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE Email = @Email)
    BEGIN
        RAISERROR('Invalid Email. User does not exist.', 16, 1);
        RETURN;
    END;
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE Email = @Email AND [Password] = @Password)
    BEGIN
        RAISERROR('Invalid credentials. Please check your email and password.', 16, 1);
        RETURN;
    END
    SELECT U.User_ID,U.User_name,U.Email,U.UT_ID,UT.Role AS UserRole,U.Dept_ID,D.dept_name,U.Join_Date
    FROM [User] U INNER JOIN UserType UT ON U.UT_ID = UT.UT_ID INNER JOIN Department D ON U.Dept_ID = D.Dept_ID WHERE U.Email = @Email AND U.[Password] = @Password;
END;

SELECT * FROM [User]


CREATE PROC UPS_ModifyTicket
    @Ticket_ID INT,
    @Status_ID INT = NULL,
    @Ticket_Title VARCHAR(100) = NULL,
    @Ticket_Desc VARCHAR(250) = NULL,
    @Ticket_Prio_ID INT = NULL,
    @Ticket_Category INT = NULL,
    @End_Date DATE = NULL,
    @ETA TIME = NULL,
    @Agent_ID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS(SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket dose not exists', 16, 1)
        RETURN;
    END
    UPDATE Tickets
    SET 
        Status_ID = ISNULL(@Status_ID, Status_ID),
        Ticket_Title = ISNULL(@Ticket_Title, Ticket_Title),
        Ticket_Desc = ISNULL(@Ticket_Desc, Ticket_Desc),
        Ticket_Prio_ID = ISNULL(@Ticket_Prio_ID, Ticket_Prio_ID),
        Ticket_Category = ISNULL(@Ticket_Category, Ticket_Category),
        End_Date = ISNULL(@End_Date, End_Date),
        ETA = ISNULL(@ETA, ETA),
        Agent_ID = ISNULL(@Agent_ID, Agent_ID)
    WHERE Ticket_ID = @Ticket_ID;
    SELECT * FROM Tickets WHERE Ticket_ID = @Ticket_ID;
END;


CREATE PROC USP_SendNotification
    @User_ID INT,
    @Ticket_ID INT,
    @Message VARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS(SELECT 1 FROM [User] WHERE [User_ID] = @User_ID)
    BEGIN
        RAISERROR('Invalid User_ID. User Not Found', 16, 1);
        RETURN;
    END;
    IF NOT EXISTS(SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket Not Found', 16, 1);
        RETURN;
    END;
    INSERT INTO [Notification] (User_ID, Ticket_ID, [Message]) VALUES(@User_ID ,@Ticket_ID, @Message)
    SELECT SCOPE_IDENTITY() AS NewNotification;
END;

EXEC USP_SendNotification 4, 8, 'test'

--SELECT * FROM [Notification]


--------------------------------------------------------------------------------------------------------------------
--CREATE PROC USP_StoreBackup
--    @BackupPath NVARCHAR(500)  -- full file path for backup
--AS
--BEGIN
--    SET NOCOUNT ON;

--    DECLARE @SQL NVARCHAR(MAX);

--    -- Build backup command
--    SET @SQL = 'BACKUP DATABASE Ticketing_Tool 
--                TO DISK = ''' + @BackupPath + ''' 
--                WITH FORMAT, INIT, 
--                NAME = ''Ticketing_Tool-FullBackup'', 
--                SKIP, NOREWIND, NOUNLOAD, STATS = 10;';

--    -- Execute backup
--    EXEC(@SQL);
--END;
--GO


--CREATE TABLE TicketHistory
--(
--    History_ID INT PRIMARY KEY IDENTITY(1,1),
--    Ticket_ID INT REFERENCES Tickets(Ticket_ID),
--    User_ID INT REFERENCES [User](User_ID),
--    Action VARCHAR(100),              -- e.g., Created, Updated, Closed
--    OldValue VARCHAR(2000) NULL,      -- optional (before change)
--    NewValue VARCHAR(2000) NULL,      -- optional (after change)
--    Change_Date DATETIME DEFAULT GETDATE()
--);


--CREATE PROC USP_CreateSaveHistory
--    @Ticket_ID INT,
--    @User_ID INT,
--    @Action VARCHAR(100),
--    @OldValue VARCHAR(2000) = NULL,
--    @NewValue VARCHAR(2000) = NULL
--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- Validate Ticket
--    IF NOT EXISTS (SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
--    BEGIN
--        RAISERROR('Invalid Ticket_ID. Ticket does not exist.', 16, 1);
--        RETURN;
--    END;

--    -- Validate User
--    IF NOT EXISTS (SELECT 1 FROM [User] WHERE User_ID = @User_ID)
--    BEGIN
--        RAISERROR('Invalid User_ID. User does not exist.', 16, 1);
--        RETURN;
--    END;

--    -- Insert history record
--    INSERT INTO TicketHistory (Ticket_ID, User_ID, Action, OldValue, NewValue)
--    VALUES (@Ticket_ID, @User_ID, @Action, @OldValue, @NewValue);

--    -- Return new History ID
--    SELECT SCOPE_IDENTITY() AS NewHistoryID;
--END;
--GO

---- Log when a ticket’s status is updated
--EXEC USP_CreateSaveHistory
--    @Ticket_ID = 1,
--    @User_ID = 2,
--    @Action = 'Status Updated',
--    @OldValue = 'Open',
--    @NewValue = 'In Progress';
--------------------------------------------------------------------------------------------------------------------


CREATE PROC USP_SaveDocument
    @Ticket_ID INT,
    @File_Url VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS(SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket Not Found', 16, 1)
        RETURN;
    END
    INSERT INTO Document(Ticket_ID, File_Url)
    VALUES(@Ticket_ID,@File_Url);
    SELECT SCOPE_IDENTITY() AS NewDocument;
END;

EXEC USP_SaveDocument 8, 'test_url';


CREATE PROC USP_UpdateDocument
    @Doc_ID INT,
    @Ticket_ID INT = NULL,
    @File_Url VARCHAR(100) = NULL
AS 
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS(SELECT 1 FROM Document WHERE Doc_ID = @Doc_ID)
    BEGIN
        RAISERROR('Doc_ID Not Found, Document dose not exists.', 16, 1)
        RETURN;
    END
    IF NOT EXISTS(SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket Not Found', 16, 1);
        RETURN;
    END;
    UPDATE Document
    SET
        Ticket_ID = ISNULL(@Ticket_ID, Ticket_ID)
        Filr_Url = ISNULL(@File_Url, File_Url)
    WHERE Doc_ID = @Doc_ID;
    SELECT * FROM Document WHERE Doc_ID = @Doc_ID;
END;

--------------------------------------------------------------------------------------------------------------------
--CREATE PROC USP_UpdateDataTicket
--    @Ticket_ID INT,
--    @Status_ID INT = NULL,
--    @Review_ID INT = NULL,
--    @Ticket_Title VARCHAR(100) = NULL,
--    @Ticket_Desc VARCHAR(250) = NULL,
--    @Ticket_Prio_ID INT = NULL,
--    @Ticket_Category INT = NULL,
--    @End_Date DATE = NULL,
--    @ETA TIME = NULL,
--    @Agent_ID INT = NULL
--AS
--BEGIN
--    SET NOCOUNT ON;
--    IF NOT EXISTS (SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
--    BEGIN
--        RAISERROR('Invalid Ticket_ID. Ticket does not exist.', 16, 1);
--        RETURN;
--    END;
--    UPDATE Tickets
--    SET 
--        Status_ID = ISNULL(@Status_ID, Status_ID),
--        Review_ID = ISNULL(@Review_ID, Review_ID),
--        Ticket_Title = ISNULL(@Ticket_Title, Ticket_Title),
--        Ticket_Desc = ISNULL(@Ticket_Desc, Ticket_Desc),
--        Ticket_Prio_ID = ISNULL(@Ticket_Prio_ID, Ticket_Prio_ID),
--        Ticket_Category = ISNULL(@Ticket_Category, Ticket_Category),
--        End_Date = ISNULL(@End_Date, End_Date),
--        ETA = ISNULL(@ETA, ETA),
--        Agent_ID = ISNULL(@Agent_ID, Agent_ID)
--    WHERE Ticket_ID = @Ticket_ID;
--    SELECT *
--    FROM Tickets
--    WHERE Ticket_ID = @Ticket_ID;
--END;
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--CREATE TABLE TicketHistory
--(
--    History_ID INT PRIMARY KEY IDENTITY(1,1),
--    Ticket_ID INT REFERENCES Tickets(Ticket_ID),
--    User_ID INT REFERENCES [User](User_ID),
--    Action VARCHAR(100),
--    OldValue VARCHAR(2000) NULL,
--    NewValue VARCHAR(2000) NULL,
--    Change_Date DATETIME DEFAULT GETDATE()
--);

--CREATE PROC USP_GETTicketHistory
--    @Ticket_ID INT
--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- Validate Ticket
--    IF NOT EXISTS (SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
--    BEGIN
--        RAISERROR('Invalid Ticket_ID. Ticket does not exist.', 16, 1);
--        RETURN;
--    END;

--    -- Fetch history with user details
--    SELECT 
--        H.History_ID,
--        H.Ticket_ID,
--        U.User_ID,
--        U.User_name,
--        H.Action,
--        H.OldValue,
--        H.NewValue,
--        H.Change_Date
--    FROM TicketHistory H
--    INNER JOIN [User] U ON H.User_ID = U.User_ID
--    WHERE H.Ticket_ID = @Ticket_ID
--    ORDER BY H.Change_Date DESC;
--END;
--GO
--------------------------------------------------------------------------------------------------------------------

CREATE PROC USP_GETDocumentAttachment
    @Ticket_ID INT
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS(SELECT 1 FROM Tickets WHERE Tickets.Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket Not Found', 16, 1)
        RETURN;
    END; 
    SELECT D.Doc_ID, D.Ticket_ID, D.File_Url, T.Ticket_ID AS Ticket_Number, T.Ticket_Title, T.Ticket_Desc, T.Create_Date 
    FROM Document D INNER JOIN Tickets T ON D.Ticket_ID = T.Ticket_ID WHERE D.Ticket_ID = @Ticket_ID;
END;

EXEC USP_GETDocumentAttachment 8;


CREATE PROC USP_GetUserDetails
    @User_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS(SELECT 1 FROM [User] WHERE [User].[User_ID] = @User_ID)
    BEGIN
        RAISERROR('Invalid User_ID. User Not Found', 16, 1)
        RETURN;
    END;
    SELECT U.[User_ID], U.[User_Name], U.Email, U.Ph_No, U.Join_Date, UT.Role As User_Role, D.Dept_name 
    FROM [User] U LEFT JOIN UserType UT ON U.UT_ID = UT.UT_ID LEFT JOIN Department D ON U.Dept_ID = D.Dept_ID WHERE U.[User_ID] = @User_ID;
END;

EXEC USP_GetUserDetails 4;


CREATE PROC USP_GETTicketDetails
    @Ticket_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS(SELECT 1 FROM Tickets WHERE Tickets.Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID, Ticket Not Found.', 16, 1)
        RETURN;
    END;
     SELECT 
        T.Ticket_ID,
        T.Ticket_Title,
        T.Ticket_Desc,
        T.Create_Date,
        T.End_Date,
        T.ETA,
        S.Status AS Current_Status,
        P.priority AS Ticket_Priority,
        C.Category AS Ticket_Category,
        C.ETA_per_Cat,
        U.User_ID AS Agent_ID,
        U.User_name AS Agent_Name,
        D.dept_name AS Agent_Department,
        R.Review,
        R.Rating
    FROM Tickets T
    LEFT JOIN [Status] S ON T.Status_ID = S.Status_ID
    LEFT JOIN Priority P ON T.Ticket_Prio_ID = P.Prio_ID
    LEFT JOIN Category C ON T.Ticket_Category = C.Category_ID
    LEFT JOIN [User] U ON T.Agent_ID = U.User_ID
    LEFT JOIN Department D ON U.Dept_ID = D.Dept_ID
    LEFT JOIN Reviews R ON T.Review_ID = R.Review_ID
    WHERE T.Ticket_ID = @Ticket_ID;
    SELECT 
        C.Comment_ID,
        C.content AS Comment,
        C.Ticket_ID
    FROM Comment C
    WHERE C.Ticket_ID = @Ticket_ID;
    SELECT 
        D.Doc_ID,
        D.File_Url,
        D.Ticket_ID
    FROM Document D
    WHERE D.Ticket_ID = @Ticket_ID;
    SELECT 
        N.N_ID,
        N.Message,
        N.User_ID,
        U.User_name
    FROM Notification N
    LEFT JOIN [User] U ON N.User_ID = U.User_ID
    WHERE N.Ticket_ID = @Ticket_ID;
END;

EXEC USP_GETTicketDetails 8;


CREATE PROC USP_CreateAgent
    @User_ID INT,
    @Dept_ID INT,
    @UT_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE [User_ID] = @User_ID )
    BEGIN
        RAISERROR('Invalid User_ID. User NOT FOUND', 16, 1)
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Department WHERE Dept_ID = @Dept_ID)
    BEGIN
        RAISERROR('Invalid Dept_ID. Department Not Found.', 16, 1)
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM UserType WHERE UT_ID = @UT_ID)
    BEGIN
        RAISERROR('Invalid UT_ID. UserType Not Found', 16, 1)
        RETURN;
    END
    UPDATE [User]
    SET Dept_ID = @Dept_ID, UT_ID = @UT_ID WHERE [USER_ID] = @User_ID;
    PRINT 'User Updated as an Agent'
END;

CREATE PROC USP_AssignAgent
    @Ticket_ID INT,
    @Agent_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS(SELECT 1 FROM Tickets WHERE Ticket_ID = @Ticket_ID)
    BEGIN
        RAISERROR('Invalid Ticket_ID. Ticket Not Found', 16, 1)
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE [User_ID] = @Agent_ID)
    BEGIN
        RAISERROR('Invalid Agent_ID. Agent Not Found', 16, 1)
    END
    UPDATE Tickets
    SET Agent_ID = @Agent_ID WHERE Ticket_ID = @Ticket_ID;
    PRINT 'Agent successfuly assigned to the Ticket';
END;


ALTER PROC USP_CreateDepartment
    @Dept_ID INT,
    @Dept_Name VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM Department WHERE Dept_Name = @Dept_Name)
    BEGIN
        RAISERROR('Department already exists', 16, 1)
        RETURN;
    END
    INSERT INTO Department(Dept_ID,Dept_Name) VALUES(@Dept_ID,@Dept_Name);
    SELECT SCOPE_IDENTITY() AS New_Dept_ID;
END;

EXEC USP_CreateDepartment 2,'Management';


--SELECT * FROM Department


CREATE PROC USP_CreatePrio
    @Prio_ID INT,
    @priority VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(SELECT 1 FROM [Priority] WHERE [priority] = @priority)
    BEGIN
        RAISERROR('Priority Already exists', 16, 1)
        RETURN;
    END
    INSERT INTO [Priority] (Prio_ID, [priority]) VALUES(@Prio_ID, @priority)
    SELECT SCOPE_IDENTITY() AS New_Prio;
END;

EXEC USP_CreatePrio 4, 'test';


CREATE PROC USP_CreateCategory
    @Category VARCHAR(20),
    @ETA VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Category WHERE Category = @Category)
    BEGIN
        RAISERROR('Category Already Exists',16,1)
        RETURN;
    END
    INSERT INTO Category(Category, ETA_per_Cat) VALUES (@Category, @ETA)
    SELECT SCOPE_IDENTITY() AS New_Category
END;

EXEC USP_CreateCategory 'test', '1 day';


CREATE PROC USP_ModifyPrio
    @Prio_ID INT,
    @NewPrioName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS(SELECT 1 FROM [Priority] WHERE Prio_ID = @Prio_ID)
    BEGIN
        RAISERROR('Invalid Prio_ID. Priority not found',16,1)
        RETURN;
    END;
    IF EXISTS(SELECT 1 FROM [Priority] WHERE [priority] = @NewPrioName AND Prio_ID <> @Prio_ID)
    BEGIN
        RAISERROR('Priority with this name already exists.', 16, 1)
        RETURN;
    END;
    UPDATE [Priority]
    SET [priority] = @NewPrioName
    WHERE Prio_ID = @Prio_ID;
    PRINT 'Priority Updated';
END;


CREATE PROC USP_ModifyDepartment
    @Dept_ID INT,
    @new_dept_name VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS(SELECT 1 FROM Department WHERE Dept_ID = @Dept_ID)
    BEGIN
        RAISERROR('Invalid Dept_ID. Department not found.', 16, 1)
        RETURN;
    END;
    IF EXISTS(SELECT 1 FROM Department WHERE dept_name = @new_dept_name AND Dept_ID <> @Dept_ID)
    BEGIN
        RAISERROR('Department with this name already exists.', 16, 1)
        RETURN;
    END;
    UPDATE Department
    SET dept_name = @new_dept_name
    WHERE Dept_ID = @Dept_ID;
    PRINT 'Department Updated.';
END;


CREATE PROC USP_UserReports
    @User_ID INT,
    @ReportType VARCHAR(20)   -- 'SUMMARY', 'RECENT', 'WEEKLY', 'MONTHLY', 'AVG_ETA'
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM [User] WHERE User_ID = @User_ID)
    BEGIN
        RAISERROR('Invalid User_ID. User does not exist.', 16, 1);
        RETURN;
    END;
    IF @ReportType = 'SUMMARY'
    BEGIN
        SELECT 
            S.Status,
            COUNT(*) AS TotalTickets
        FROM Tickets T
        INNER JOIN [Status] S ON T.Status_ID = S.Status_ID
        INNER JOIN UserTicketMaping M ON T.Ticket_ID = M.Ticket_ID
        WHERE M.User_ID = @User_ID
        GROUP BY S.Status;
        RETURN;
    END;
    IF @ReportType = 'RECENT'
    BEGIN
        SELECT TOP 10
            T.Ticket_ID,
            T.Ticket_Title,
            T.Ticket_Desc,
            T.Create_Date,
            U.User_name AS Assigned_Agent
        FROM Tickets T
        INNER JOIN UserTicketMaping M ON T.Ticket_ID = M.Ticket_ID
        LEFT JOIN [User] U ON T.Agent_ID = U.User_ID
        WHERE M.User_ID = @User_ID
        ORDER BY T.Create_Date DESC;
        RETURN;
    END;
    IF @ReportType = 'WEEKLY'
    BEGIN
        SELECT 
            DATEPART(WEEK, T.Create_Date) AS WeekNumber,
            COUNT(*) AS TicketsCreated
        FROM Tickets T
        INNER JOIN UserTicketMaping M ON T.Ticket_ID = M.Ticket_ID
        WHERE M.User_ID = @User_ID
          AND T.Create_Date >= DATEADD(WEEK, -4, GETDATE()) -- last 4 weeks
        GROUP BY DATEPART(WEEK, T.Create_Date)
        ORDER BY WeekNumber;
        RETURN;
    END;
    IF @ReportType = 'MONTHLY'
    BEGIN
        SELECT 
            DATENAME(MONTH, T.Create_Date) AS MonthName,
            COUNT(*) AS TicketsCreated
        FROM Tickets T
        INNER JOIN UserTicketMaping M ON T.Ticket_ID = M.Ticket_ID
        WHERE M.User_ID = @User_ID
          AND T.Create_Date >= DATEADD(MONTH, -6, GETDATE()) -- last 6 months
        GROUP BY DATENAME(MONTH, T.Create_Date), DATEPART(MONTH, T.Create_Date)
        ORDER BY DATEPART(MONTH, T.Create_Date);
        RETURN;
    END;
    IF @ReportType = 'AVG_ETA'
    BEGIN
        SELECT 
            AVG(DATEDIFF(HOUR, T.Create_Date, T.End_Date)) AS Avg_ETA_Hours
        FROM Tickets T
        INNER JOIN UserTicketMaping M ON T.Ticket_ID = M.Ticket_ID
        WHERE M.User_ID = @User_ID
          AND T.End_Date IS NOT NULL;
        RETURN;
    END;
    RAISERROR('Invalid ReportType. Use SUMMARY, RECENT, WEEKLY, MONTHLY, AVG_ETA.', 16, 1);
END;


EXEC USP_UserReports 4, 'RECENT';

SELECT * FROM UserTicketMaping;






    



























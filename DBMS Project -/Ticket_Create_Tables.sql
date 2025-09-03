CREATE DATABASE Ticketing_Tool;
USE Ticketing_Tool;

CREATE TABLE [User]
(
[User_ID] INT PRIMARY KEY IDENTITY(1,1),
[User_name] VARCHAR(25),
UT_ID INT REFERENCES UserType(UT_ID),
Dept_ID INT REFERENCES Department(Dept_ID),
Email VARCHAR(320),
CONSTRAINT chk_email CHECK(Email LIKE '___%@___%.__%'),
Ph_No VARCHAR(15),
[Password] VARCHAR(100),
Join_Date DATE
);



CREATE TABLE Tickets
(
Ticket_ID INT PRIMARY KEY IDENTITY(1,1),
Status_ID INT REFERENCES [Status](Status_ID),
Review_ID INT REFERENCES Reviews(Review_ID),
Ticket_Title VARCHAR(100),
Ticket_Desc VARCHAR(250),
Ticket_Prio_ID INT REFERENCES Priority(Prio_ID),
Ticket_Category INT REFERENCES Category(Category_ID),
Create_Date DATE,
End_Date DATE,
ETA TIME,
Agent_ID INT REFERENCES [User]([User_ID])
);


CREATE TABLE Document
(
Doc_ID INT PRIMARY KEY IDENTITY(1,1),
Ticket_ID INT REFERENCES Tickets(Ticket_ID),
File_Url VARCHAR(100)
);

CREATE TABLE [Status]
(
Status_ID INT PRIMARY KEY IDENTITY(1,1),
[Status] VARCHAR(20),
);

INSERT INTO [Status](Status) VALUES('Ongoing')

CREATE TABLE Category
(
Category_ID INT PRIMARY KEY IDENTITY(1,1),
Category VARCHAR(20),
ETA_per_Cat VARCHAR(20)
);

INSERT INTO Category(Category,ETA_per_Cat) VALUES('Urgent_Need', '10 days')

CREATE TABLE [Priority]
(
Prio_ID INT PRIMARY KEY,
[priority] VARCHAR(10)
);

INSERT INTO Priority(Prio_ID, [priority]) VALUES(1,'Low'),(2,'Medium'),(3,'High')

CREATE TABLE Comment
(
Comment_ID INT PRIMARY KEY IDENTITY(1,1),
Ticket_ID INT REFERENCES Tickets(Ticket_ID),
content VARCHAR(2000)
);

CREATE TABLE [Notification]
(
N_ID INT PRIMARY KEY IDENTITY(1,1),
[USER_ID] INT REFERENCES [User]([User_ID]),
Ticket_ID INT REFERENCES Tickets(Ticket_ID),
[Message] VARCHAR(500)
);



CREATE TABLE Reviews
(
Review_ID INT PRIMARY KEY IDENTITY(1,1),
Review VARCHAR(2000),
Rating INT,
CONSTRAINT Check_Rating CHECK(Rating >=1 AND Rating <=5)
);

CREATE TABLE UserTicketMaping
(
Map_ID INT PRIMARY KEY IDENTITY(1,1),
[User_ID] INT REFERENCES [User]([User_ID]),
Ticket_ID INT REFERENCES Tickets(Ticket_ID)
);


CREATE TABLE UserType
(
UT_ID INT PRIMARY KEY,
Role VARCHAR(15)
);

CREATE TABLE Department
(
Dept_ID INT PRIMARY KEY,
dept_name VARCHAR(25)
);


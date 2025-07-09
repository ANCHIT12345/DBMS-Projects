CREATE TABLE Test2
(
EmployeeId INT PRIMARY KEY AUTO_INCREMENT,
EmployeeName VARCHAR(50), 
Design VARCHAR(25),
ManagerId INT,
JoiningDate DATE
);

DROP TABLE Test2;

INSERT INTO Test2(EmployeeName, Design, ManagerId, JoiningDate)
VALUES
('Akash', 'CEO', NULL, '2020-01-01'),
('Rohit', 'CTO', 1, '2020-02-01'),
('Ankit', 'VP', 2, '2020-02-01'),
('Amit', 'SeniorManager', 3, '2020-02-01'),
('Alok', 'Sr. Engineer', 4, '2020-02-01');


-- EmployeeName, ManagerName, Joining Date
SELECT t2.EmployeeName, t1.EmployeeName ManagerName, t2.JoiningDate
FROM Test2 t2, Test2 t1
WHERE t1.EmployeeId = t2.ManagerId
;

SELECT *
FROM Test2 t2, Test2 t1
WHERE t1.ManagerId IS NULL OR t1.EmployeeId = t2.EmployeeId
;

SELECT t2.EmployeeName, t1.EmployeeName ManagerName, t2.JoiningDate
FROM Test2 t2, Test2 t1
WHERE t1.EmployeeId <> t2.ManagerId 
AND t1.EmployeeId = t2.ManagerId
;












-- DROP DATABASE IF EXISTS `Healthcare`;
-- CREATE DATABASE `Healthcare`;
-- USE `Healthcare`;


CREATE TABLE Patients
(
Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
Patient_Name VARCHAR(50),
AGE INT NOT NULL,
DOB DATE NOT NULL,
Blood_Group  ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
Gender ENUM('Male', 'Female', 'Other') NOT NULL,
Patient_Mobile_Number VARCHAR(10) UNIQUE NOT NULL,
Patient_Email VARCHAR(641) UNIQUE DEFAULT NULL, 
Address TEXT,
Appointment_Date_AND_TIME DATETIME NOT NULL,
Disease VARCHAR(100)
);

SELECT * FROM Patients WHERE Blood_Group LIKE 'A+' OR Blood_Group LIKE 'O-' OR Blood_Group LIKE 'B+';
SELECT * FROM Patients WHERE Blood_Group IN('A+','O-','B+');

DROP TABLE Patients;

INSERT INTO Patients (
  Patient_Name, AGE, DOB, Blood_Group, Gender, Patient_Mobile_Number, 
  Patient_Email, Address, Appointment_Date_AND_TIME, Disease
) VALUES
('Ravi Kumar', 34, '1991-08-15', 'O+', 'Male', 9876543210, 'ravi.kumar@example.com', 'Delhi, India', '2025-06-18 10:00:00', 'Diabetes'),
('Anita Sharma', 28, '1997-01-22', 'A+', 'Female', 9876543211, 'anita.sharma@example.com', 'Mumbai, India', '2025-06-19 11:30:00', 'Hypertension'),
('Karan Mehta', 45, '1980-05-10', 'B-', 'Male', 9876543212, 'karan.mehta@example.com', 'Ahmedabad, India', '2025-06-20 09:45:00', 'Arthritis'),
('Pooja Singh', 30, '1995-12-01', 'AB+', 'Female', 9876543213, 'pooja.singh@example.com', 'Bangalore, India', '2025-06-21 14:00:00', 'Migraine'),
('Rahul Verma', 22, '2003-03-03', 'O-', 'Male', 9876543214, 'rahul.verma@example.com', 'Pune, India', '2025-06-18 16:15:00', 'Allergy'),
('Sneha Patel', 37, '1988-10-12', 'A-', 'Female', 9876543215, 'sneha.patel@example.com', 'Hyderabad, India', '2025-06-22 13:30:00', 'Thyroid'),
('Vikas Reddy', 50, '1975-07-19', 'B+', 'Male', 9876543216, 'vikas.reddy@example.com', 'Chennai, India', '2025-06-23 10:30:00', 'Asthma'),
('Deepika Nair', 26, '1999-04-25', 'AB-', 'Female', 9876543217, 'deepika.nair@example.com', 'Kochi, India', '2025-06-24 11:00:00', 'PCOD'),
('Rohan Gupta', 31, '1994-09-14', 'O+', 'Male', 9876543218, 'rohan.gupta@example.com', 'Lucknow, India', '2025-06-25 12:00:00', 'Back Pain'),
('Aisha Khan', 29, '1996-11-09', 'A+', 'Female', 9876543219, DEFAULT, 'Bhopal, India', '2025-06-26 09:00:00', 'Fever'),
('Aditya Joshi', 40, '1985-02-18', 'O-', 'Male', 9876543220, 'aditya.joshi@example.com', 'Nagpur, India', '2025-06-27 15:30:00', 'Diabetes'),
('Neha Agarwal', 33, '1992-06-30', 'B+', 'Female', 9876543221, DEFAULT, 'Indore, India', '2025-06-28 17:00:00', 'Anxiety'),
('Siddharth Desai', 38, '1987-07-07', 'A-', 'Male', 9876543222, 'siddharth.desai@example.com', 'Goa, India', '2025-06-29 10:45:00', 'Cholesterol'),
('Tanya Jain', 24, '2001-01-01', 'AB+', 'Female', 9876543223, 'tanya.jain@example.com', 'Jaipur, India', '2025-06-30 12:45:00', 'Cold'),
('Mohit Sinha', 35, '1990-08-08', 'O+', 'Male', 9876543224, 'mohit.sinha@example.com', 'Surat, India', '2025-07-01 09:30:00', 'Cough'),
('Priya Das', 27, '1998-03-11', 'B-', 'Female', 9876543225, DEFAULT, 'Ranchi, India', '2025-07-02 14:30:00', 'Sinus'),
('Aman Tripathi', 32, '1993-10-10', 'A+', 'Male', 9876543226, 'aman.tripathi@example.com', 'Kanpur, India', '2025-07-03 13:00:00', 'Migraine'),
('Nikita Bhatt', 29, '1996-05-20', 'AB-', 'Female', 9876543227, 'nikita.bhatt@example.com', 'Dehradun, India', '2025-07-04 11:15:00', 'Skin Allergy'),
('Rajeev Nair', 48, '1977-06-06', 'O-', 'Male', 9876543228, DEFAULT, 'Trivandrum, India', '2025-07-05 10:15:00', 'Blood Pressure'),
('Divya Iyer', 36, '1989-12-05', 'B+', 'Female', 9876543229, 'divya.iyer@example.com', 'Mysore, India', '2025-07-06 15:45:00', 'Flu');
-- asked chatgpt to create dataset for me (Insert part)

SELECT * FROM Patients;

CREATE TABLE Doctors
(
Doctor_ID INT PRIMARY KEY AUTO_INCREMENT,
Doctor_Name VARCHAR(50),
Specialization VARCHAR(100),
Doctor_Email VARCHAR(641) UNIQUE DEFAULT 'xyzhospital@example.com',
Doctor_Mobile_Number VARCHAR(10) UNIQUE NOT NULL,
Availability VARCHAR(100) 
);

ALTER TABLE Doctors 
ADD COLUMN Specialize_IN_Surgery ENUM('YES', 'NO') DEFAULT 'NO';

DROP TABLE Doctors;

INSERT INTO Doctors (
  Doctor_Name, Specialization, Doctor_Email, Doctor_Mobile_Number, Availability
) VALUES
('Dr. Ayesha Sharma', 'Cardiologist', 'ayesha.sharma@xyzhospital.com', 9123456701, 'Mon-Fri 10:00 AM - 4:00 PM'),
('Dr. Ravi Deshmukh', 'Dermatologist', 'ravi.deshmukh@xyzhospital.com', 9123456702, 'Tue-Thu 11:00 AM - 5:00 PM'),
('Dr. Sneha Reddy', 'Pediatrician', 'sneha.reddy@xyzhospital.com', 9123456703, 'Mon-Sat 9:00 AM - 1:00 PM'),
('Dr. Aman Kapoor', 'Orthopedic Surgeon', 'aman.kapoor@xyzhospital.com', 9123456704, 'Mon-Wed-Fri 2:00 PM - 6:00 PM'),
('Dr. Pooja Iyer', 'Gynecologist', 'pooja.iyer@xyzhospital.com', 9123456705, 'Mon-Fri 10:00 AM - 3:00 PM'),
('Dr. Mohan Patil', 'Neurologist', 'mohan.patil@xyzhospital.com', 9123456706, 'Wed-Fri 12:00 PM - 6:00 PM'),
('Dr. Neha Verma', 'ENT Specialist', 'neha.verma@xyzhospital.com', 9123456707, 'Tue-Thu 9:00 AM - 12:00 PM'),
('Dr. Arjun Sinha', 'Urologist', 'arjun.sinha@xyzhospital.com', 9123456708, 'Mon-Fri 3:00 PM - 7:00 PM'),
('Dr. Kavita Mehta', 'Psychiatrist', 'kavita.mehta@xyzhospital.com', 9123456709, 'Mon-Wed-Fri 10:00 AM - 2:00 PM'),
('Dr. Sanjay Rao', 'Oncologist', 'sanjay.rao@xyzhospital.com', 9123456710, 'Mon-Fri 11:00 AM - 5:00 PM'),
('Dr. Ritu Das', 'Endocrinologist', 'ritu.das@xyzhospital.com', 9123456711, 'Tue-Thu-Sat 1:00 PM - 5:00 PM'),
('Dr. Raj Malhotra', 'Gastroenterologist', 'raj.malhotra@xyzhospital.com', 9123456712, 'Mon-Fri 9:00 AM - 1:00 PM'),
('Dr. Nisha George', 'Pulmonologist', 'nisha.george@xyzhospital.com', 9123456713, 'Wed-Fri 2:00 PM - 6:00 PM'),
('Dr. Anil Thomas', 'Nephrologist', 'anil.thomas@xyzhospital.com', 9123456714, 'Mon-Thu 11:00 AM - 3:00 PM'),
('Dr. Tanya Bhatt', 'General Physician', DEFAULT, 9123456715, 'Mon-Sat 10:00 AM - 5:00 PM');
-- asked chatgpt to create dataset for me (Insert part)

SELECT * FROM Doctors;

CREATE TABLE Appointments
(
Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
Patient_ID INT,
FOREIGN KEY (Patient_ID ) REFERENCES Patients(Patient_ID),
Doctor_ID INT,
FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID),
Appointment_Date DATETIME NOT NULL,
Status ENUM('Scheduled', 'Completed', 'Cancelled'),
Remarks TEXT
);

DROP TABLE Appointments;

SELECT * FROM Appointments;
SELECT * FROM Appointments WHERE Appointment_Date BETWEEN '2024-12-01 00:00:00' AND '2025-01-31 23:59:59';
SELECT * FROM Appointments WHERE Appointment_Date BETWEEN '2024-12-21 00:00:00' AND NOW();

INSERT INTO Appointments(Patient_ID, Doctor_ID, Appointment_Date, Status, Remarks)
VALUES
(1, 1, '2025-06-18 10:00:00', 'Scheduled', 'Initial consultation'),
(2, 2, '2025-06-19 11:30:00', 'Completed', 'Follow-up in 2 weeks'),
(3, 3, '2025-06-20 09:45:00', 'Scheduled', 'X-ray recommended'),
(4, 4, '2025-06-21 14:00:00', 'Cancelled', 'Rescheduled by patient'),
(5, 5, '2025-06-18 16:15:00', 'Completed', 'Mild allergy detected'),
(6, 6, '2025-06-22 13:30:00', 'Scheduled', 'Thyroid test prescribed'),
(7, 7, '2025-06-23 10:30:00', 'Completed', 'Asthma under control'),
(8, 8, '2025-06-24 11:00:00', 'Scheduled', 'PCOD management plan'),
(9, 9, '2025-06-25 12:00:00', 'Scheduled', 'MRI recommended'),
(10, 10, '2025-06-26 09:00:00', 'Scheduled', 'Fever subsided'),
(11, 11, '2025-06-27 15:30:00', 'Completed', 'Diet plan advised'),
(12, 12, '2025-06-28 17:00:00', 'Cancelled', 'Patient no-show'),
(13, 13, '2025-06-29 10:45:00', 'Scheduled', 'Cholesterol normal'),
(14, 14, '2025-06-30 12:45:00', 'Scheduled', 'Cold symptoms treated'),
(15, 15, '2025-07-01 09:30:00', 'Completed', 'No infection found'),
(16, 1, '2025-07-02 14:30:00', 'Scheduled', 'Sinus test advised'),
(17, 2, '2025-07-03 13:00:00', 'Scheduled', 'Stress-related migraine'),
(18, 3, '2025-07-04 11:15:00', 'Scheduled', 'Skin irritation treated'),
(19, 4, '2025-07-05 10:15:00', 'Scheduled', 'BP under control'),
(20, 5, '2025-07-06 15:45:00', 'Completed', 'Flu treated successfully');
-- asked chatgpt to create dataset for me (Insert part)

SELECT * FROM Appointments;

SELECT * FROM Appointments WHERE STATUS LIKE 'Scheduled';

UPDATE Appointments
SET STATUS = 'Completed'
WHERE STATUS ='Scheduled'
	AND Appointment_Date < NOW();


SELECT * 
FROM Appointments
WHERE STATUS ='Scheduled'
	AND Appointment_Date < NOW();


INSERT INTO Patients (
  Patient_Name, AGE, DOB, Blood_Group, Gender,
  Patient_Mobile_Number, Patient_Email, Address,
  Appointment_Date_AND_TIME, Disease
) VALUES
('Amit Rathi', 31, '1993-11-11', 'A+', 'Male', '9000001025', 'amit.rathi@example.com', 'Kolkata', '2023-06-21 16:30:00', 'Cough'),
('Neeta Bhatt', 31, '1993-09-17', 'AB+', 'Female', '9000001034', 'neeta.bhatt@example.com', 'Surat', '2024-01-05 09:30:00', 'PCOD'),
('Rajeev Sinha', 40, '1984-07-18', 'B+', 'Male', '9000001023', 'rajeev.sinha@example.com', 'Pune', '2023-07-12 09:45:00', 'Hypertension'),
('Priya Jha', 27, '1997-06-06', 'A+', 'Female', '9000001040', 'priya.jha@example.com', 'Amritsar', '2024-01-25 10:30:00', 'Acne'),
('Manoj Kumar', 34, '1990-02-28', 'B+', 'Male', '9000001033', 'manoj.kumar@example.com', 'Patna', '2023-12-15 13:00:00', 'Fatigue'),
('Ruchi Verma', 29, '1995-11-11', 'A-', 'Female', '9000001036', 'ruchi.verma@example.com', 'Agra', '2023-12-20 15:00:00', 'Flu'),
('Sneha Iyer', 29, '1995-05-20', 'AB+', 'Female', '9000001024', 'sneha.iyer@example.com', 'Hyderabad', '2023-07-18 14:00:00', 'Skin Allergy'),
('Aditya Rao', 36, '1988-10-10', 'O+', 'Male', '9000001037', 'aditya.rao@example.com', 'Noida', '2023-12-28 16:00:00', 'Cough'),
('Pallavi Joshi', 26, '1998-07-12', 'A+', 'Female', '9000001032', 'pallavi.joshi@example.com', 'Jaipur', '2023-12-12 14:00:00', 'UTI'),
('Meera Das', 25, '1999-08-08', 'AB-', 'Female', '9000001028', 'meera.das@example.com', 'Ranchi', '2023-06-13 09:00:00', 'Stomach pain'),

('Farhan Ansari', 42, '1982-06-19', 'B-', 'Male', '9000001035', 'farhan.ansari@example.com', 'Lucknow', '2024-01-10 12:45:00', 'Chest Pain'),
('Komal Yadav', 33, '1991-04-04', 'AB-', 'Female', '9000001038', 'komal.yadav@example.com', 'Kanpur', '2024-01-15 14:30:00', 'Body ache'),
('Karan Patel', 35, '1989-01-01', 'O+', 'Male', '9000001021', 'karan.patel@example.com', 'Mumbai', '2023-06-10 10:00:00', 'Migraine'),
('Imran Qureshi', 39, '1985-08-05', 'B+', 'Male', '9000001039', 'imran.qureshi@example.com', 'Indore', '2024-01-20 10:00:00', 'Blood Pressure'),
('Divya Nair', 27, '1997-02-14', 'A-', 'Female', '9000001022', 'divya.nair@example.com', 'Delhi', '2023-06-15 11:30:00', 'Asthma'),
('Nikhil Jain', 30, '1994-04-30', 'O+', 'Male', '9000001029', 'nikhil.jain@example.com', 'Ahmedabad', '2023-07-16 15:30:00', 'Fever'),
('Reshma Shaikh', 28, '1996-10-22', 'A+', 'Female', '9000001030', 'reshma.shaikh@example.com', 'Nagpur', '2023-07-19 17:00:00', 'Weakness'),
('Suresh Meena', 37, '1987-12-10', 'B-', 'Male', '9000001027', 'suresh.meena@example.com', 'Bhopal', '2023-07-09 12:00:00', 'Thyroid'),
('Anita George', 43, '1981-03-25', 'O-', 'Female', '9000001026', 'anita.george@example.com', 'Chennai', '2023-06-06 13:00:00', 'Diabetes'),
('Vikas Sharma', 38, '1986-03-03', 'O-', 'Male', '9000001031', 'vikas.sharma@example.com', 'Guwahati', '2023-12-10 11:00:00', 'Joint Pain'),

-- ⏱️ 3 months ago (March 2024)
('Geeta Sharma', 32, '1992-01-15', 'A+', 'Female', '9000001041', 'geeta.sharma@example.com', 'Shimla', '2024-03-04 11:00:00', 'Fever'),
('Yusuf Khan', 28, '1996-04-25', 'B+', 'Male', '9000001042', 'yusuf.khan@example.com', 'Delhi', '2024-03-07 10:30:00', 'Back Pain'),
('Ritika Mehra', 29, '1995-07-01', 'AB+', 'Female', '9000001043', 'ritika.mehra@example.com', 'Bangalore', '2024-03-10 09:00:00', 'Cold'),
('Arjun Reddy', 36, '1988-06-17', 'O-', 'Male', '9000001044', 'arjun.reddy@example.com', 'Vizag', '2024-03-14 13:15:00', 'Throat infection'),
('Simran Gill', 30, '1994-05-23', 'A-', 'Female', '9000001045', 'simran.gill@example.com', 'Ludhiana', '2024-03-18 14:45:00', 'Allergy'),
('Zaid Shaikh', 26, '1998-02-11', 'B-', 'Male', '9000001046', 'zaid.shaikh@example.com', 'Nashik', '2024-03-20 10:00:00', 'Headache'),
('Tanvi Desai', 35, '1989-09-19', 'A+', 'Female', '9000001047', 'tanvi.desai@example.com', 'Goa', '2024-03-22 11:15:00', 'Migraine'),
('Rohit Shetty', 33, '1991-12-30', 'O+', 'Male', '9000001048', 'rohit.shetty@example.com', 'Mangalore', '2024-03-25 15:45:00', 'Stomach upset'),
('Ayesha Mirza', 27, '1997-08-16', 'AB-', 'Female', '9000001049', 'ayesha.mirza@example.com', 'Aligarh', '2024-03-27 09:30:00', 'Sinus'),
('Kabir Thakur', 31, '1993-03-29', 'B+', 'Male', '9000001050', 'kabir.thakur@example.com', 'Raipur', '2024-03-30 12:30:00', 'Low BP'),

-- ⏱️ 1 month ago (May 2025)
('Nandini Menon', 29, '1995-06-12', 'A+', 'Female', '9000001051', 'nandini.menon@example.com', 'Ernakulam', '2025-05-01 10:00:00', 'Viral Fever'),
('Suraj Nair', 34, '1990-10-03', 'O-', 'Male', '9000001052', 'suraj.nair@example.com', 'Thiruvananthapuram', '2025-05-05 11:30:00', 'Cold'),
('Mitali Roy', 26, '1998-01-20', 'AB+', 'Female', '9000001053', 'mitali.roy@example.com', 'Howrah', '2025-05-08 09:00:00', 'Cough'),
('Devansh Jain', 28, '1996-07-17', 'B-', 'Male', '9000001054', 'devansh.jain@example.com', 'Udaipur', '2025-05-11 10:45:00', 'Headache'),
('Rhea Kapoor', 31, '1993-11-09', 'A-', 'Female', '9000001055', 'rhea.kapoor@example.com', 'Ajmer', '2025-05-13 12:15:00', 'Indigestion'),
('Kunal Mathur', 37, '1987-04-04', 'B+', 'Male', '9000001056', 'kunal.mathur@example.com', 'Panaji', '2025-05-17 14:00:00', 'Throat pain'),
('Ishita Bose', 30, '1994-09-26', 'O+', 'Female', '9000001057', 'ishita.bose@example.com', 'Durgapur', '2025-05-20 16:30:00', 'Fatigue'),
('Tariq Hussain', 40, '1984-02-05', 'A+', 'Male', '9000001058', 'tariq.hussain@example.com', 'Srinagar', '2025-05-23 10:30:00', 'Skin rash'),
('Saloni Singh', 33, '1991-01-11', 'B-', 'Female', '9000001059', 'saloni.singh@example.com', 'Jamshedpur', '2025-05-26 11:00:00', 'Sore throat'),
('Hrithik Das', 36, '1988-08-08', 'AB+', 'Male', '9000001060', 'hrithik.das@example.com', 'Dhanbad', '2025-05-30 13:00:00', 'Mild fever');


INSERT INTO Appointments (
  Patient_ID, Doctor_ID, Appointment_Date, Status, Remarks
) VALUES
(21, 13, '2024-07-22 00:00:00', 'Scheduled', 'Initial consultation'),
(22, 7,  '2024-04-23 00:00:00', 'Scheduled', 'Initial consultation'),
(23, 8,  '2024-04-23 00:00:00', 'Scheduled', 'Follow-up'),
(24, 6,  '2024-11-19 00:00:00', 'Scheduled', 'Initial consultation'),
(25, 10, '2024-11-19 00:00:00', 'Scheduled', 'Follow-up'),
(26, 11, '2024-04-23 00:00:00', 'Completed', 'Initial consultation'),
(27, 7,  '2024-11-19 00:00:00', 'Completed', 'Routine checkup'),
(28, 6,  '2024-07-22 00:00:00', 'Cancelled', 'Initial consultation'),
(29, 15, '2024-04-23 00:00:00', 'Scheduled', 'Follow-up'),
(30, 6,  '2024-07-22 00:00:00', 'Cancelled', 'Reported mild symptoms'),
(31, 13, '2024-04-23 00:00:00', 'Completed', 'Routine checkup'),
(32, 9,  '2024-07-22 00:00:00', 'Scheduled', 'Routine checkup'),
(33, 11, '2024-04-23 00:00:00', 'Scheduled', 'Follow-up'),
(34, 6,  '2024-11-19 00:00:00', 'Completed', 'Initial consultation'),
(35, 1,  '2024-04-23 00:00:00', 'Scheduled', 'Routine checkup'),
(36, 14, '2024-11-19 00:00:00', 'Completed', 'Reported mild symptoms'),
(37, 4,  '2024-11-19 00:00:00', 'Cancelled', 'Initial consultation'),
(38, 5,  '2024-07-22 00:00:00', 'Scheduled', 'Initial consultation'),
(39, 7,  '2024-04-23 00:00:00', 'Completed', 'Reported mild symptoms'),
(40, 3,  '2024-07-22 00:00:00', 'Scheduled', 'Follow-up'),
(41, 8,  '2024-04-23 00:00:00', 'Cancelled', 'Routine checkup'),
(42, 10, '2024-07-22 00:00:00', 'Completed', 'Initial consultation'),
(43, 15, '2024-07-22 00:00:00', 'Scheduled', 'Follow-up'),
(44, 2,  '2024-04-23 00:00:00', 'Scheduled', 'Initial consultation'),
(45, 4,  '2024-11-19 00:00:00', 'Scheduled', 'Routine checkup'),
(46, 10, '2024-07-22 00:00:00', 'Completed', 'Follow-up'),
(47, 14, '2024-07-22 00:00:00', 'Completed', 'Reported mild symptoms'),
(48, 15, '2024-04-23 00:00:00', 'Scheduled', 'Routine checkup'),
(49, 6,  '2024-07-22 00:00:00', 'Cancelled', 'Follow-up'),
(50, 12, '2024-11-19 00:00:00', 'Scheduled', 'Routine checkup'),
(51, 1,  '2024-11-19 00:00:00', 'Completed', 'Follow-up'),
(52, 5,  '2024-07-22 00:00:00', 'Scheduled', 'Initial consultation'),
(53, 2,  '2024-07-22 00:00:00', 'Scheduled', 'Initial consultation'),
(54, 3,  '2024-07-22 00:00:00', 'Completed', 'Routine checkup'),
(55, 11, '2024-07-22 00:00:00', 'Scheduled', 'Reported mild symptoms'),
(56, 13, '2024-11-19 00:00:00', 'Scheduled', 'Routine checkup'),
(57, 5,  '2024-07-22 00:00:00', 'Cancelled', 'Initial consultation'),
(58, 8,  '2024-07-22 00:00:00', 'Scheduled', 'Follow-up'),
(59, 9,  '2024-07-22 00:00:00', 'Scheduled', 'Routine checkup'),
(60, 12, '2024-11-19 00:00:00', 'Scheduled', 'Reported mild symptoms');

ALTER TABLE Appointments
ADD COLUMN Admitted ENUM('YES','NO');
ALTER TABLE Appointments
ADD COLUMN Admitted_IN VARCHAR(50);

SELECT * FROM Appointments;

UPDATE Appointments
SET Admitted_IN = 'Not Admitted'
WHERE Admitted_IN IS NULL
;

SELECT * FROM Appointments WHERE Admitted_IN LIKE  'Cardiology';

INSERT INTO Appointments (
  Patient_ID, Doctor_ID, Appointment_Date, Status, Remarks, Admitted, Admitted_IN
) VALUES
(61, 2,  '2025-06-11 00:00:00', 'Scheduled', 'Routine checkup', 'YES', 'Orthopedics'),
(62, 9,  '2025-03-30 00:00:00', 'Scheduled', 'Initial consultation', 'NO', NULL),
(63, 7,  '2025-01-14 00:00:00', 'Cancelled', 'Routine checkup', 'YES', 'Neurology'),
(64, 11, '2025-01-08 00:00:00', 'Scheduled', 'Initial consultation', 'YES', 'Orthopedics'),
(65, 12, '2025-04-08 00:00:00', 'Completed', 'Routine checkup', 'YES', 'Psychiatry'),
(66, 2,  '2025-02-09 00:00:00', 'Completed', 'Routine checkup', 'NO', NULL),
(67, 7,  '2025-05-22 00:00:00', 'Scheduled', 'Follow-up', 'NO', NULL),
(68, 6,  '2025-04-18 00:00:00', 'Cancelled', 'Reported mild symptoms', 'YES', 'Gastroenterology'),
(69, 10, '2025-06-08 00:00:00', 'Completed', 'Reported mild symptoms', 'YES', 'Cardiology'),
(70, 5,  '2025-01-06 00:00:00', 'Scheduled', 'Initial consultation', 'NO', NULL),
(71, 6,  '2025-05-01 00:00:00', 'Cancelled', 'Reported mild symptoms', 'YES', 'General Medicine'),
(72, 1,  '2025-05-06 00:00:00', 'Cancelled', 'Follow-up', 'YES', 'Oncology'),
(73, 15, '2025-03-15 00:00:00', 'Scheduled', 'Routine checkup', 'NO', NULL),
(74, 3,  '2025-04-24 00:00:00', 'Scheduled', 'Initial consultation', 'NO', NULL),
(75, 9,  '2025-04-25 00:00:00', 'Scheduled', 'Routine checkup', 'YES', 'Pediatrics'),
(76, 8,  '2025-02-28 00:00:00', 'Completed', 'Routine checkup', 'NO', NULL),
(77, 4,  '2025-06-01 00:00:00', 'Cancelled', 'Routine checkup', 'YES', 'ENT'),
(78, 11, '2025-03-19 00:00:00', 'Scheduled', 'Routine checkup', 'NO', NULL),
(79, 14, '2025-05-11 00:00:00', 'Completed', 'Reported mild symptoms', 'YES', 'Dermatology'),
(80, 13, '2025-01-18 00:00:00', 'Completed', 'Follow-up', 'YES', 'Psychiatry'),
(81, 10, '2025-02-21 00:00:00', 'Completed', 'Follow-up', 'YES', 'Oncology'),
(82, 4,  '2025-04-15 00:00:00', 'Scheduled', 'Initial consultation', 'NO', NULL),
(83, 6,  '2025-03-09 00:00:00', 'Scheduled', 'Routine checkup', 'YES', 'Cardiology'),
(84, 1,  '2025-01-31 00:00:00', 'Completed', 'Routine checkup', 'YES', 'Psychiatry'),
(85, 15, '2025-04-03 00:00:00', 'Cancelled', 'Initial consultation', 'NO', NULL),
(86, 9,  '2025-03-23 00:00:00', 'Scheduled', 'Follow-up', 'YES', 'ENT'),
(87, 11, '2025-02-19 00:00:00', 'Completed', 'Routine checkup', 'NO', NULL),
(88, 7,  '2025-06-01 00:00:00', 'Scheduled', 'Routine checkup', 'YES', 'Dermatology'),
(89, 3,  '2025-04-29 00:00:00', 'Completed', 'Initial consultation', 'NO', NULL),
(90, 12, '2025-03-16 00:00:00', 'Scheduled', 'Follow-up', 'YES', 'Neurology'),
(91, 14, '2025-05-02 00:00:00', 'Completed', 'Reported mild symptoms', 'NO', NULL),
(92, 5,  '2025-02-12 00:00:00', 'Cancelled', 'Routine checkup', 'NO', NULL),
(93, 13, '2025-04-19 00:00:00', 'Scheduled', 'Initial consultation', 'YES', 'Gastroenterology'),
(94, 2,  '2025-01-25 00:00:00', 'Completed', 'Reported mild symptoms', 'YES', 'General Medicine'),
(95, 8,  '2025-05-06 00:00:00', 'Scheduled', 'Routine checkup', 'NO', NULL),
(96, 6,  '2025-03-03 00:00:00', 'Completed', 'Follow-up', 'YES', 'Orthopedics'),
(97, 4,  '2025-01-12 00:00:00', 'Cancelled', 'Routine checkup', 'NO', NULL),
(98, 10, '2025-04-08 00:00:00', 'Completed', 'Routine checkup', 'YES', 'Pediatrics'),
(99, 11, '2025-06-12 00:00:00', 'Scheduled', 'Initial consultation', 'YES', 'Dermatology'),
(100, 1, '2025-03-25 00:00:00', 'Completed', 'Follow-up', 'NO', NULL);


INSERT INTO Patients (
  Patient_Name, AGE, DOB, Blood_Group, Gender,
  Patient_Mobile_Number, Patient_Email, Address,
  Appointment_Date_AND_TIME, Disease
) VALUES
('Rahul Verma', 34, '1991-09-18', 'O+', 'Male', 9000001061, 'rahul.verma61@example.com', 'Delhi', '2025-01-12 10:00:00', 'Fever'),
('Sneha Iyer', 29, '1995-06-20', 'A-', 'Female', 9000001062, 'sneha.iyer62@example.com', 'Mumbai', '2025-02-05 09:30:00', 'Cold'),
('Aman Khan', 42, '1983-03-14', 'B+', 'Male', 9000001063, 'aman.khan63@example.com', 'Chennai', '2025-03-01 14:00:00', 'Back pain'),
('Pooja Sharma', 26, '1998-01-25', 'AB+', 'Female', 9000001064, 'pooja.sharma64@example.com', 'Kolkata', '2025-01-20 12:15:00', 'UTI'),
('Karan Mehta', 38, '1986-07-07', 'O-', 'Male', 9000001065, 'karan.mehta65@example.com', 'Bangalore', '2025-02-18 11:45:00', 'Asthma'),
('Neha Joshi', 31, '1993-11-02', 'A+', 'Female', 9000001066, 'neha.joshi66@example.com', 'Ahmedabad', '2025-01-28 15:30:00', 'Migraine'),
('Vikram Reddy', 47, '1977-12-11', 'B-', 'Male', 9000001067, 'vikram.reddy67@example.com', 'Lucknow', '2025-02-15 16:00:00', 'Hypertension'),
('Anjali Nair', 36, '1988-05-10', 'A+', 'Female', 9000001068, 'anjali.nair68@example.com', 'Bhopal', '2025-03-08 09:00:00', 'Diabetes'),
('Rohit Kapoor', 29, '1995-08-19', 'AB-', 'Male', 9000001069, 'rohit.kapoor69@example.com', 'Jaipur', '2025-04-11 14:30:00', 'Thyroid'),
('Kavya Das', 33, '1991-04-05', 'O+', 'Female', 9000001070, 'kavya.das70@example.com', 'Patna', '2025-02-24 13:15:00', 'Fever'),

('Siddharth Iyer', 30, '1994-12-03', 'B+', 'Male', 9000001071, 'siddharth.iyer71@example.com', 'Delhi', '2025-01-19 10:00:00', 'Cold'),
('Riya Shetty', 27, '1997-06-22', 'A-', 'Female', 9000001072, 'riya.shetty72@example.com', 'Mumbai', '2025-05-01 10:45:00', 'Migraine'),
('Yash Jain', 35, '1989-02-14', 'AB+', 'Male', 9000001073, 'yash.jain73@example.com', 'Chennai', '2025-04-06 11:00:00', 'Back pain'),
('Meena George', 40, '1984-10-30', 'B-', 'Female', 9000001074, 'meena.george74@example.com', 'Kolkata', '2025-02-02 09:30:00', 'Asthma'),
('Tariq Patel', 45, '1979-09-12', 'O-', 'Male', 9000001075, 'tariq.patel75@example.com', 'Bangalore', '2025-03-15 16:30:00', 'Hypertension'),
('Divya Singh', 32, '1992-07-07', 'A+', 'Female', 9000001076, 'divya.singh76@example.com', 'Ahmedabad', '2025-01-25 12:30:00', 'UTI'),
('Imran Verma', 39, '1985-01-01', 'B+', 'Male', 9000001077, 'imran.verma77@example.com', 'Lucknow', '2025-02-12 14:00:00', 'Diabetes'),
('Nisha Khan', 28, '1996-03-18', 'AB-', 'Female', 9000001078, 'nisha.khan78@example.com', 'Bhopal', '2025-05-12 10:15:00', 'Fever'),
('Deepak Mehta', 37, '1987-11-25', 'O+', 'Male', 9000001079, 'deepak.mehta79@example.com', 'Jaipur', '2025-03-05 13:45:00', 'Migraine'),
('Tanvi Joshi', 29, '1995-09-09', 'A-', 'Female', 9000001080, 'tanvi.joshi80@example.com', 'Patna', '2025-04-18 15:00:00', 'Allergy'),

('Aakash Sharma', 44, '1980-04-12', 'A+', 'Male', 9000001081, 'aakash.sharma81@example.com', 'Delhi', '2025-01-22 09:00:00', 'Thyroid'),
('Priya Das', 36, '1988-06-14', 'O+', 'Female', 9000001082, 'priya.das82@example.com', 'Mumbai', '2025-02-20 10:30:00', 'Diabetes'),
('Rohan Khan', 33, '1991-02-28', 'B-', 'Male', 9000001083, 'rohan.khan83@example.com', 'Chennai', '2025-03-18 11:45:00', 'UTI'),
('Sana Verma', 30, '1994-08-08', 'AB+', 'Female', 9000001084, 'sana.verma84@example.com', 'Kolkata', '2025-04-24 14:15:00', 'Allergy'),
('Vivek Shetty', 38, '1986-03-19', 'O-', 'Male', 9000001085, 'vivek.shetty85@example.com', 'Bangalore', '2025-05-08 16:00:00', 'Back pain'),
('Priti Nair', 27, '1997-01-11', 'A-', 'Female', 9000001086, 'priti.nair86@example.com', 'Ahmedabad', '2025-01-30 13:00:00', 'Fever'),
('Aditya Kapoor', 31, '1993-12-17', 'B+', 'Male', 9000001087, 'aditya.kapoor87@example.com', 'Lucknow', '2025-02-25 15:30:00', 'Cold'),
('Ankita Jain', 29, '1995-05-06', 'AB-', 'Female', 9000001088, 'ankita.jain88@example.com', 'Bhopal', '2025-03-29 10:00:00', 'UTI'),
('Mohit George', 35, '1989-10-01', 'O+', 'Male', 9000001089, 'mohit.george89@example.com', 'Jaipur', '2025-04-10 12:30:00', 'Hypertension'),
('Rekha Patel', 28, '1996-12-20', 'A+', 'Female', 9000001090, 'rekha.patel90@example.com', 'Patna', '2025-05-03 09:30:00', 'Migraine'),

('Rakesh Singh', 41, '1983-07-15', 'B+', 'Male', 9000001091, 'rakesh.singh91@example.com', 'Delhi', '2025-02-06 10:00:00', 'Thyroid'),
('Sonal Verma', 33, '1991-03-27', 'O-', 'Female', 9000001092, 'sonal.verma92@example.com', 'Mumbai', '2025-01-17 11:15:00', 'Allergy'),
('Nitin Khan', 37, '1987-06-09', 'A-', 'Male', 9000001093, 'nitin.khan93@example.com', 'Chennai', '2025-02-14 14:45:00', 'Back pain'),
('Kriti Joshi', 26, '1998-09-23', 'AB+', 'Female', 9000001094, 'kriti.joshi94@example.com', 'Kolkata', '2025-03-04 13:30:00', 'Fever'),
('Zaid Mehta', 30, '1994-11-07', 'B-', 'Male', 9000001095, 'zaid.mehta95@example.com', 'Bangalore', '2025-04-20 15:45:00', 'Cold'),
('Shalini Iyer', 34, '1990-01-02', 'O+', 'Female', 9000001096, 'shalini.iyer96@example.com', 'Ahmedabad', '2025-05-14 11:00:00', 'Diabetes'),
('Ravindra Shetty', 46, '1978-05-05', 'A+', 'Male', 9000001097, 'ravindra.shetty97@example.com', 'Lucknow', '2025-03-20 10:45:00', 'UTI'),
('Anita Kapoor', 39, '1985-02-16', 'AB-', 'Female', 9000001098, 'anita.kapoor98@example.com', 'Bhopal', '2025-01-09 12:00:00', 'Hypertension'),
('Dhruv Jain', 32, '1992-04-28', 'O-', 'Male', 9000001099, 'dhruv.jain99@example.com', 'Jaipur', '2025-04-13 14:00:00', 'Migraine'),
('Kiran George', 28, '1996-02-13', 'A-', 'Female', 9000001100, 'kiran.george100@example.com', 'Patna', '2025-02-22 09:15:00', 'Fever');

SELECT * FROM Doctors WHERE Specialize_IN_Surgery LIKE 'YES';
SELECT * FROM Patients;
SELECT * FROM Patients WHERE Appointment_Date_AND_TIME 

Domain: Healthcare
Context: Tracking patients, doctors, and appointments.

Assignment Tasks -1:

1.      Create Patients, Doctors, and Appointments tables with appropriate columns.

2.      Add foreign key constraints to link Appointments with Patients and Doctors.

3.      Write a query to fetch all upcoming appointments for a specific doctor.

4.      List patients who have visited the hospital in the last 6 months.

5.      Update appointment status to 'Completed' once the scheduled date is past today.













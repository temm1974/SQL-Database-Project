-- ANSWERS ---
DROP DATABASE IF EXISTS `Vehicle_Breakdown`;
CREATE DATABASE `Vehicle_Breakdown`;
USE `Vehicle_Breakdown`;


-- TASK1 Create Member Table
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20),
    Member_Location VARCHAR(20),
    Member_Age INT
);

-- Create Vehicle Table
CREATE TABLE Vehicle (
    Vehicle_Registration VARCHAR(10) PRIMARY KEY,
    Vehicle_Make VARCHAR(10),
    Vehicle_Model VARCHAR(10),
    Member_ID INT,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID)
);

-- Create Engineer Table
CREATE TABLE Engineer (
    Engineer_ID INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20)
);

-- Create Breakdown Table
CREATE TABLE Breakdown (
    Breakdown_ID INT PRIMARY KEY,
    Vehicle_Registration VARCHAR(10),
    Engineer_ID INT,
    Breakdown_Date DATE,
    Breakdown_Time TIME,
    Breakdown_Location VARCHAR(20),
    FOREIGN KEY (Vehicle_Registration) REFERENCES Vehicle(Vehicle_Registration),
    FOREIGN KEY (Engineer_ID) REFERENCES Engineer(Engineer_ID)
);

-- Ensure foreign keys using ALTER (if necessary)
ALTER TABLE Vehicle ADD CONSTRAINT fk_member_id FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID);
ALTER TABLE Breakdown ADD CONSTRAINT fk_vehicle_registration FOREIGN KEY (Vehicle_Registration) REFERENCES Vehicle(Vehicle_Registration);
ALTER TABLE Breakdown ADD CONSTRAINT fk_engineer_id FOREIGN KEY (Engineer_ID) REFERENCES Engineer(Engineer_ID);

-- TASK2 Insert data into Member Table
INSERT INTO Member (Member_ID, First_Name, Last_Name, Member_Location, Member_Age)
VALUES
(1, 'John', 'Doe', 'New York', 34),
(2, 'Jane', 'Smith', 'Los Angeles', 28),
(3, 'Alice', 'Johnson', 'Chicago', 45),
(4, 'Bob', 'Brown', 'Houston', 52),
(5, 'Charlie', 'Davis', 'Phoenix', 38);

-- Insert data into Vehicle Table
INSERT INTO Vehicle (Vehicle_Registration, Vehicle_Make, Vehicle_Model, Member_ID)
VALUES
('ABC123', 'Toyota', 'Camry', 1),
('XYZ789', 'Honda', 'Civic', 2),
('LMN456', 'Ford', 'Focus', 3),
('PQR678', 'Toyota', 'Corolla', 4),
('JKL234', 'Honda', 'CRV', 1),
('STU987', 'Nissan', 'Altima', 5),
('VWX135', 'Ford', 'Fusion', 3),
('EFG321', 'Toyota', 'Prius', 4);

-- Insert data into Engineer Table
INSERT INTO Engineer (Engineer_ID, First_Name, Last_Name)
VALUES
(1, 'Emily', 'Clark'),
(2, 'James', 'Wilson'),
(3, 'Olivia', 'Taylor');

-- Insert data into Breakdown Table
INSERT INTO Breakdown (Breakdown_ID, Vehicle_Registration, Engineer_ID, Breakdown_Date, Breakdown_Time, Breakdown_Location)
VALUES
(1, 'ABC123', 1, '2023-05-10', '10:00:00', 'New York'),
(2, 'XYZ789', 2, '2023-06-15', '12:30:00', 'Los Angeles'),
(3, 'LMN456', 1, '2023-07-20', '09:15:00', 'Chicago'),
(4, 'ABC123', 2, '2023-07-20', '15:45:00', 'New York'), -- Same day as another breakdown
(5, 'PQR678', 3, '2023-08-25', '08:00:00', 'Houston'),
(6, 'JKL234', 2, '2023-09-10', '14:00:00', 'New York'),
(7, 'STU987', 1, '2023-05-10', '17:30:00', 'Phoenix'), -- Same day as another breakdown
(8, 'ABC123', 3, '2023-06-15', '11:00:00', 'New York'), -- Same month as other breakdowns
(9, 'VWX135', 1, '2023-09-10', '18:30:00', 'Chicago'),
(10, 'PQR678', 3, '2023-08-25', '07:30:00', 'Houston'), -- Vehicle breakdown more than once
(11, 'EFG321', 2, '2023-10-05', '19:15:00', 'Houston'),
(12, 'STU987', 1, '2023-09-20', '20:45:00', 'Phoenix'); -- Vehicle breakdown more than once

--- TASK4 ---
SELECT * FROM Member LIMIT 3;
SELECT * FROM Member LIMIT 3 OFFSET 2;
SELECT * FROM Vehicle WHERE Vehicle_Make LIKE 'T%';
SELECT * FROM Breakdown WHERE Breakdown_Date BETWEEN '2023-01-01' AND '2023-06-30';
SELECT * FROM Vehicle WHERE Vehicle_Registration IN ('ABC123', 'XYZ789', 'ANZ789');
SELECT Vehicle_Registration, COUNT(*) AS Breakdown_Count 
FROM Breakdown 
GROUP BY Vehicle_Registration;
SELECT * FROM Member ORDER BY Member_Age DESC;
SELECT * FROM Vehicle WHERE (Vehicle_Make = 'Toyota' OR Vehicle_Make = 'Honda') AND Vehicle_Model LIKE 'C%';
SELECT Engineer.First_Name, Engineer.Last_Name 
FROM Engineer 
LEFT JOIN Breakdown ON Engineer.Engineer_ID = Breakdown.Engineer_ID 
WHERE Breakdown.Engineer_ID IS NULL;
SELECT * FROM Member WHERE Member_Age BETWEEN 25 AND 40;
SELECT * FROM Member WHERE First_Name LIKE 'J%' AND Last_Name LIKE '%son%';
SELECT * FROM Member ORDER BY Member_Age DESC LIMIT 5;
SELECT UPPER(Vehicle_Registration) AS Vehicle_Registration FROM Vehicle;
SELECT Member.First_Name, Member.Last_Name, Vehicle.Vehicle_Registration, Vehicle.Vehicle_Make, Vehicle.Vehicle_Model 
FROM Member 
JOIN Vehicle ON Member.Member_ID = Vehicle.Member_ID;
SELECT Member.First_Name, Member.Last_Name, Vehicle.Vehicle_Registration, Vehicle.Vehicle_Make, Vehicle.Vehicle_Model 
FROM Member 
LEFT JOIN Vehicle ON Member.Member_ID = Vehicle.Member_ID;
SELECT Vehicle.Vehicle_Registration, Vehicle.Vehicle_Make, Vehicle.Vehicle_Model, Member.First_Name, Member.Last_Name 
FROM Vehicle 
LEFT JOIN Member ON Vehicle.Member_ID = Member.Member_ID;
SELECT Member.First_Name, Member.Last_Name, COUNT(Breakdown.Breakdown_ID) AS Breakdown_Count 
FROM Member 
JOIN Vehicle ON Member.Member_ID = Vehicle.Member_ID 
JOIN Breakdown ON Vehicle.Vehicle_Registration = Breakdown.Vehicle_Registration 
GROUP BY Member.Member_ID;
SELECT Breakdown.Breakdown_ID, Member.First_Name, Member.Last_Name, Breakdown.Breakdown_Date, Breakdown.Breakdown_Time, Breakdown.Breakdown_Location 
FROM Breakdown 
JOIN Vehicle ON Breakdown.Vehicle_Registration = Vehicle.Vehicle_Registration 
JOIN Member ON Vehicle.Member_ID = Member.Member_ID 
WHERE Member.Member_Age > 50;

--- TASK5 ---
SELECT AVG(Salary) AS Average_Salary FROM Employees;
SELECT MAX(Salary) AS Highest_Salary FROM Employees;
SELECT MIN(Salary) AS Lowest_Salary FROM Employees;
SELECT SUM(Salary) AS Total_Salary FROM Employees;

---- TASK6 ----
UPDATE Engineer SET Last_Name = 'Thompson' WHERE Engineer_ID = 1;
UPDATE Engineer SET First_Name = 'Michael' WHERE Engineer_ID = 2;
UPDATE Engineer SET Last_Name = 'Davis' WHERE Engineer_ID = 3;

DELETE FROM Breakdown WHERE Breakdown_ID = 11;
DELETE FROM Breakdown WHERE Breakdown_ID = 12;




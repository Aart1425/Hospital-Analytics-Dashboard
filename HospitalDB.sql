CREATE TABLE Departments(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100)
);

CREATE TABLE Patients(
PatientID INT PRIMARY KEY,
PatientName VARCHAR(100),
Gender VARCHAR(20),
Age INT,
City VARCHAR(100),
ContactNo VARCHAR(20)
);

CREATE TABLE Doctors(
DoctorID INT PRIMARY KEY,
DoctorName VARCHAR(100),
DepartmentID INT,
Specialization VARCHAR(100),
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

CREATE TABLE Admissions(
AdmissionID INT PRIMARY KEY,
PatientID INT,
DoctorID INT,
DepartmentID INT,
AdmitDate DATE,
DischargeDate DATE,
Diagnosis VARCHAR(200),
FOREIGN KEY (PatientID)
REFERENCES Patients(PatientID),
FOREIGN KEY (DoctorID)
REFERENCES Doctors(DoctorID),
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
);

CREATE TABLE Billing(
BillID INT PRIMARY KEY,
AdmissionID INT,
TreatmentCost DECIMAL(12,2),
MedicineCost DECIMAL(12,2),
RoomCharge DECIMAL(12,2),
TotalAmount DECIMAL(12,2),
PaymentStatus VARCHAR(20),
FOREIGN KEY(AdmissionID)
REFERENCES Admissions(AdmissionID)
);                

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Pediatrics'),
(5, 'Dermatology');

INSERT INTO Patients
(PatientID, PatientName, Gender, Age, City, ContactNo)
SELECT
    gs,
    'Patient_' || gs,
    CASE
        WHEN gs % 2 = 0 THEN 'Male'
        ELSE 'Female'
    END,
    20 + (gs % 50),
    'City_' || ((gs % 10) + 1),
    '98765' || LPAD(gs::TEXT, 5, '0')
FROM generate_series(1, 200) AS gs;

SELECT COUNT(*) FROM Departments;
SELECT COUNT(*) FROM Patients;
SELECT COUNT(*) FROM Doctors;
SELECT COUNT(*) FROM Admissions;
SELECT COUNT(*) FROM Billing;

INSERT INTO Doctors (DoctorID, DoctorName, DepartmentID, Specialization)
SELECT
    gs,
    'Doctor_' || gs,
    ((gs - 1) % 5) + 1,
    CASE
        WHEN ((gs - 1) % 5) + 1 = 1 THEN 'Cardiologist'
        WHEN ((gs - 1) % 5) + 1 = 2 THEN 'Neurologist'
        WHEN ((gs - 1) % 5) + 1 = 3 THEN 'Orthopedic'
        WHEN ((gs - 1) % 5) + 1 = 4 THEN 'Pediatrician'
        ELSE 'Dermatologist'
    END
FROM generate_series(1, 20) AS gs;

INSERT INTO Admissions
(AdmissionID, PatientID, DoctorID, DepartmentID,
 AdmitDate, DischargeDate, Diagnosis)

SELECT
    gs,
    ((gs - 1) % 200) + 1,     -- Patient IDs 1 to 200
    ((gs - 1) % 20) + 1,      -- Doctor IDs 1 to 20
    ((gs - 1) % 5) + 1,       -- Department IDs 1 to 5

    CURRENT_DATE - ((gs % 365) * INTERVAL '1 day'),

    CURRENT_DATE - ((gs % 365) * INTERVAL '1 day')
    + ((gs % 10) + 1) * INTERVAL '1 day',

    CASE
        WHEN ((gs - 1) % 5) + 1 = 1 THEN 'Heart Disease'
        WHEN ((gs - 1) % 5) + 1 = 2 THEN 'Migraine'
        WHEN ((gs - 1) % 5) + 1 = 3 THEN 'Bone Fracture'
        WHEN ((gs - 1) % 5) + 1 = 4 THEN 'Fever'
        ELSE 'Skin Allergy'
    END

FROM generate_series(1, 500) AS gs;

INSERT INTO Admissions
(AdmissionID, PatientID, DoctorID, DepartmentID,
 AdmitDate, DischargeDate, Diagnosis)
VALUES

(501, 1, 1, 1, '2026-05-01', '2026-05-03', 'Heart Checkup'),
(502, 2, 1, 1, '2026-05-02', '2026-05-04', 'Chest Pain'),
(503, 3, 1, 1, '2026-05-03', '2026-05-05', 'Blood Pressure'),
(504, 4, 1, 1, '2026-05-04', '2026-05-06', 'Heart Disease'),
(505, 5, 1, 1, '2026-05-05', '2026-05-07', 'Heart Checkup'),
(506, 6, 1, 1, '2026-05-06', '2026-05-08', 'Chest Pain'),
(507, 7, 1, 1, '2026-05-07', '2026-05-09', 'Blood Pressure'),
(508, 8, 1, 1, '2026-05-08', '2026-05-10', 'Heart Disease'),
(509, 9, 1, 1, '2026-05-09', '2026-05-11', 'Heart Checkup'),
(510, 10, 1, 1, '2026-05-10', '2026-05-12', 'Chest Pain'),
(511, 11, 1, 1, '2026-05-11', '2026-05-13', 'Heart Disease'),
(512, 12, 1, 1, '2026-05-12', '2026-05-14', 'Heart Checkup'),
(513, 13, 1, 1, '2026-05-13', '2026-05-15', 'Blood Pressure'),
(514, 14, 1, 1, '2026-05-14', '2026-05-16', 'Chest Pain'),
(515, 15, 1, 1, '2026-05-15', '2026-05-17', 'Heart Disease'),

(516, 16, 2, 2, '2026-05-01', '2026-05-03', 'Migraine'),
(517, 17, 2, 2, '2026-05-02', '2026-05-04', 'Headache'),
(518, 18, 2, 2, '2026-05-03', '2026-05-05', 'Migraine'),
(519, 19, 2, 2, '2026-05-04', '2026-05-06', 'Headache'),
(520, 20, 2, 2, '2026-05-05', '2026-05-07', 'Migraine'),
(521, 21, 2, 2, '2026-05-06', '2026-05-08', 'Headache'),
(522, 22, 2, 2, '2026-05-07', '2026-05-09', 'Migraine'),
(523, 23, 2, 2, '2026-05-08', '2026-05-10', 'Headache'),
(524, 24, 2, 2, '2026-05-09', '2026-05-11', 'Migraine'),
(525, 25, 2, 2, '2026-05-10', '2026-05-12', 'Headache'),

(526, 26, 3, 3, '2026-05-01', '2026-05-04', 'Bone Fracture'),
(527, 27, 3, 3, '2026-05-03', '2026-05-06', 'Knee Pain'),
(528, 28, 3, 3, '2026-05-05', '2026-05-08', 'Bone Fracture'),
(529, 29, 3, 3, '2026-05-07', '2026-05-10', 'Joint Pain'),
(530, 30, 3, 3, '2026-05-09', '2026-05-12', 'Bone Fracture'),
(531, 31, 3, 3, '2026-05-11', '2026-05-14', 'Knee Pain'),

(532, 32, 4, 4, '2026-05-01', '2026-05-03', 'Fever'),
(533, 33, 4, 4, '2026-05-04', '2026-05-06', 'Cold'),
(534, 34, 4, 4, '2026-05-07', '2026-05-09', 'Fever'),

(535, 35, 5, 5, '2026-05-01', '2026-05-03', 'Skin Allergy');

INSERT INTO Billing
(BillID, AdmissionID, TreatmentCost, MedicineCost,
 RoomCharge, TotalAmount, PaymentStatus)

SELECT
    gs,
    gs,  -- AdmissionID (501 to 535)

    ROUND((RANDOM() * 40000 + 10000)::numeric, 2), -- Treatment Cost
    ROUND((RANDOM() * 10000 + 1000)::numeric, 2),  -- Medicine Cost
    ROUND((RANDOM() * 15000 + 2000)::numeric, 2),  -- Room Charge

    ROUND(
        (
            (RANDOM() * 40000 + 10000) +
            (RANDOM() * 10000 + 1000) +
            (RANDOM() * 15000 + 2000)
        )::numeric, 2
    ),

    CASE
        WHEN gs % 2 = 0 THEN 'Paid'
        ELSE 'Pending'
    END

FROM generate_series(1, 500) AS gs;

SELECT * FROM Departments LIMIT 10;
SELECT * FROM Patients LIMIT 10;
SELECT * FROM Doctors LIMIT 10;
SELECT * FROM Admissions LIMIT 10;
SELECT * FROM Billing LIMIT 10;

SELECT COUNT(*) AS total_patients
FROM patients;

SELECT COUNT(*) AS total_admissions
FROM admissions;

SELECT SUM(totalamount) AS total_revenue
FROM billing;

SELECT ROUND(AVG(treatmentcost), 2) AS average_treatment_cost
FROM billing;

SELECT
    d.doctorname,
    COUNT(a.admissionid) AS total_patients
FROM doctors d
JOIN admissions a
    ON d.doctorid = a.doctorid
GROUP BY d.doctorname
ORDER BY total_patients DESC;

SELECT
    d.doctorname,
    COUNT(a.admissionid) AS total_patients
FROM doctors d
JOIN admissions a
    ON d.doctorid = a.doctorid
GROUP BY d.doctorname
ORDER BY total_patients DESC
LIMIT 5;

SELECT
    dep.DepartmentName,
    COUNT(a.AdmissionID) AS total_admissions,
    COUNT(DISTINCT a.PatientID) AS total_patients,
    ROUND(SUM(b.TotalAmount), 2) AS total_revenue,
    ROUND(AVG(b.TotalAmount), 2) AS average_bill_amount
FROM Departments dep
LEFT JOIN Admissions a
    ON dep.DepartmentID = a.DepartmentID
LEFT JOIN Billing b
    ON a.AdmissionID = b.AdmissionID
GROUP BY
    dep.DepartmentID,
    dep.DepartmentName
ORDER BY total_revenue DESC NULLS LAST;


SELECT
    TO_CHAR(a.AdmitDate, 'Mon YYYY') AS month,
    COUNT(a.AdmissionID) AS total_admissions,
    ROUND(SUM(b.TotalAmount), 2) AS monthly_revenue
FROM Admissions a
JOIN Billing b
    ON a.AdmissionID = b.AdmissionID
GROUP BY
    DATE_TRUNC('month', a.AdmitDate),
    TO_CHAR(a.AdmitDate, 'Mon YYYY')
ORDER BY DATE_TRUNC('month', a.AdmitDate);

SELECT
    PaymentStatus,
    COUNT(*) AS total_bills,
    ROUND(SUM(TotalAmount), 2) AS total_amount
FROM Billing
GROUP BY PaymentStatus
ORDER BY total_amount DESC;

SELECT
    d.DoctorID,
    d.DoctorName,
    dep.DepartmentName,
    COUNT(a.AdmissionID) AS total_admissions,
    COUNT(DISTINCT a.PatientID) AS total_patients,
    ROUND(SUM(b.TotalAmount), 2) AS total_revenue,
    ROUND(AVG(b.TotalAmount), 2) AS average_revenue_per_admission
FROM Doctors d
LEFT JOIN Admissions a
    ON d.DoctorID = a.DoctorID
LEFT JOIN Departments dep
    ON d.DepartmentID = dep.DepartmentID
LEFT JOIN Billing b
    ON a.AdmissionID = b.AdmissionID
GROUP BY
    d.DoctorID,
    d.DoctorName,
    dep.DepartmentName
ORDER BY total_revenue DESC NULLS LAST
LIMIT 5;

SELECT
    dep.DepartmentID,
    dep.DepartmentName,
    COUNT(a.AdmissionID) AS total_admissions,
    COUNT(DISTINCT a.PatientID) AS total_patients,
    ROUND(COALESCE(SUM(b.TotalAmount), 0), 2) AS total_revenue,
    ROUND(COALESCE(AVG(b.TotalAmount), 0), 2) AS average_bill_amount
FROM Departments dep
LEFT JOIN Admissions a
    ON dep.DepartmentID = a.DepartmentID
LEFT JOIN Billing b
    ON a.AdmissionID = b.AdmissionID
GROUP BY
    dep.DepartmentID,
    dep.DepartmentName
ORDER BY total_revenue DESC NULLS LAST;

TRUNCATE TABLE Billing;

INSERT INTO Billing
(BillID, AdmissionID, TreatmentCost, MedicineCost,
 RoomCharge, TotalAmount, PaymentStatus)

SELECT
    gs,
    gs,

    ROUND((RANDOM() * 40000 + 10000)::numeric, 2),
    ROUND((RANDOM() * 10000 + 1000)::numeric, 2),
    ROUND((RANDOM() * 15000 + 2000)::numeric, 2),

    ROUND(
        (
            (RANDOM() * 40000 + 10000) +
            (RANDOM() * 10000 + 1000) +
            (RANDOM() * 15000 + 2000)
        )::numeric, 2
    ),

    CASE
        WHEN gs % 2 = 0 THEN 'Paid'
        ELSE 'Pending'
    END

FROM generate_series(1, 500) AS gs;

SELECT datname
FROM pg_database;

DELETE FROM admissions
WHERE admissionid > 500;

UPDATE Patients p
SET PatientName = v.PatientName
FROM (
VALUES
(1,'John Smith'),
(2,'Sam Wilson'),
(3,'Emma Johnson'),
(4,'Sophia Brown'),
(5,'Liam Davis'),
(6,'Olivia Miller'),
(7,'Noah Garcia'),
(8,'Ava Martinez'),
(9,'William Anderson'),
(10,'Mia Thomas'),
(11,'James Taylor'),
(12,'Charlotte Moore'),
(13,'Benjamin Jackson'),
(14,'Amelia White'),
(15,'Lucas Harris'),
(16,'Harper Martin'),
(17,'Henry Thompson'),
(18,'Evelyn Clark'),
(19,'Alexander Lewis'),
(20,'Abigail Walker'),
(21,'Daniel Hall'),
(22,'Grace Allen'),
(23,'Matthew Young'),
(24,'Ella King'),
(25,'Joseph Wright'),
(26,'Scarlett Scott'),
(27,'David Green'),
(28,'Chloe Adams'),
(29,'Michael Baker'),
(30,'Lily Nelson'),
(31,'Andrew Carter'),
(32,'Zoe Mitchell'),
(33,'Christopher Perez'),
(34,'Hannah Roberts'),
(35,'Joshua Turner'),
(36,'Aria Phillips'),
(37,'Anthony Campbell'),
(38,'Layla Parker'),
(39,'Ryan Evans'),
(40,'Nora Edwards'),
(41,'Nathan Collins'),
(42,'Victoria Stewart'),
(43,'Christian Sanchez'),
(44,'Lucy Morris'),
(45,'Jonathan Rogers'),
(46,'Brooklyn Reed'),
(47,'Aaron Cook'),
(48,'Stella Morgan'),
(49,'Adam Bell'),
(50,'Paisley Murphy'),
(51,'Aiden Bailey'),
(52,'Claire Rivera'),
(53,'Ethan Cooper'),
(54,'Maya Richardson'),
(55,'Logan Cox'),
(56,'Leah Howard'),
(57,'Isaac Ward'),
(58,'Anna Torres'),
(59,'Jack Peterson'),
(60,'Sarah Gray'),
(61,'Julian Ramirez'),
(62,'Ruby James'),
(63,'Levi Watson'),
(64,'Alice Brooks'),
(65,'Dylan Kelly'),
(66,'Bella Sanders'),
(67,'Gabriel Price'),
(68,'Madison Bennett'),
(69,'Samuel Wood'),
(70,'Sophie Barnes'),
(71,'Caleb Ross'),
(72,'Isabella Henderson'),
(73,'Owen Coleman'),
(74,'Natalie Jenkins'),
(75,'Luke Perry'),
(76,'Julia Powell'),
(77,'Mason Long'),
(78,'Eva Patterson'),
(79,'Nathaniel Hughes'),
(80,'Aurora Flores'),
(81,'Jason Washington'),
(82,'Hailey Butler'),
(83,'Thomas Simmons'),
(84,'Savannah Foster'),
(85,'Charles Gonzales'),
(86,'Naomi Bryant'),
(87,'Isaiah Alexander'),
(88,'Audrey Russell'),
(89,'Eli Griffin'),
(90,'Katherine Diaz'),
(91,'Jeremiah Hayes'),
(92,'Claire Myers'),
(93,'Connor Ford'),
(94,'Allison Hamilton'),
(95,'Adrian Graham'),
(96,'Emily Sullivan'),
(97,'Hunter Wallace'),
(98,'Mila Woods'),
(99,'Robert Cole'),
(100,'Penelope West'),
(101,'Nathan Brooks'),
(102,'Sofia Reed'),
(103,'Jason Kelly'),
(104,'Emily Parker'),
(105,'Brandon Rivera'),
(106,'Grace Cooper'),
(107,'Kevin Bailey'),
(108,'Lillian Cox'),
(109,'Justin Howard'),
(110,'Avery Ward'),
(111,'Tyler Torres'),
(112,'Camila Peterson'),
(113,'Zachary Gray'),
(114,'Madelyn Ramirez'),
(115,'Jordan James'),
(116,'Gianna Watson'),
(117,'Austin Brooks'),
(118,'Elena Kelly'),
(119,'Jose Sanders'),
(120,'Hazel Price'),
(121,'Juan Bennett'),
(122,'Violet Barnes'),
(123,'Charles Ross'),
(124,'Nova Henderson'),
(125,'Thomas Coleman'),
(126,'Ivy Jenkins'),
(127,'Sebastian Perry'),
(128,'Willow Powell'),
(129,'Jason Long'),
(130,'Luna Patterson'),
(131,'Cameron Hughes'),
(132,'Zoey Flores'),
(133,'Evan Washington'),
(134,'Riley Butler'),
(135,'Connor Simmons'),
(136,'Aria Foster'),
(137,'Xavier Bryant'),
(138,'Bella Russell'),
(139,'Parker Griffin'),
(140,'Stella Diaz'),
(141,'Easton Hayes'),
(142,'Lucy Myers'),
(143,'Cooper Ford'),
(144,'Anna Hamilton'),
(145,'Jaxon Graham'),
(146,'Sarah Sullivan'),
(147,'Dominic Wallace'),
(148,'Maya Woods'),
(149,'Leo Cole'),
(150,'Eva West'),
(151,'Hudson Young'),
(152,'Claire Stone'),
(153,'Miles Knight'),
(154,'Alice Dean'),
(155,'Roman Burke'),
(156,'Eva Shaw'),
(157,'Asher Hunter'),
(158,'Lila Dunn'),
(159,'Adam Boyd'),
(160,'Rose Fuller'),
(161,'Elias Grant'),
(162,'Faith Black'),
(163,'Greyson Walsh'),
(164,'Piper Hart'),
(165,'Lincoln Wells'),
(166,'Sadie Lane'),
(167,'Carson Rice'),
(168,'Maria Day'),
(169,'Ezra Armstrong'),
(170,'Eva Bishop'),
(171,'Nathan Cross'),
(172,'Isla Payne'),
(173,'Aaron Porter'),
(174,'Jade Perry'),
(175,'Christian Hudson'),
(176,'Ariana Ray'),
(177,'Colton Miles'),
(178,'Sarah Lane'),
(179,'Diego Fox'),
(180,'Clara Hunt'),
(181,'Ian Fisher'),
(182,'Ruby Barnes'),
(183,'Jerome Mason'),
(184,'Amy Spencer'),
(185,'Victor Dean'),
(186,'Sienna Hart'),
(187,'Bryan Cole'),
(188,'Nina Woods'),
(189,'Patrick Stone'),
(190,'Eva Reed'),
(191,'George Knight'),
(192,'Megan Burke'),
(193,'Scott Shaw'),
(194,'Rachel Hunter'),
(195,'Shawn Boyd'),
(196,'Lauren Fuller'),
(197,'Dennis Grant'),
(198,'Paige Black'),
(199,'Eric Walsh'),
(200,'Kayla Wells')
) AS v(PatientID, PatientName)
WHERE p.PatientID = v.PatientID;

SELECT PatientID, PatientName
FROM Patients
LIMIT 20;

UPDATE Doctors d
SET DoctorName = v.DoctorName
FROM (
VALUES
(1,'Dr. Rajesh Kumar'),
(2,'Dr. Priya Sharma'),
(3,'Dr. Arjun Reddy'),
(4,'Dr. Ananya Singh'),
(5,'Dr. Vikram Patel'),
(6,'Dr. Meera Nair'),
(7,'Dr. Kiran Rao'),
(8,'Dr. Neha Gupta'),
(9,'Dr. Rahul Verma'),
(10,'Dr. Sneha Iyer'),
(11,'Dr. Rohan Das'),
(12,'Dr. Pooja Menon'),
(13,'Dr. Aditya Joshi'),
(14,'Dr. Kavya Shetty'),
(15,'Dr. Suresh Babu'),
(16,'Dr. Divya Rao'),
(17,'Dr. Nikhil Jain'),
(18,'Dr. Aishwarya Rao'),
(19,'Dr. Manish Kapoor'),
(20,'Dr. Deepa Krishnan')
) AS v(DoctorID, DoctorName)
WHERE d.DoctorID = v.DoctorID;

SELECT DoctorID, DoctorName
FROM Doctors
ORDER BY DoctorID;

UPDATE Admissions SET DoctorID = 1 WHERE AdmissionID BETWEEN 1 AND 50;   -- 50 admissions
UPDATE Admissions SET DoctorID = 2 WHERE AdmissionID BETWEEN 51 AND 93;  -- 43 admissions
UPDATE Admissions SET DoctorID = 3 WHERE AdmissionID BETWEEN 94 AND 131; -- 38 admissions
UPDATE Admissions SET DoctorID = 4 WHERE AdmissionID BETWEEN 132 AND 166; -- 35 admissions
UPDATE Admissions SET DoctorID = 5 WHERE AdmissionID BETWEEN 167 AND 198; -- 32 admissions
UPDATE Admissions SET DoctorID = 6 WHERE AdmissionID BETWEEN 199 AND 227; -- 29 admissions
UPDATE Admissions SET DoctorID = 7 WHERE AdmissionID BETWEEN 228 AND 254; -- 27 admissions
UPDATE Admissions SET DoctorID = 8 WHERE AdmissionID BETWEEN 255 AND 279; -- 25 admissions
UPDATE Admissions SET DoctorID = 9 WHERE AdmissionID BETWEEN 280 AND 302; -- 23 admissions
UPDATE Admissions SET DoctorID = 10 WHERE AdmissionID BETWEEN 303 AND 323; -- 21 admissions
UPDATE Admissions SET DoctorID = 11 WHERE AdmissionID BETWEEN 324 AND 343; -- 20 admissions
UPDATE Admissions SET DoctorID = 12 WHERE AdmissionID BETWEEN 344 AND 362; -- 19 admissions
UPDATE Admissions SET DoctorID = 13 WHERE AdmissionID BETWEEN 363 AND 380; -- 18 admissions
UPDATE Admissions SET DoctorID = 14 WHERE AdmissionID BETWEEN 381 AND 397; -- 17 admissions
UPDATE Admissions SET DoctorID = 15 WHERE AdmissionID BETWEEN 398 AND 413; -- 16 admissions
UPDATE Admissions SET DoctorID = 16 WHERE AdmissionID BETWEEN 414 AND 428; -- 15 admissions
UPDATE Admissions SET DoctorID = 17 WHERE AdmissionID BETWEEN 429 AND 442; -- 14 admissions
UPDATE Admissions SET DoctorID = 18 WHERE AdmissionID BETWEEN 443 AND 455; -- 13 admissions
UPDATE Admissions SET DoctorID = 19 WHERE AdmissionID BETWEEN 456 AND 468; -- 13 admissions
UPDATE Admissions SET DoctorID = 20 WHERE AdmissionID BETWEEN 469 AND 500; -- 32 admissions

SELECT
    d.DoctorName,
    COUNT(a.AdmissionID) AS TotalAdmissions
FROM Doctors d
LEFT JOIN Admissions a
ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorName
ORDER BY TotalAdmissions DESC;
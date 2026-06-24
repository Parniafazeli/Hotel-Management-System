INSERT INTO Employee (FirstName, LastName, HireDate, Salary, PhoneNumber) VALUES
( 'Robert', 'Miller', '2020-02-10', 35000000, '1112223333'),
( 'Linda', 'Garcia', '2021-05-20', 38000000, '2223334444'),
( 'David', 'Rodriguez', '2019-11-01', 65000000, '3334445555'),
('Susan', 'Martinez', '2018-07-15', 70000000, '4445556666'),
( 'Mary', 'Lopez', '2020-09-15', 28000000, '5556667777'),
( 'Charles', 'Gonzalez', '2022-01-20', 27000000, '6667778888'),
( 'Patricia', 'Wilson', '2021-06-10', 29000000, '7778889999'),
( 'Thomas', 'Anderson', '2022-03-05', 26000000, '8889990000'),
( 'Jennifer', 'Taylor', '2020-12-12', 34000000, '9990001111'),
( 'Christopher', 'Moore', '2019-04-18', 68000000, '0001112222');

INSERT INTO Receptionist (EmployeeId, DeskNumber) VALUES
(1, 1),
(2, 2),
(9, 3);
INSERT INTO Manager (EmployeeId) VALUES
(3),
(4),
(10);
INSERT INTO Manager_Department (ManagerID, DepartmentName) VALUES
(3, 'Room Management'),
(3, 'Service Management'),
(4, 'Finance Management'),
(4, 'Reception Management'),
(10, 'Housekeeping Management'),
(10, 'HR Management');
INSERT INTO HouseKeeper (EmployeeId, Shift) VALUES
(5, 'Morning'),
(6, 'Afternoon'),
(7, 'Night'),
(8, 'Morning');

INSERT INTO Room ( RoomNumber, PricePerNight, Type, Floor, Capacity, Status) VALUES
('101', 1200000, 'Single', 1, 1, 'Available'),
('102', 1500000, 'Double', 1, 2, 'Available'),
('103', 1300000, 'Single', 1, 1, 'Occupied'),
('104', 1600000, 'Double', 1, 2, 'Cleaning'),
('201', 2500000, 'Suite', 2, 4, 'Available'),
('202', 2400000, 'Suite', 2, 4, 'Available'),
('203', 1800000, 'Deluxe Double', 2, 2, 'Occupied'),
('204', 2200000, 'Suite', 2, 3, 'Available'),
('301', 900000, 'Economy Single', 3, 1, 'Available'),
( '302', 1100000, 'Single', 3, 1, 'Cleaning');

INSERT INTO Cleaning (HouseKeeperID, RoomID, CleaningDate) VALUES
(5, 1, '2025-03-10'),
(5, 2, '2025-03-11'),
(6, 5, '2025-03-12'),
(7, 3, '2025-03-13'),
(8, 4, '2025-03-14'),
(5, 7, '2025-03-15'),
(6, 8, '2025-03-16'),
(7, 9, '2025-03-17'),
(8, 10, '2025-03-18'),
(5, 6, '2025-03-19');
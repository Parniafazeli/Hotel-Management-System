USE Hotel;


SET IDENTITY_INSERT Guest ON;

INSERT INTO Guest (GuestID, FirstName, LastName, PhoneNumber, Email, BirthDate, Gender, Address, NationalID, RegisterDate) VALUES
(1, 'John', 'Smith', '1234567890', 'john.smith@example.com', '1985-04-12', 'M', '123 Main St, New York, NY 10001', 'US123456789', '2023-01-01'),
(2, 'Emma', 'Johnson', '2345678901', 'emma.johnson@example.com', '1990-08-22', 'F', '456 Oak Ave, Los Angeles, CA 90001', 'US234567890', '2023-02-10'),
(3, 'Michael', 'Brown', '3456789012', 'michael.brown@example.com', '1988-02-10', 'M', '789 Pine Rd, Chicago, IL 60601', 'US345678901', '2023-03-15'),
(4, 'Sophia', 'Davis', '4567890123', 'sophia.davis@example.com', '1992-11-05', 'F', '101 Maple Dr, Houston, TX 77001', 'US456789012', '2023-04-20'),
(5, 'William', 'Wilson', '5678901234', 'william.wilson@example.com', '1980-07-19', 'M', '202 Cedar Ln, Phoenix, AZ 85001', 'US567890123', '2023-05-25'),
(6, 'Olivia', 'Martinez', '6789012345', 'olivia.martinez@example.com', '1995-03-28', 'F', '303 Birch Blvd, Philadelphia, PA 19101', 'US678901234', '2023-06-30'),
(7, 'James', 'Anderson', '7890123456', 'james.anderson@example.com', '1983-12-01', 'M', '404 Walnut St, San Antonio, TX 78201', 'US789012345', '2023-07-05'),
(8, 'Isabella', 'Taylor', '8901234567', 'isabella.taylor@example.com', '1998-09-17', 'F', '505 Spruce Ave, San Diego, CA 92101', 'US890123456', '2023-08-10'),
(9, 'Benjamin', 'Thomas', '9012345678', 'benjamin.thomas@example.com', '1975-06-25', 'M', '606 Elm St, Dallas, TX 75201', 'US901234567', '2023-09-15'),
(10, 'Mia', 'Hernandez', '0123456789', 'mia.hernandez@example.com', '2000-01-01', 'F', '707 Ash Dr, San Jose, CA 95101', 'US012345678', '2023-10-20');

SET IDENTITY_INSERT Guest OFF;


INSERT INTO Review ( GuestID, Comments, Rating, Review_Date) VALUES
( 1, 'Excellent hotel, great service', 5, '2025-01-15'),
( 2, 'Clean room, average breakfast', 4, '2025-02-10'),
( 3, 'Cancelled, no experience', 3, '2025-03-05'),
( 4, 'Good stay', 4, '2025-03-20'),
( 5, 'Poor cleaning', 2, '2025-04-10'),
( 6, 'Very satisfied', 5, '2025-04-15'),
( 7, 'Good for families', 4, '2025-05-05'),
( 8, 'Reservation date issue', 3, '2025-05-20'),
( 9, 'Cheap and clean', 4, '2025-06-05'),
( 10, 'Good room, weak internet', 3, '2025-06-15');

INSERT INTO Guest_Reservation (GuestID, ReservationID) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
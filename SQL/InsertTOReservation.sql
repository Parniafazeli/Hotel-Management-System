INSERT INTO Reservation (BookerID, CheckInDate, CheckOutDate, ReservationDate, ReservationStatus) VALUES
( 1, '2025-01-10', '2025-01-12', '2025-01-01', 'Confirmed'),
( 2, '2025-02-05', '2025-02-07', '2025-01-20', 'Confirmed'),
( 3, '2025-03-01', '2025-03-03', '2025-02-15', 'Cancelled'),
( 4, '2025-03-10', '2025-03-15', '2025-02-20', 'Confirmed'),
( 5, '2025-04-01', '2025-04-05', '2025-03-01', 'CheckedOut'),
( 6, '2025-04-10', '2025-04-12', '2025-03-10', 'Confirmed'),
( 7, '2025-05-01', '2025-05-03', '2025-04-01', 'Confirmed'),
( 8, '2025-05-10', '2025-05-15', '2025-04-05', 'Pending'),
( 9, '2025-06-01', '2025-06-02', '2025-05-01', 'Confirmed'),
( 10, '2025-06-10', '2025-06-12', '2025-05-10', 'Confirmed');
INSERT INTO Reservation (BookerID, CheckInDate, CheckOutDate, ReservationDate, ReservationStatus) VALUES
(10, '2026-01-12' , '2026-01-15' , '2026-01-10' , 'Confirmed');

INSERT INTO Room_Reservation(RoomID, ReservationID) VALUES
(1,11),
(2,11)
INSERT INTO Guest_Reservation(GuestID,ReservationID) VALUES
(9,11),
(10,11)
INSERT INTO Payment (ReservationID, Payment_Number, Amount, PaymentDate, Payment_Method) VALUES
(1, 1, 3500000, '2025-01-12', 'Credit'),
(2, 1, 3000000, '2025-02-07', 'Cash'),
(4, 1, 5000000, '2025-03-15', 'Credit'),
(5, 1, 4200000, '2025-04-05', 'Cash'),
(6, 1, 2800000, '2025-04-12', 'Credit'),
(7, 1, 3800000, '2025-05-03', 'Credit'),
(8, 1, 6200000, '2025-05-15', 'Pending'),
(9, 1, 1500000, '2025-06-02', 'Cash'),
(10, 1, 3300000, '2025-06-12', 'Credit'),
(1, 2, 500000, '2025-01-15', 'Cash');

INSERT INTO Payment (ReservationID, Payment_Number, Amount, PaymentDate, Payment_Method) VALUES
(11, 1, 1000, '2026-01-12','Credit')

INSERT INTO Invoice ( ReservationID, Payment_Method, PaymentStatus, Issue_Date) VALUES
(11, 'Pending' ,'Pending', '2026-01-13')

INSERT INTO Invoice ( ReservationID, Total_Amount, Payment_Method, Tax_Amount, Issue_Date) VALUES
(1, 3500000, 'Credit', 350000, '2025-01-12'),
(2, 3000000, 'Cash', 300000, '2025-02-07'),
(3, 0, 'None', 0, '2025-03-03'),
(4, 5000000, 'Credit', 500000, '2025-03-15'),
(5, 4200000, 'Cash', 420000, '2025-04-05'),
(6, 2800000, 'Credit', 280000, '2025-04-12'),
(7, 3800000, 'Credit', 380000, '2025-05-03'),
(8, 6200000, 'Pending', 620000, '2025-05-15'),
(9, 1500000, 'Cash', 150000, '2025-06-02'),
(10, 3300000, 'Credit', 330000, '2025-06-12');

INSERT INTO Room_Reservation (RoomID, ReservationID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9),
(1, 10);